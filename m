Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286750AbRL1FmX>; Fri, 28 Dec 2001 00:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286747AbRL1FmN>; Fri, 28 Dec 2001 00:42:13 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:12263 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S286750AbRL1Flx>; Fri, 28 Dec 2001 00:41:53 -0500
Date: Thu, 27 Dec 2001 21:40:25 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH] current state of the 2.5.1 USB tree
To: "Kevin P. Fleming" <kevin@labsysgrp.com>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <009901c18f62$2723a920$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <20011219104253.A11032@kroah.com>
 <061101c18f35$5e141e60$6800000a@brownell.org>
 <008a01c18f48$beaa3e90$6caaa8c0@kevin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, I would very much like to see EHCI support in a 2.4.x compatible form,
> even if it's not in the mainline kernel. Last time I tried the CVS code, I
> couldn't even get it compile, but maybe things have improved since then (two
> months ago) :-)

I'm surprised you had problems even then, but for a while you
needed a 2.4ac kernel.  Those usbcore changes merged
into Linus' tree at about 2.4.10 and I know folk used that OK.

What was your build problem?  I was going to suggest "try the
CVS ref24 tag", but somehow it's missing most of EHCI (odd).
I'd expect the 1-December code to behave on recent 2.4.x
systems; I certainly used it on 2.4.15 ...

Looks like the best solution is for me to try to build some patch.
It won't be as current as what the 2.5 USB tree has, but maybe the
only major issue can be lack of transaction translator (hub) support.


> I also have a USB 2.0 external hard drive that I'd sure like to see run at
> something higher than 1 megabyte per second <G>

Quite doable ... that was the first device I got working, and it was
a treat to get a dozen times faster than that!  (One person benched
a single drive at over 22 MByte/sec on a 2.4.5/PPC box, one that
I think doesn't have a very fast CPU.)  For now it'll only work on 2.4
since the bio/scsi changes appear to have confused usb-storage.

Also 22 MByte/sec needs smarter scatter/gather I/O in usb-storage,
or making sure SCSI delivers physically contiguous buffers (no I
don't think that one's very realistic :).

- Dave



