Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315737AbSEJAdi>; Thu, 9 May 2002 20:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315738AbSEJAdh>; Thu, 9 May 2002 20:33:37 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:54227 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315737AbSEJAdh>; Thu, 9 May 2002 20:33:37 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <3CD9E8A7.D524671D@zip.com.au> <5.1.0.14.2.20020509193347.02ff6dc8@mira-sjcm-3.cisco.com> <3CDAC4EB.FC4FE5CF@zip.com.au>
From: Andi Kleen <ak@muc.de>
Date: 10 May 2002 02:33:19 +0200
Message-ID: <m31yck9700.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> For bulk read() and write() I/O the best sized buffer is 8 kbytes.  4k is
> pretty good, too.  Anything larger blows the user-side buffer out of L1.
> This is for x86.

Modern x86 support prefetch hints for the CPU to tell it to not 
pollute the caches with "streaming data". I bet using them would
be a big win. The rep ; movsl loop used in copy*user isn't 
very good on modern x86 anyways (it is ok on PPro, but loses on Athlon
and P4) 

I'm (slowly) working on such functions for x86-64, it should be eventually
possible to backport them to i386.

-Andi
