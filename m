Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266679AbUHVL5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266679AbUHVL5t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 07:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUHVL5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 07:57:48 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:14807 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266679AbUHVL5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 07:57:43 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Sun, 22 Aug 2004 13:56:44 +0200
To: schilling@fokus.fraunhofer.de, der.eremit@email.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <412889FC.nail9MX1X3XW5@burner>
References: <2ptdY-42Y-55@gated-at.bofh.it>
 <2uPdM-380-11@gated-at.bofh.it> <2uUwL-6VP-11@gated-at.bofh.it>
 <2uWfh-8jo-29@gated-at.bofh.it> <2uXl0-Gt-27@gated-at.bofh.it>
 <2vge2-63k-15@gated-at.bofh.it> <2vgQF-6Ai-39@gated-at.bofh.it>
 <2vipq-7O8-15@gated-at.bofh.it> <2vj2b-8md-9@gated-at.bofh.it>
 <2vDtS-bq-19@gated-at.bofh.it> <E1ByXMd-00007M-4A@localhost>
 <412770EA.nail9DO11D18Y@burner>
In-Reply-To: <412770EA.nail9DO11D18Y@burner>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Let me give some additional remarks to clear up things:

Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> Pascal Schmidt <der.eremit@email.de> wrote:

> > The previous Linux implementation allowed users with *read* access
> > to the device to send arbitrary SG_IO commands. Giving read permission
>
> This is of course a kernel bug - but it could be easily fixed.
> My scg driver for SunOS requires write permissions since it has been
> created in August 1986.

Not checking for Write access permissions at this place is a typical mistake
made by novice programmers, so I never thought this could be in Linux.....


> > to normal users is quite common, to allow them to run isosize or play
> > their freshly burned SVCDs with mplayer.
>
> So changing the kernel to require write permissions would be a simple fix that
> would help without breaking cdrtools as libscg of course opens the devices with 
> O_RDWR.

If Linux still noes not check for write permissions, I would consider there is 
still a bug.

If there is a list of "aparently safe" SCSI commands that are allowed to be 
executed, then there is another bug in Linux. The only SCSI command that could 
be called safe if Test Unit Ready and even this only if not send more then once 
every few seconds.

There are several SCSI commands that look safe but would result in coasters
if issued while a CD or DVD is written.

Conclusion: It makes no sense to start implementing a fine grained security 
model before basic secutity has been done correctly.

The best immediate fix for the problem is to just check for read & write 
permissions on the file descriptor and otherwise revert to how it has been
before 2.6.8.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
