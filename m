Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUDFQHS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 12:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbUDFQHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 12:07:18 -0400
Received: from auemail1.lucent.com ([192.11.223.161]:41719 "EHLO
	auemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S263871AbUDFQHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 12:07:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16498.54669.886834.727923@gargle.gargle.HOWL>
Date: Tue, 6 Apr 2004 12:06:37 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: "John Stoffel" <stoffel@lucent.com>
Cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       andre@linux-ide.org
Subject: Re: 2.6.5-rc3: cat /proc/ide/hpt366 kills disk on second channel
In-Reply-To: <16496.41345.341470.807320@gargle.gargle.HOWL>
References: <16496.41345.341470.807320@gargle.gargle.HOWL>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just found the time to do a quick test under 2.6.3 with the same
test.  Running

  > badblocks -wsv /dev/hdg

and then doing a 

  > cat /proc/ide/hpt366

			       HighPoint HPT366/368/370/372/374

  Controller: 0
  Chipset: HPT302
  --------------- Primary Channel --------------- Secondary Channel ----------
  Enabled:        yes                             yes
  Cable:          ATA-66                          ATA-66

  --------------- drive0 --------- drive1 ------- drive0 ---------- drive1 ---
  DMA capable:    yes              no             yes               no
  Mode:           UDMA             off            UDMA              off


Immediately causes the following error to appear in the logs, and all
access to /dev/hdg hangs, only a reboot will clear it up.

 Apr  6 11:57:28 jfsnew kernel: hdg: status timeout: status=0xd0 { Busy }
 Apr  6 11:57:28 jfsnew kernel: 
 Apr  6 11:57:28 jfsnew kernel: hdg: DMA disabled
 Apr  6 11:57:28 jfsnew kernel: ide3: reset: master: error (0x00?)
 Apr  6 11:57:28 jfsnew kernel: hdg: set_multmode: status=0xd0 { Busy }
 Apr  6 11:57:28 jfsnew kernel: hdg: recal_intr: status=0xd0 { Busy }
 Apr  6 11:57:28 jfsnew kernel: 
 Apr  6 11:57:28 jfsnew kernel: ide3: reset: master: error (0x00?)
 Apr  6 11:57:28 jfsnew kernel: end_request: I/O error, dev hdg, sector 1252992
 Apr  6 11:57:28 jfsnew kernel: end_request: I/O error, dev hdg, sector 1253000
 Apr  6 11:57:28 jfsnew kernel: end_request: I/O error, dev hdg, sector 1253008

I haven't had a chance to move the disk from secondary channel to be
the slave on the primary.  I'm kinda scared to lose all my data on the
still living half of my disk. 

Is there any more information I can provide here?

