Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWE1QkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWE1QkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 12:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWE1QkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 12:40:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750797AbWE1QkS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 12:40:18 -0400
Date: Sun, 28 May 2006 12:40:15 -0400
From: Dave Jones <davej@redhat.com>
To: alsa-devel@alsa-project.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.17rc emu10k1 regression.
Message-ID: <20060528164015.GA13499@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	alsa-devel@alsa-project.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ lspci  | grep audio
00:1f.5 Multimedia audio controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) AC'97 Audio Controller (rev 02)
06:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)

(That's 06:0d.1 0980: 1102:7002 (rev 01))

This worked fine in 2.6.16, however when I try a .17rc kernel I get this..

cannot find the slot for index 0 (range 0-1)
EMU10K1_Audigy: probe of 0000:06:0d.0 failed with error -12

(Unremarkable, considering it *isn't* an Audigy)


modprobe.conf has ..
alias snd-card-0 snd-emu10k1
options snd-card-0 index=0
options snd-emu10k1 index=0
remove snd-emu10k1 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; }; /sbin/modprobe -r --ignore-remove snd-emu10k1

What changed ?

		Dave

-- 
http://www.codemonkey.org.uk
