Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263399AbTCNQnB>; Fri, 14 Mar 2003 11:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263400AbTCNQnB>; Fri, 14 Mar 2003 11:43:01 -0500
Received: from mail.coastside.net ([207.213.212.6]:41909 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S263399AbTCNQm7>; Fri, 14 Mar 2003 11:42:59 -0500
Mime-Version: 1.0
Message-Id: <p05210509ba97b7c2fd17@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.30.0303141214180.25220-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0303141214180.25220-100000@divine.city.tvnet.hu>
Date: Fri, 14 Mar 2003 08:53:11 -0800
To: Szakacsits Szabolcs <szaka@sienet.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: Backward disassembling (was: Re: 2.5.63 accesses below %esp)
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:16pm +0100 3/14/03, Szakacsits Szabolcs wrote:
>  > Why not? Disassemble from, say, EIP-16 and check whether you have
>>  an instruction starting exactly at EIP. If no, repeat from EIP-15,
>>  -14... You are guaranteed to succeed at EIP-0 ;)
>
>Disassembling must be started "much" earlier. From your example one
>could get the impression you want to get the instruction right before
>EIP. It's not possible to go back this way. For example if you want to
>disassemble 100 bytes before EIP you must start at EIP-100 and EIP-99
>and ... and EIP-100-max_instruction_length+1. Then you have the right
>one among them (well, 99.9% but let's don't be too pedantic).
>
>You also can't stop the above max_instruction_length iteration when
>the next instruction address matches EIP. You can have even
>max_instruction_length matches. But from the additional info (code
>after EIP, assembly "quality", available source where the crash
>happend) you could choose the right one.

Sounds similar to the problem of recognizing valid plaintext when 
breaking a code.

As a practical matter (and in the context of this being a heuristic 
debugging aid, not a guaranteed 100%-correct method), I wonder 
whether one might not tend to sync up fairly quickly to the correct 
code. For example, strings of one-byte instructions provide a 
"landing zone" for disassembly leading up to them, and illegal 
instructions provide clues that you're out of sync (not perfect, but 
perhaps good enough).

I'm not in a position to do it right now, but I'd suggest trying it: 
disassemble hunks of random code on random boundaries, and see how 
many ways there tend to be of arriving at EIP+0, given enough of a 
BEIP running start (for some definition of "enough").
-- 
/Jonathan Lundell.
