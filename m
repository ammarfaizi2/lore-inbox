Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129435AbQKFMuP>; Mon, 6 Nov 2000 07:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129116AbQKFMuG>; Mon, 6 Nov 2000 07:50:06 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:63244 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129092AbQKFMtv>;
	Mon, 6 Nov 2000 07:49:51 -0500
Message-ID: <3A06A8BC.CE6F651F@mandrakesoft.com>
Date: Mon, 06 Nov 2000 07:49:00 -0500
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
In-Reply-To: <3075.973514236@ocs3.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Mon, 06 Nov 2000 05:05:42 -0500,
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >With the latest patch I've seen, there is no -need- to
> >immediately update the drivers.  Once the patch is applied, I can clean
> >the drivers while I'm cleaning up request_region and the other stuff.
> 
> I prefer a requirement that all net drivers upgrade to the new
> interface, otherwise we have odd drivers using the old interface
> forever and being at risk of module unload.  That is why I coded my
> patch as returning -ENODEV if there was no dev->open.  However I have
> to accept that just before a 2.4 release is not the best time to have a
> flag day.  Put it down for 2.5.

What is "it" that gets put off until 2.5?  Breaking net drivers with an
interface upgrade, or eliminating this race?

I would prefer that 2.4.0 went out the door with a race-free netdev
interface.

Andrew's patch is nice and small, and doesn't -require- a driver
upgrade.  We can upgrade the important drivers now, and then do all the
stinkbomb crapola drivers during the 2.4.x series or whenever.

There is absolutely no need to break drivers for this.  Not only is it
needless pain, but doing so is inconsistent -- with struct
file_operations, I am free to have owner==NULL.

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
