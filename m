Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317799AbSHPA7K>; Thu, 15 Aug 2002 20:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317809AbSHPA7K>; Thu, 15 Aug 2002 20:59:10 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47377 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317799AbSHPA7J>; Thu, 15 Aug 2002 20:59:09 -0400
Date: Thu, 15 Aug 2002 18:06:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
In-Reply-To: <Pine.LNX.4.44.0208160205190.6746-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208151804030.1188-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Ingo Molnar wrote:
> 
> On Thu, 15 Aug 2002, Linus Torvalds wrote:
> 
> > 	process X
> > 
> > 	fork()			
> > 			------->	Process Y
> > 					clone()
> > 								----> thread Z
> > 
> > 					exit()
> > 					THIS MUST NOT
> > 					WRITE TO MEMORY
> > 					IN Z!!
> 
> i guess i'm just being difficult, but process (thread) Y and thread Z
> share the same VM, right? So it's a threaded application, and as such i'd
> expect it to free its state when exiting.

You're being dense. 

The problem spot is the _fork_ from process X. Which gives a address in 
process' _X_ virtual address space - used for SETTID.

See? Process _X_ is not threaded, and is not maintaining any thread data 
structures.

		Linus

