Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbTCGJ4W>; Fri, 7 Mar 2003 04:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbTCGJ4W>; Fri, 7 Mar 2003 04:56:22 -0500
Received: from angband.namesys.com ([212.16.7.85]:3203 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S261472AbTCGJ4W>; Fri, 7 Mar 2003 04:56:22 -0500
Date: Fri, 7 Mar 2003 13:06:55 +0300
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [2.5] double free in ext2?
Message-ID: <20030307130655.A17819@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   I am playing with smatch and while testing my improved version of
   unfree.pl, I seems to have found a double free condition in ext2:

   fs/ext2/super.c::ext2_fill_super()  (I am looking at yesterday's 2.5 snapshot)

   in line 784 we do kfree(sbi->s_group_desc); (then print "EXT2-fs: unable to read group descriptors\n")
   and go to failed_mount_group_desc, which reads (from line 821):
failed_mount_group_desc:
        kfree(sbi->s_group_desc);

   2.4 is not affected.

Bye,
    Oleg
