Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUCKL00 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 06:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUCKL00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 06:26:26 -0500
Received: from dp.samba.org ([66.70.73.150]:61840 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261190AbUCKL0Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 06:26:25 -0500
Date: Thu, 11 Mar 2004 22:22:22 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mickael Marchand <marchand@kde.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-ID: <20040311112222.GA16751@krispykreme>
References: <20040310233140.3ce99610.akpm@osdl.org> <200403111017.33363.marchand@kde.org> <20040311030607.22706063.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040311030607.22706063.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > ioctl32(fsck.reiserfs:201): Unknown cmd fd(4) cmd(80081272){00} arg(ffffdab8) on /dev/ide/host0/bus0/target0/lun0/part4
> 
> Is this something which 2.6 has always done, or is it new behaviour?
> 
> reiserfs ioctl translation appears to be incomplete...

Some clown is running around "fixing" our ioctls:

X0081272 is BLKGETSIZE64. Yeah its bust, it was one of those calls that
we passed in sizeof(8) instead of 8. The ioctl should be X0041272. 
The definition is:

#define BLKGETSIZE64 _IOR(0x12,114,size_t)

However at least in debian unstable, util-linux has:

./fdisk/common.h:#define BLKGETSIZE64 _IOR(0x12,114,8)  /* 8 = sizeof(u64) */
./lib/get_blocks.c:#define BLKGETSIZE64 _IOR(0x12,114,long long)

ie X0081272

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=233626

Anton
