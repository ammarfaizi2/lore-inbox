Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129058AbRBHDGM>; Wed, 7 Feb 2001 22:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129099AbRBHDGC>; Wed, 7 Feb 2001 22:06:02 -0500
Received: from ausxc06.us.dell.com ([143.166.99.78]:45829 "EHLO
	ausxc06.aus.amer.dell.com") by vger.kernel.org with ESMTP
	id <S129058AbRBHDFt>; Wed, 7 Feb 2001 22:05:49 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9CA2@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: jason@heymax.com, linux-kernel@vger.kernel.org
Cc: gandalf@winds.org
Subject: RE: aacraid 2.4.0 kernel
Date: Wed, 7 Feb 2001 21:03:53 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I see in the archives of this mailing list that someone was 
> working on the
> aacraid driver for the 2.4 kernel however that post was 
> almost 2 months old.

Adaptec is still working on it.  Basically (and as Jason discovered), the
driver and firmware can't handle single I/O requests larger than 64KB.  Even
when scatter/gathered, if the total is >64KB, it chokes.  This was just fine
for 2.2.x (no one has ever run into this problem there), but the
much-improved block layer of 2.4.x throws larger I/Os at the driver.  So,
the developers at Adaptec are busy trying to add support to break large
requests into smaller chunks, and then gather them back together.

> I know Alan Cox denied inclusion of the driver due to the 
> poor nature it was
> written for the 2.2 tree. Every post that I have seen so far 
> has just said
> that Adaptec is working on it.

So, there are three objectives:
1) Get and maintain a working 2.2.x driver.  Yes, Alan Cox doesn't want to
merge this into the stock kernel, so until then, it's available separately,
and several distributions have picked it up, such as Red Hat Linux 7.

2) Get a working 2.4.x driver.  Dell and Adaptec both believe this is
critical.  Again, we don't expect this driver to make it into the 2.4.x
stock kernel, it'll be made available separately to those who want it.  This
is where development time is being spent today.  The best I can say here is
"we hope to have something soon".

3) Develop an aacraid driver for both 2.2.x and 2.4.x that will be accepted
into the stock kernels.  For this to happen, Adaptec engineers will be
re-writing the driver from the ground up as a Linux driver.  Due to schedule
constraints (wanting 2.4.x support sooner rather than later), and because we
didn't expect the 64K issue, this has been delayed until 2) is finished.
Hopefully the 64K limit will be eradicated then too.


I've made a web page http://domsch.com/linux on which I've posted all the
2.2.x aacraid patches, and where I'll post a 2.4.x patch when it's
available.  I've also created an announcements-only mailing list
http://domsch.com/mailman/listinfo/linux-aacraid-announce which you may
subscribe to and receive notices of new driver availability.  I've created a
developers list http://domsch.com/mailman/listinfo/linux-aacraid-devel for
discussion of the driver if you wish to contribute.

Both the web page and mailing lists will likely be moved to a Dell.com
server in the near future.


I hope this helps clarify the situation.  Thank you for your interest and
continued patience.

-- 
Matt Domsch
Dell Linux Systems Group
Linux OS Development
www.dell.com/linux


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
