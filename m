Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWHAIgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWHAIgw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750864AbWHAIgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:36:52 -0400
Received: from gimli.datakultur.com ([212.28.216.234]:20459 "EHLO
	gimli.datakultur.com") by vger.kernel.org with ESMTP
	id S1750834AbWHAIgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:36:51 -0400
From: Hans Eklund <hans@rubico.se>
Reply-To: hans@rubico.se
Organization: Rubico AB
To: linux-kernel@vger.kernel.org
Subject: Block request processing for MMC/SD over SPI bus
Date: Tue, 1 Aug 2006 10:37:27 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608011037.27721.hans@rubico.se>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC to hans@rubico.se)

After trying other forums and irc for help on this matter i hope someone on 
the LKML can help.

-Background(skip if short of time).
First linux driver for me and first post on LKML, but in short, i have been 
developing a MMC/SD card driver in SPI mode for uClinux on the Analog Devices 
Blackfin based platform. However, since the 2.6.15 version im moving over to 
the common SPI framework and all code will probably be platform independent 
soon. The driver is working quite well but need some tuning in the request 
processing.

The driver is also independent of any previous MMC related work at this point 
since MMC over SPI mode differs somewhat from the MMC mode.

I have implemeted the request processing from scratch. I have followed the 
Linux Device Drivers and the Understanding Linux Kernel as far as possible, 
but they are not very extensive on error handling. I have also had a look at 
the ATA and SCSI drivers.

-Questions
A snip of my current request processing can be found here: with comments and 
some questions. 

http://hasse.yohoo.nu/strat.txt

The big issue is error handling and how i report back to the user space 
processes that the device is dead(if hardware fails for example), basically 
how to gracefully handle critical issues. At this point, if retries on broken 
sectors fails im not sure how to report back to the I/O scheduler and block 
layer so the device can be halted. Now, the kernel actually hangs(or retries 
same sector forever). Im really at a dead end here. Could really use some 
help at this point.

Also, Is there any work done similar to mine?
Would there be interest in incorporating the driver in future kernels?

Answers/CC to hans@rubico.se since i did not dare to plunge into the lkml 
traffic just yet.

Best regards
Hans Eklund
Rubico AB
Sweden.

