Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275568AbRJFTNC>; Sat, 6 Oct 2001 15:13:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRJFTMw>; Sat, 6 Oct 2001 15:12:52 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:33033 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275527AbRJFTMj>; Sat, 6 Oct 2001 15:12:39 -0400
Date: Sat, 6 Oct 2001 21:13:00 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
cc: Rik van Riel <riel@conectiva.com.br>,
        Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <462829506.1002394773@[195.224.237.69]>
Message-ID: <Pine.LNX.3.96.1011006210743.7808D-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> --On Saturday, 06 October, 2001 4:44 PM +0200 Mikulas Patocka 
> <mikulas@artax.karlin.mff.cuni.cz> wrote:
> 
> > Here goes the fix. (note that I didn't try to compile it so there may be
> > bugs, but you see the point).
> 
> (seems to replace high order allocations by vmalloc)
> 
> & how does vmalloc allocate physically (as opposed to virtually)
> contiguous memory; can't clearly recall it being IRQ safe either
> (for GFP_ATOMIC).

It uses vmalloc only when __GFP_VMALLOC flag is given - and so it is
expected to not use __GFP_VMALLOC flag in IRQ.

NOTE: no allocations in IRQ are safe. Not only high-order ones. 
Allocation in IRQ may fail any time and you must recover without lost of
functionality (network can lose packets any time, if you are doing some
general device driver, you must preallocate all buffers in process
context).

Mikulas

