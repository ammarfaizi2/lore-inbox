Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265693AbTFNSCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 14:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbTFNSCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 14:02:47 -0400
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:25333 "EHLO
	snipe.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265693AbTFNSCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 14:02:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16107.26375.67524.817817@nv.winux.com>
Date: Sat, 14 Jun 2003 14:18:47 -0400
To: linux-kernel@vger.kernel.org
From: Larry Auton <lkml@winux.com>
Subject: direct i/o problem with 2.4.20 and 2.4.21rc7
X-Mailer: VM 7.04 under 21.4 (patch 9) "Informed Management" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an application that requires direct i/o to thousands of files.
On 2.4.19 the open's would eventually fail (at around 7200 files).
On 2.4.20 and 2.4.21rc7 the machine hangs.

Here's a sample program to do the deed:

    wget http://www.skarven.net/lda/crashme.c
    cc -o crashme crashme.c	# compile it
    ./crashme 4000		# OK
    ./crashme 9999		# CRASH

It's a little obfuscated to eliminate the need for root privileges to
mess with rlimit. It simply opens a bunch of files with O_DIRECT and,
when enough files are open, the system will hang.

The system hangs when '/proc/slabinfo' reports that 'kiobuf' reaches 
just over 7230 active objects. I don't believe that this problem is
specific to any particular file system as the failure occurs when
using both ext2 and reiserfs.

Larry Auton
