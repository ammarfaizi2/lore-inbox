Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbTCRTi2>; Tue, 18 Mar 2003 14:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262551AbTCRTi2>; Tue, 18 Mar 2003 14:38:28 -0500
Received: from divine.city.tvnet.hu ([195.38.100.154]:64378 "EHLO
	divine.city.tvnet.hu") by vger.kernel.org with ESMTP
	id <S262549AbTCRTi1>; Tue, 18 Mar 2003 14:38:27 -0500
Date: Tue, 18 Mar 2003 20:44:39 +0100 (MET)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63)) 
In-Reply-To: <1306.1047958084@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.30.0303181750080.1797-100000@divine.city.tvnet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 18 Mar 2003, Keith Owens wrote:
> At the risk of stating the obvious: the only program that cares about
> the 'Code:' line is ksymoops.  It already handles code around the EIP
> by looking for a byte enclosed in <> and assuming that byte is at EIP.
> ksymoops can happily decode around the failing instruction and does so
> for most architectures with fixed length instructions.
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Ah, this is the reason it didn't work for x86 when I looked this issue
with ksymoops days ago and tried all possible bracketing combinations
(nothing such limit described in the man page). I didn't mention this
before because it's a non-issue if kernel doesn't dump the backwards
bytes for these archs.

> I can change ksymoops to add a special case for architectures with
> variable length instructions - i386, s390 and their 64 bit equivalents,
> are there any others?

Please don't bother. Linus have indicated already 4 times in this
thread he will not dump backwards code if it doesn't start at
instruction boundary.

> For variable length instructions, ksymoops will extract the bytes
> up to but not including eip, decode and print them with a warning
>
>   This architecture has variable length instructions, decoding before eip is
>   unreliable, take these instructions with a pinch of salt.

86% it will be incorrect on x86. But the right code can be dumped 100%
among a max 7 decoded lists to choose from (for pedants, yes in theory
it's not exactly 100% but a bit less, only from practical and problem
solving point of view "100%"). I've found the max ususally is 1, 2 or
3 with decreasing probabilities but I didn't do exhaustive statistical
analysis and it also depends on the compiler (version).

	Szaka

