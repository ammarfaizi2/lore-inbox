Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272311AbTGYV3o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 17:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272323AbTGYV3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 17:29:44 -0400
Received: from node152ae.a2000.nl ([24.132.82.174]:33284 "EHLO robben.nu")
	by vger.kernel.org with ESMTP id S272311AbTGYV3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 17:29:41 -0400
Date: Fri, 25 Jul 2003 23:44:49 +0200
From: Gert Robben <lkml@gert.robben.nu>
To: linux-kernel@vger.kernel.org
Subject: [DAC960] 2.6.0-test1: device files wrong in devfs
Message-ID: <20030725214449.GA12678@gert.robben>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I mount devfs in 2.6.0-test1 (and -bk2), I have the following 
DAC960-related files in /dev (actually, /mnt/dev) without devfsd:

/dev/part{1,2,5,6,7}
/dev/disc
/dev/discs/disc[0-31] (these 32 files are symlinks to "../")

I don't have a /dev/rd/ directory. All other files in /dev seem to be 
in the right place. The relevant lines from dmesg:

DAC960#0:     /dev/rd/c0d0: RAID-5, Online, 88442880 blocks, Write Back
devfs_mk_dir: invalid argument.<6> rd/c0d0: p1 p2 < p5 p6 p7 >
devfs_mk_dir: invalid argument.<4>devfs_mk_bdev: could not append to 
parent for /disc (this line shows up 31 times in a row)

AFAIK, the last correctly working kernel is 2.5.67. 2.5.68 doesn't 
work, however I don't know if that's because of the same problem.

My hardware:
Mylex ExtremeRAID 1100 (DAC1164P)
ALR Revolution 6x6 (Intel 450GX-based Pentium Pro mainboard)
6x Intel PII Overdrive CPU
4 GB mem

FWIW, the problem also occurs when I _don't_ enable highmem support.

Please CC replies to lkml@gert.robben.nu (I'm not subscribed).

Thanks,

Gert Robben
