Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264097AbUHHIVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbUHHIVz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 04:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUHHIVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 04:21:55 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:10150 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S264097AbUHHIVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 04:21:52 -0400
Date: Sun, 8 Aug 2004 10:21:33 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408080821.i788LXAm007388@burner.fokus.fraunhofer.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	---->	This is a resend as it seems that somebody did remove
		linux-kernel@vger.kernel.org

>From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>

>> I can just that if you set 64KiB now, it'll be a much better alround
>> value.

>very good, it works with 64kB:

>    887         /*
>    888          * First try to raise the DMA limit to a moderate value that
>    889          * most likely does not use up all kernel memory.
>    890          */
>    891         //val = 126*1024;
>    892         val = 64*1024;

>now cdrecord will happily use the scsi-linux-sg driver even for the IDE
>burners connected to the "Digitus" controllers handled by the siimage driver.

So you found a nasty bug in the Linux kernel :-(

The official behavior for SG_SET_RESERVED_SIZE is:

1)	You call SG_SET_RESERVED_SIZE with whatever size val you like

2)	It says "thank you" and _always_ returns success

3)	You call SG_GET_RESERVED_SIZE to read the value set up
	in the kernel. This value is not directly related to the value
	used with SG_SET_RESERVED_SIZE. The proposal from Douglas
	Gilbert was to always use 512 KB. I am unhappy with this behavior
	but I have to take it as it has been defined by the Author :-(
	He told me that the value returned with SG_GET_RESERVED_SIZE
	is the value available for DMA and may be much smaller than
	the size used with SG_SET_RESERVED_SIZE.

AGAIN: I am unhappy with this behavior but this _is_ the official behavior.
If the current Linux kernel for some reasons does not behave this way it
is broken and needs to be fixed.

See also: http://www.mail-archive.com/cdwrite@other.debian.org/msg00232.html

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
