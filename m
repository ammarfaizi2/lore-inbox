Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVCHNxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVCHNxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 08:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVCHNxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 08:53:17 -0500
Received: from iua-mail.upf.es ([193.145.55.10]:35506 "EHLO iua-mail.upf.es")
	by vger.kernel.org with ESMTP id S261948AbVCHNxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 08:53:04 -0500
Date: Tue, 8 Mar 2005 14:52:51 +0100
From: Maarten de Boer <mdeboer@iua.upf.es>
To: linux-kernel@vger.kernel.org
Cc: aic7xxx@freebsd.org
Subject: Adaptec 29160 + Promise Ultratrak100 TX8 problems
Message-Id: <20050308145251.6b73b8b6.mdeboer@iua.upf.es>
Organization: IUA
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.4.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MTG-MailScanner: Found to be clean
X-MTG-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-5.899, required 5, autolearn=not spam,
	ALL_TRUSTED -3.30, BAYES_00 -2.60)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am having nasty problems with an Adaptec 29160 and Promise
Ultratrak100 TX8 external RAID. (kernel 2.6.11)

Initially, I can access the RAID normally. I create a (small, for
testing) partition on it, and an ext3 filesystem. But when I start
writing, in no-time the RAID and the SCSI adapter get into a broken
state, and rebooting both RAID and Linux (simply rmmod/modprobe is not
enough) is the only way out.

I trigger this with a small test like creating 10000 files, or
extracting a kernel tar.gz.

In my /var/log/messages I find:

Mar  8 10:58:22 iua-file-2 kernel: (scsi3:A:0:0): data overrun detected in Data-out phase.  Tag == 0x2.
Mar  8 10:58:22 iua-file-2 kernel: (scsi3:A:0:0): Have seen Data Phase.  Length = 524288.  NumSGs = 33.
Mar  8 10:58:52 iua-file-2 kernel: scsi3:0:0:0: Attempting to queue an ABORT message
Mar  8 10:58:52 iua-file-2 kernel: CDB: 0x2a 0x0 0x0 0x2 0x8c 0x37 0x0 0x4 0x0 0x0
Mar  8 10:58:52 iua-file-2 kernel: scsi3: At time of recovery, card was not paused
Mar  8 10:58:52 iua-file-2 kernel: >>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
Mar  8 10:58:52 iua-file-2 kernel: scsi3: Dumping Card State in Data-out phase,
at SEQADDR 0x17b
Mar  8 10:58:52 iua-file-2 kernel: Card was paused

I have tried changing settings in the adaptec controller BIOS, I tried
lowering the global_tag_depth, all to no avail. And having the reboot
everytime it goes wrong makes trying things rather slow :-(

I googled for the messages, and found many people mentioning them, but
no solution.

I'd very much appreciate your help. Please Cc: me when replying, because
I am not subscribed to the lkml.

Kind regards,

Maarten
