Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275178AbRJUCWT>; Sat, 20 Oct 2001 22:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275301AbRJUCWK>; Sat, 20 Oct 2001 22:22:10 -0400
Received: from [212.113.174.249] ([212.113.174.249]:35105 "EHLO
	smtp.netcabo.pt") by vger.kernel.org with ESMTP id <S275178AbRJUCWC>;
	Sat, 20 Oct 2001 22:22:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ricardo Ferreira <stormlabs@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Problem  with IRQ sharing and PCI IDE chipsets in 2.4.x kernels
Date: Sun, 21 Oct 2001 03:22:23 +0100
X-Mailer: KMail [version 1.3.5]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <EXCH01SMTP01uZtTjLX0004ecf2@smtp.netcabo.pt>
X-OriginalArrivalTime: 21 Oct 2001 02:19:33.0167 (UTC) FILETIME=[D27263F0:01C159D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I already sent an earlier message with subject "Problem with 2.4.12" , but 
now i looked a bit more into it. I'm having problems burning CDRs in my 
machine (an Abit VP6 with two P3-1Ghz and 1GB SDRAM). The process normally 
fails with these messages from the kernel:

Oct 21 02:37:27 thor kernel: ide-scsi: CoD != 0 in idescsi_pc_intr
Oct 21 02:37:27 thor kernel: hdk: ATAPI reset complete

This is using 2.4.12 mainly, but i tested with 2.4.8 and 2.4.4 and they both 
have the same symptoms.

The CDR drive was first connected to the HPT370 controller which uses the 
same IRQ for the two IDE channels (it has an IBM 60GB UDMA100 on the other 
channel). I then connected the CDR to my Promise ULTRA66 card on the same 
machine (it also shares an IRQ for the two channels) and the same messages 
appeared and the burning was aborted. Just to test if it were because of IRQ 
sharing i the connected the CDR to the VIA onboard controller (which uses a 
distinct unshared IRQ for each channel) and the problem went away. No more 
messages or failed burns.

I think i'm forced to conclude something is wrong with the drivers when 
sharing IRQs or the hardware doesn't support it (which is impossible because 
it always uses the same IRQ for the two channels).

Just for the record, i'm using UDMA66/100 cables to connect all drives. I 
still haven't tested a 2.2.x kernel because my cdrecord has to be recompiled 
to run under 2.2.

This is driving me nuts. At first i thought the HPT370 was flakey but then it 
happened with the Promise also, so it can't be the controller.

Any ideas ?
-- 
[------------------------------------------------][-------------------------]
|"One World, One Web, One Program" - Microsoft Ad||    stormlabs@gmx.net    |
|"Ein Volk, Ein Reich, Ein Fuhrer" - Adolf Hitler||http://storm.superzip.net|
[------------------------------------------------][-------------------------]
       --> thor up 2 days | sentinel up 91 days | loki up 91 days <--
