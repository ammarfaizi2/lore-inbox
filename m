Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129809AbQKFM6g>; Mon, 6 Nov 2000 07:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbQKFM6S>; Mon, 6 Nov 2000 07:58:18 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:6416 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129192AbQKFM6O>;
	Mon, 6 Nov 2000 07:58:14 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Andrew Morton <andrewm@uow.edu.au>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        "David S. Miller" <davem@redhat.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0 
In-Reply-To: Your message of "Mon, 06 Nov 2000 07:49:00 CDT."
             <3A06A8BC.CE6F651F@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 06 Nov 2000 23:58:05 +1100
Message-ID: <3472.973515485@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Nov 2000 07:49:00 -0500, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>Keith Owens wrote:
>> I prefer a requirement that all net drivers upgrade to the new
>> interface, otherwise we have odd drivers using the old interface
>> forever and being at risk of module unload.  That is why I coded my
>> patch as returning -ENODEV if there was no dev->open.  However I have
>> to accept that just before a 2.4 release is not the best time to have a
>> flag day.  Put it down for 2.5.
>
>What is "it" that gets put off until 2.5?  Breaking net drivers with an
>interface upgrade, or eliminating this race?

Forcing all network drivers to define a dev->open routine.

>There is absolutely no need to break drivers for this.  Not only is it
>needless pain, but doing so is inconsistent -- with struct
>file_operations, I am free to have owner==NULL.

True, but if you set owner==NULL for something that is really in a
module then you are lying to the module layer.  See foot, shoot foot.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
