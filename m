Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266276AbUBQP4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266278AbUBQP4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:56:05 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:25234 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S266276AbUBQP4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:56:01 -0500
Date: Tue, 17 Feb 2004 07:55:53 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: bernd@bzed.de
Subject: [Bug 2120] New: /proc/ide - multiple directory entries
Message-ID: <18630000.1077033353@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=2120

           Summary: /proc/ide - multiple directory entries
    Kernel Version: 2.6.3-rc2-mm1
            Status: NEW
          Severity: normal
             Owner: akpm@digeo.com
         Submitter: bernd@bzed.de


Distribution: Debian testing/unstable
Hardware Environment: IBM Thinkpad R40 2722-GDG
Software Environment: Kernel 2.6.3-rc2-mm1, hdaparm 5.4

Problem Description:
Multiple directory entries in /proc/ide after removing and inserting a ultrabay
device with the use of hdparm -U/-R

0 think:/proc/ide# ll
total 2
-r--r--r--    1 root     root            0 Feb 17 10:19 drivers
lrwxrwxrwx    1 root     root            8 Feb 17 10:19 hda -> ide0/hda
lrwxrwxrwx    1 root     root            8 Feb 17 10:19 hdc -> ide1/hdc
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide0
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide1
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide1
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide1
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide1
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide1
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide1
dr-xr-xr-x    3 root     root            0 Feb 17 10:19 ide1
-r--r--r--    1 root     root            0 Feb 17 10:19 piix
0 think:/proc/ide#



Steps to reproduce:
(that's the same the scripts from the hdparm's contrib directory do)

- remove drive from ultrabay
- hdparm -U 1 /dev/hda
- insert drive
- hdparm -R 0x170 0 0 /dev/hda

now we have another ide1 directory in /proc/ide, but the old one should b reused.

