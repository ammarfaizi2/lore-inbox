Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318468AbSHPPVX>; Fri, 16 Aug 2002 11:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318469AbSHPPVW>; Fri, 16 Aug 2002 11:21:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:65032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318468AbSHPPVW>; Fri, 16 Aug 2002 11:21:22 -0400
Date: Fri, 16 Aug 2002 08:27:43 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reduce stack usage of sanitize_e820_map
In-Reply-To: <200208161001.g7GA1mp24413@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.44.0208160824361.2110-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Denis Vlasenko wrote:
> >
> > Currently, sanitize_e820_map uses 0x738 bytes of stack.  The patch below
> > moves the arrays into __initdata, reducing stack usage to 0x34 bytes.
> 
> Is that a real problem? sanitize_e820_map will be called just once at init
> time...

Well, I would actually want us to have some tools that just say "you can't 
do that". A flag to gcc that says "-Wstack-depth=200" that just makes gcc 
refuse to compile functions that have too big of a stack requirement, so 
that we'd see some of these things immediately.

Somebody had a script that greps the kernel disassembly for big stack
changes, I suspect Ben used something like that. That's obviously 
equivalent, but doesn't force developers to be careful.

Of course, the ultimate thing checks what the dynamic depths are by 
looking at the call graph, but since you can avoid the worst stuff by just 
checking for static issues I htink that's worth it.

		Linus

