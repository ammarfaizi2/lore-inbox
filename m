Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVH2Q5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVH2Q5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbVH2Q5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:57:22 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:37263 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1750805AbVH2Q5W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:57:22 -0400
Subject: Re: 2.6.13-rc7-rt4, fails to build
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050829083541.GA21756@elte.hu>
References: <1125277360.2678.159.camel@cmn37.stanford.edu>
	 <20050829083541.GA21756@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1125334627.7631.21.camel@cmn37.stanford.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Aug 2005 09:57:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-29 at 01:35, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > I'm getting a build error for 2.6.13-rc7-rt4 with PREEMPT_DESKTOP for 
> > i386:
> 
> hm, cannot reproduce this build problem on my current tree - could you 
> try 2.6.13-rt1? (and please send the 2.6.13-rt1 .config if it still 
> occurs)

I had to redo two chunks (this also happened to me in rc7-rt3):

====
@@ -561,14 +560,12 @@ static u8 ide_dump_ata_status(ide_drive_
 
 static u8 ide_dump_atapi_status(ide_drive_t *drive, const char *msg, u8
stat)
 {
-	unsigned long flags;
-
 	atapi_status_t status;
 	atapi_error_t error;
 
 	status.all = stat;
 	error.all = 0;
-	local_irq_set(flags);
+
 	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (status.b.bsy)
 		printk("Busy ");
@@ -483,10 +484,8 @@ static void ide_dump_opcode(ide_drive_t 
 static u8 ide_dump_ata_status(ide_drive_t *drive, const char *msg, u8
stat)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	unsigned long flags;
 	u8 err = 0;
 
-	local_irq_set(flags);
 	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (stat & BUSY_STAT)
 		printk("Busy ");
====

-- Fernando


