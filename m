Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSG2Swx>; Mon, 29 Jul 2002 14:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317791AbSG2Swx>; Mon, 29 Jul 2002 14:52:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:56461 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317643AbSG2Swv>;
	Mon, 29 Jul 2002 14:52:51 -0400
Date: Mon, 29 Jul 2002 11:56:10 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       <torvalds@transmeta.com>
Subject: Re: [PATCH] automatic initcalls 
In-Reply-To: <20020728033359.7B2A2444C@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0207291142120.22697-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > -__initcall(spawn_ksoftirqd);
> > +fs_initcall(spawn_ksoftirqd);
> 
> See, this is exacly the kind of thing that makes me doubt that the
> current "magic 7 initcall levels" are useful in the long term 8(

I agree that that is abusing the interface. WTF does spawn_ksoftirqd have 
to do with filesystems? 

The purpose of the initcall levels in the first place was to start 
removing the ugly conditional calls in init/main.c I looked at what was 
being called, and came up with names to describe what was being done at 
each phase. There happened to be seven of them.

I knew from the start that people would feel that they were more important 
that others, and leapfrog their initcalls before everyone else. We're 
egotistical; that's what we do. But remember, just because it's there, 
doesn't mean you have to use it. 

That said, it's been a while since I've really looked at it. I favor a 
mechanism for getting the ordering right. I don't really like having to 
specify the dependencies in the definitions; I think it's kinda ugly and 
wonder if there is an automatic way to resolve them. I don't have any 
ideas, nor the time to play with it, so it remains still just a pipe 
dream...

	-pat

