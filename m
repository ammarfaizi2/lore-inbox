Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265812AbUHFNq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUHFNq3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265946AbUHFNq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:46:29 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:50407 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S265812AbUHFNqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:46:23 -0400
Date: Fri, 6 Aug 2004 15:45:46 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408061345.i76DjkT5005999@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Jens Axboe <axboe@suse.de>

>So I downloaded:

>ftp://ftp.berlios.de/pub/cdrecord/alpha/cdrtools-2.01a35.tar.gz

>and built it, ran scgcheck on a SCSI hard drive. And you pass in
>->mx_sb_len == 16 to the sg driver, so that's why it's not copying more
>than 16 bytes back to you. There are 18 available in that first test
>case. Here's that test case:

>Testing if at least CCS_SENSE_LEN (18) is supported...
>Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 00
>---------->     Method 0x00: expected: 18 reported: 16 max found: 16
>Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 FF FF
>---------->     Method 0xFF: expected: 18 reported: 16 max found: 16
>---------->     Minimum standard (CCS) sense length failed
>---------->     Wanted 18 sense bytes, got (16)
>Testing for 32 bytes of sense data...
>Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 00 00 00
>00 00 00 00 00 00 00 00 00 00 00 00
>---------->     Method 0x00: expected: 32 reported: 16 max found: 16
>Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 FF FF FF FF
>FF FF FF FF FF FF FF FF FF FF FF FF
>---------->     Method 0xFF: expected: 32 reported: 16 max found: 16
>---------->     Wanted 32 sense bytes, got (16)
>----------> Got a maximum of 16 sense bytes
>----------> SCSI sense count test FAILED
>----------> SCSI status byte test NOT YET READY

>Changing your scsi-linux-sg.c to set max sense to 64:

>Testing if at least CCS_SENSE_LEN (18) is supported...
>Sense Data: 70 00 05 00 00 00 00 0A 00 00 00 00 24 00 00 C0 00 03

Wonderful, so you just found another bug in the Linux kernel include files.

To fix: edit sg.h in the Linux kernel source tree and fix the value for
SG_MAX_QUEUE or if you believe you cannot change it, create a new #define
and document it......

BTW: as you did not mention the DMA residual count problem, I asume that
it is still present.


Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
