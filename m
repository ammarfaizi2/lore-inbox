Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbUKOGdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbUKOGdl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUKOGdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:33:41 -0500
Received: from corpmail.outblaze.com ([203.86.166.82]:54413 "EHLO
	corpmail.outblaze.com") by vger.kernel.org with ESMTP
	id S261507AbUKOGdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:33:38 -0500
Date: Mon, 15 Nov 2004 14:33:25 +0800
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: ext3 reservation seems to cause major slowdown in synctest in 2.6.10-rc2 vs 2.6.9 
Message-ID: <20041115063325.GA31537@outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.2-8; VAE: 6.28.0.12; VDF: 6.28.0.70; host: corpmail.outblaze.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a P3-500 box /384 MB ram and 2 scsi disks (sda and sdb).
OS is on sda and test partions is on sdb
aic7xxx driver 
Using anticipatory schedulor with a tag_depth of 4 (this is set via
modules.conf)
options aic7xxx aic7xxx=global_tag_depth:4

/dev/sdb1 is created with ext3 and htree is enabled. Mounted as /htree

synctest obtained from here (synctest tries to simulate an MTA
behaviour)

http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz

I run the following commands on both 2.6.9 and 2.6.10-rc2

/usr/bin/time -p ./synctest -fu -t 100 -p1 -n1 /htree/nfsexport

timing results

2.6.9 

real 57.35
user 1.37
sys 14.26

2.6.10-rc2

real 86.83
user 1.32
sys 14.02

Mounting with noreservation gives the following numbers

real 58.77
user 1.46
sys 14.48

