Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTK1ONz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 09:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbTK1ONz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 09:13:55 -0500
Received: from multiserv.relex.ru ([213.24.247.63]:8926 "EHLO
	mail.techsupp.relex.ru") by vger.kernel.org with ESMTP
	id S262303AbTK1ONx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 09:13:53 -0500
From: Yaroslav Rastrigin <yarick@relex.ru>
Organization: RELEX Inc.
To: linux-kernel@vger.kernel.org
Subject: cs46xx 2.6.0-test11 ACPI, non-STR-aware ?
Date: Fri, 28 Nov 2003 16:41:25 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311281641.25822.yarick@relex.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I've switched to 2.6.0-test11, and was pleasantly surprised that 
suspend-to-ram / suspend-to-disk (Patrick's version) works very well. 
It even somewhat fixes (by initialising properly on resume) troubles with 
miniPCI 3c556 NIC.
(bug #1188 in bugzilla). One problem (not a showstopper, but somewhat 
annoying) is audio device driver failing to resume correctly from STR. No 
oops, but no sound after resume either, until sound driver is 
rmmoded/insmoded.
relevant messages in dmesg:

Nov 28 02:02:48 localhost kernel: ALSA sound/pci/cs46xx/cs46xx_lib.c:1420: 
open front channel                                
Nov 28 02:02:58 localhost kernel: ALSA sound/core/pcm_native.c:1267: playback 
drain error (DMA or IRQ trouble?)              

for ALSA driver and
Nov 28 10:50:00 localhost kernel: cs46xx: drain_dac, dma timeout? 1034

for OSS. 
With APM this feature worked corectly. 
I've looked briefly into the driver code (cs46xx_lib.c), but quickly realised 
I'm not knowledgeable enough to try to fix the problem. I've tried to 
reproduce initialisation sequence (by copypasting relevant code from 
snd_cs46xx_create to snd_cs46xx_resume), but without success.

-- 
With all the best, yarick at relex dot ru.

