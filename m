Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315230AbSEIXWZ>; Thu, 9 May 2002 19:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315234AbSEIXWY>; Thu, 9 May 2002 19:22:24 -0400
Received: from dsl-213-023-040-085.arcor-ip.net ([213.23.40.85]:896 "EHLO
	starship") by vger.kernel.org with ESMTP id <S315230AbSEIXWX>;
	Thu, 9 May 2002 19:22:23 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Date: Fri, 10 May 2002 01:22:11 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0205062053050.32715-100000@serv> <E175wJO-0008Lz-00@starship> <3CDAFF7C.57A59FB8@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E175xEi-0008Mi-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 May 2002 01:00, Roman Zippel wrote:
> > Look at drivers/char/mem.c, read_mem.  Clearly, the code is not dealing with
> > physical addresses.  Yet it starts off with virt_to_phys, and thereafter works
> > in zero-offset addresses.  Why?  Because it's clearer and more efficient to do
> > that.  The generic part of my nonlinear patch clarifies this usage by rewriting
> > it as virt_to_logical, which is really what's happening.
> 
> Are we looking at the same code??? Where is that zero-offset thingie? It
> just works with virtual and physical addresses and needs to convert
> between them.

Show me where the 'physical' address is actually treated as a physical address.
You can't, because it isn't.  The 'physical' address is merely a zero-based
logical address, and the code *relies* on it being contiguous.

Your code is going to do __pa there, and you are going to go walking into places
you don't expect.  Even you need my logical address space abstraction, or else you
want to go making global changes to the common kernel code that just add cruft.

I enjoy the feeling of removing cruft, even when it's an uphill battle.

-- 
Daniel
