Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129496AbQKFNKh>; Mon, 6 Nov 2000 08:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129134AbQKFNK1>; Mon, 6 Nov 2000 08:10:27 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18445 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129033AbQKFNKR>;
	Mon, 6 Nov 2000 08:10:17 -0500
Message-ID: <3A06AD88.15640B7D@mandrakesoft.com>
Date: Mon, 06 Nov 2000 08:09:28 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Andrew Morton <andrewm@uow.edu.au>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        "David S. Miller" <davem@redhat.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
In-Reply-To: <3472.973515485@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 06 Nov 2000 07:49:00 -0500,
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Keith Owens wrote:
> >> I prefer a requirement that all net drivers upgrade to the new
> >> interface, otherwise we have odd drivers using the old interface
> >> forever and being at risk of module unload.  That is why I coded my
> >> patch as returning -ENODEV if there was no dev->open.  However I have
> >> to accept that just before a 2.4 release is not the best time to have a
> >> flag day.  Put it down for 2.5.
> >
> >What is "it" that gets put off until 2.5?  Breaking net drivers with an
> >interface upgrade, or eliminating this race?
> 
> Forcing all network drivers to define a dev->open routine.
> 
> >There is absolutely no need to break drivers for this.  Not only is it
> >needless pain, but doing so is inconsistent -- with struct
> >file_operations, I am free to have owner==NULL.
> 
> True, but if you set owner==NULL for something that is really in a
> module then you are lying to the module layer.  See foot, shoot foot.

You are missing the point here.  If a driver is "old style", where
owner==NULL and it manually calls MOD_{INC,DEC}_USE_COUNT, things are
pretty much ok.  There is a tiny race, but the system is mostly intact.

For never drivers "that matter," we update them to set
net_device::owner.  But to me breaking all the net drivers to force such
a change is silly.  For such a tiny race, there just isn't a pressing
need to update the stinkbomb crapola drivers...

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
