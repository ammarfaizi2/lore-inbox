Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSIHSFG>; Sun, 8 Sep 2002 14:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315388AbSIHSFG>; Sun, 8 Sep 2002 14:05:06 -0400
Received: from [63.209.4.196] ([63.209.4.196]:5901 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S315370AbSIHSFF>;
	Sun, 8 Sep 2002 14:05:05 -0400
Date: Sun, 8 Sep 2002 11:09:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: James Morris <jmorris@intercode.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Performance issue in 2.5.32+
In-Reply-To: <Mutt.LNX.4.44.0209090326100.21359-100000@blackbird.intercode.com.au>
Message-ID: <Pine.LNX.4.44.0209081055310.14734-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, James Morris wrote:
> 
> I guess it could be an existing hardware problem which has been triggered 
> by some innocuous change.

Does HZ make any difference to you? That's easily tested by just editing 
include/asm-i386/param.h and changing HZ to 100 to get the old behaviour..

I think that change happened earlier than your performance problem, but 
since lmbench variations can be noticeable and you only had one run per 
kernel, it might be one of those "comes and goes" things..

Another thing that you might check out is to disable USB if you have it
on. The memory throughput issue makes me wonder whether there might be a
lot of DMA going on, and USB (by "design", and I use the term losely) has
this silly "DMA always"  approach, even if nothing really is happening on
the bus. 

I don't really see anythign very suspicious in the 31->32 changelogs. 
Somebody else already mentioned TLS etc, but that shouldn't really be 
noticeable...

		Linus

