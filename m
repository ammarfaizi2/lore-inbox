Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266686AbUHUP6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266686AbUHUP6b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 11:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUHUP6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 11:58:31 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:33164 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266686AbUHUP63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 11:58:29 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sat, 21 Aug 2004 17:57:30 +0200
To: schilling@fokus.fraunhofer.de, der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <412770EA.nail9DO11D18Y@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
In-Reply-To: <E1ByXMd-00007M-4A@localhost>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Schmidt <der.eremit@email.de> wrote:

> On Sat, 21 Aug 2004 14:50:08 +0200, you wrote in linux.kernel:
>
> > If the owners and permissions of the filesystem have been set up correctly,
> > then there is no security problem. 
>
> The previous Linux implementation allowed users with *read* access
> to the device to send arbitrary SG_IO commands. Giving read permission

This is of course a kernel bug - but it could be easily fixed.
My scg driver for SunOS requires write permissions since it has been
created in August 1986.


> to normal users is quite common, to allow them to run isosize or play
> their freshly burned SVCDs with mplayer.

So changing the kernel to require write permissions would be a simple fix that
would help without breaking cdrtools as libscg of course opens the devices with 
O_RDWR.

I am not against a long term change that would require euid root too, but this 
should be announced early enough to allow prominent users of the interface to 
keep track of the interface changes.

BTW: the currely used errno EACCESS applies to file permissions while EPERM
applies to process permissions. So EPERM would be a more appropriate errno 
value.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
