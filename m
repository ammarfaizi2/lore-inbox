Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSHJRla>; Sat, 10 Aug 2002 13:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSHJRla>; Sat, 10 Aug 2002 13:41:30 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:787 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317091AbSHJRla>; Sat, 10 Aug 2002 13:41:30 -0400
Date: Sat, 10 Aug 2002 10:46:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <20020810183604.B306@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208101041500.2197-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Aug 2002, Jamie Lokier wrote:
> 
> This will only provide the performance benefic when `aligned_malloc'
> return "fresh" memory, i.e. memory that has never been written to.

Absolutely.

Think o fthe optimization as a way to give application writers a new way 
of being efficient.

In particular, I remember when the gcc people were worried about the most 
efficient way to read in a file for preprocessing (Neil Booth, mainly). 
Neil did all these timings on where the cut-off point was for using mmap 
vs just using read().

For people like that, wouldn't it be nice to just be able to tell them: if 
you do X, we guarantee that you'll get optimal zero-copy performance for 
reading a file.

> But it's a nice way to optimise if you are _deliberately_ optimising a
> user space program.  

Exactly.

		Linus

