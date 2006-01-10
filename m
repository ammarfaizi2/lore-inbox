Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbWAJXzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWAJXzN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 18:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbWAJXzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 18:55:13 -0500
Received: from 213-140-2-72.ip.fastwebnet.it ([213.140.2.72]:53728 "EHLO
	aa005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S932710AbWAJXzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 18:55:11 -0500
Date: Wed, 11 Jan 2006 00:55:54 +0100
From: Mattia Dongili <malattia@linux.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, reiserfs-dev@namesys.com
Subject: 2.6.15-mm2: reiser3 oops on suspend and more (bonus oops shot!)
Message-ID: <20060110235554.GA3527@inferi.kami.home>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@osdl.org, reiserfs-dev@namesys.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.15-rc5-mm3-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I didn't tested -mm1 but -mm2 has definitely too many problems currently,
let's start:

1- reiser3 oopsed[1] twice while suspending to ram. It seems
   reproducible (have some activity on the fs and suspend)

2- I had already written this email once, but the box completely
   froze, nothing in the logs, only mouse and X activity. I suspect
   again of reiser3.

3- This laptop experienced 2 long stalls (20~25 sec) during boot,
   apparently after scanning usb_storage devices and starting portmap.
   I logged the call traces (sysrq+t) during this time, I don't know if
   it is useful[2].
   Is it time for me to learn to git bisect? (Tomorrow morning I'll try
   (CET) if plain 2.6.15 also shows the same stalls).

4- I'm also affected by the ACPI Misaligned resource pointer error.

5- That's an older problem I never reported (never tracked to be a
   reiser4 problem): reiser4 shows a very bad slowness. Use case: backup
   my ~/ (rsync)
   a- from reiser4 to xfs rsync stalls for some seconds from time to
      time while building the file list (call trace during the stall[3])
      Even using mutt and editing a file with vim causes short freezes)
   b- from xfs to reiser4 after finishing the copy, sync-ing takes ages,
      gkrellm disk monitor shows 1MB/s

[1]: http://oioio.altervista.org/linux/dsc03133.jpg
[2]: http://oioio.altervista.org/linux/boot-2.6.15-mm2.3
[3]: http://oioio.altervista.org/linux/dmesg_reiser4_stalls

The reiser oops seems reproducible by suspending with some dirty cache
(I've been able to suspend/resume cycle 3 times without reiser crashing
but I also didn't have big activities on that partition).
If really necessary I can try to reproduce it (oh, poor filesystem).
Other than that are ther suggestions/patches to start with?

Oh, my .config here:
http://oioio.altervista.org/linux/config-2.6.15-mm2-2

ciao
-- 
mattia
:wq!
