Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313188AbSC1R3c>; Thu, 28 Mar 2002 12:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313189AbSC1R3W>; Thu, 28 Mar 2002 12:29:22 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:64271 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313188AbSC1R3K>; Thu, 28 Mar 2002 12:29:10 -0500
Date: Thu, 28 Mar 2002 12:26:19 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] ext2_fill_super breakage
In-Reply-To: <3CA31BF6.7030609@didntduck.org>
Message-ID: <Pine.LNX.3.96.1020328121056.18285E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Brian Gerst wrote:

> I'm not sure I follow you here.  Compiling this code (gcc 2.96):
> 
> int foo1(void) { return sizeof(struct ext2_sb_info); }
> int foo2(struct ext2_sb_info *sbi) { return sizeof(*sbi); }
> 
> yields:
> 
> 00000b70 <foo1>:
>       b70:       b8 dc 00 00 00          mov    $0xdc,%eax
>       b75:       c3                      ret
> 
> 00000b80 <foo2>:
>       b80:       b8 dc 00 00 00          mov    $0xdc,%eax
>       b85:       c3                      ret
> 
> The sizes are the same, so unless it makes a difference with another 
> version of gcc then this is just a cosmetic change.

  Not at all, it's good programming practice. If you use the sizeof(*p) 
notation then the code work right, first time, every time, *even if you
change the type of the pointer*. Without that you have to search all the
code following the pointer declaration for a use of the type where the
pointer should have been dereferenced. 

  Now scale that to the case where you make a similar change in a macro or
typedef. Now you have to search the whole kernel (or NIC drivers, or ...).
Doing it right assures a change in one place will not break things at
random places all of the source tree.

  That used to be part of Intro To Programming Computers...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

