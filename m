Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317192AbSFLLGX>; Wed, 12 Jun 2002 07:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSFLLGW>; Wed, 12 Jun 2002 07:06:22 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:33785 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S317192AbSFLLGW>; Wed, 12 Jun 2002 07:06:22 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15623.11051.890868.154587@wombat.chubb.wattle.id.au>
Date: Wed, 12 Jun 2002 21:06:19 +1000
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH, TRIVIAL] Fix argument of BLKGETSIZE64 
In-Reply-To: <E17I0sl-0004y0-00@wagner.rustcorp.com.au>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rusty" == Rusty Russell <rusty@rustcorp.com.au> writes:


>> I think it should be uint64_t to allow glibc to copy and mangle the
>> file into its header tree.

Rusty> I don't think that's really an issue, is it? 

This issue is that when I try to use the BLKGETSZ64 ioctl from a user space
program, the version of linux/fs.h shipped with glibc-2.2.5 contains a
u64 type.  u64 is kernel-only, the correct type to be shared between
user and kernel space is either uint64_t (mandated by C9X) or the
__u64 type from asm/types.h.  Either way, u64 is wrong.

You could argue that this is a glibc bug.  But the way that glibc
generates the include/linux headers is just to copy them from some
kernel tree or other, with a little mangling on the side.

--
Peter C					    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
