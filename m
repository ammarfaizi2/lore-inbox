Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTFPWTN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTFPWTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:19:12 -0400
Received: from host-65-122-61-34.winux.com ([65.122.61.34]:36792 "EHLO
	skarven.net") by vger.kernel.org with ESMTP id S264455AbTFPWTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:19:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16110.17820.740483.866151@eagle.skarven.net>
Date: Mon, 16 Jun 2003 18:33:00 -0400
To: linux-kernel@vger.kernel.org
From: Larry Auton <lkml@winux.com>
Subject: direct i/o problem with 2.4.21
X-Mailer: VM 7.04 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message-ID: <16107.26375.67524.817817@nv.winux.com>
> Date:   Sat, 14 Jun 2003 14:18:47 -0400
> To:     linux-kernel@vger.kernel.org
> From:   Larry Auton <lkml@winux.com>
> Subject: direct i/o problem with 2.4.20 and 2.4.21rc7
>
> I have an application that requires direct i/o to thousands of files.
> On 2.4.19 the open's would eventually fail (at around 7200 files).
> On 2.4.20 and 2.4.21rc7 the machine hangs.
> 
> Here's a sample program to do the deed:
> 
>     wget http://www.skarven.net/lda/crashme.c
>     cc -o crashme crashme.c     # compile it
>     ./crashme 4000              # OK
>     ./crashme 9999              # CRASH
> 
> It's a little obfuscated to eliminate the need for root privileges to
> mess with rlimit. It simply opens a bunch of files with O_DIRECT and,
> when enough files are open, the system will hang.
> 
> The system hangs when '/proc/slabinfo' reports that 'kiobuf' reaches 
> just over 7230 active objects. I don't believe that this problem is
> specific to any particular file system as the failure occurs when
> using both ext2 and reiserfs.
> 
> Larry Auton

The hang I reported on 2.4.21rc7 persists in the released version 2.4.21.

Larry
