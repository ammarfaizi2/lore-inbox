Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261678AbSKEOqC>; Tue, 5 Nov 2002 09:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262510AbSKEOqC>; Tue, 5 Nov 2002 09:46:02 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:19418 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S261678AbSKEOqB>; Tue, 5 Nov 2002 09:46:01 -0500
Date: Tue, 05 Nov 2002 09:52:00 -0500
From: Akira Tsukamoto <akira-t@suna-asobi.com>
To: Akira Tsukamoto <at541@columbia.edu>
Subject: Re: [PATCH] 2.5.46 add original copy_ro/from_user for i386 and support PenPro PenII
Cc: linux-kernel@vger.kernel.org, Hirokazu Takahashi <taka@valinux.co.jp>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <20021105090237.511A.AT541@columbia.edu>
References: <20021105090237.511A.AT541@columbia.edu>
Message-Id: <20021105094344.5120.AKIRA-T@suna-asobi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.05.06
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at out002.verizon.net from [138.89.32.225] at Tue, 5 Nov 2002 08:52:29 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Nov 2002 09:36:48 -0500
Akira Tsukamoto <at541@columbia.edu> mentioned:
> 
> This is revised version from my previous patch, adding original copy_user.
> 
> In addition, I changed one line in Kconfig, remove M585MMX and add M686
> because I run new copy-user on my PentiumMMX but had no improvement,
> however PenII/PenPro likely to have improvement from new copy_user function.
> 
> Athlon is ignored in the current kernel from 2.5.45 but you could use 
> CONFIG_M686 to try new copy_user.

For arhlon, to try the new copy_user,
I run the Taka's socket benchmark program between CONFIG_M686 and K7.
http://www.suna-asobi.com/~akira-t/linux/netio-bench/netio2.c

CONFIG_MK7
(off:100, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.117 seconds at 342.9 Mbytes/sec
(off:104, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.114 seconds at 350.1 Mbytes/sec
(off:108, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.115 seconds at 347.9 Mbytes/sec
(off:112, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.113 seconds at 354.8 Mbytes/sec
(off:116, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.112 seconds at 358.1 Mbytes/sec
(off:120, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.113 seconds at 354.2 Mbytes/sec

CONFIG_M686
(off:100, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.090 seconds at 445.1 Mbytes/sec
(off:104, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.090 seconds at 442.4 Mbytes/sec
(off:108, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.089 seconds at 447.2 Mbytes/sec
(off:112, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.091 seconds at 438.7 Mbytes/sec
(off:116, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.091 seconds at 440.7 Mbytes/sec
(off:120, size:0x800000) 
send/recv: copied 40.0 Mbytes in 0.090 seconds at 442.7 Mbytes/sec

It looks like improving, but it could be X86_L1_CACHE_SHIFT 6/5
problem that I post it previously.

-- 
Akira Tsukamoto <akira-t@suna-asobi.com, at541@columbia.edu>


