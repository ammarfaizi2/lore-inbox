Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263256AbSKJDKq>; Sat, 9 Nov 2002 22:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSKJDKq>; Sat, 9 Nov 2002 22:10:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8457 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263270AbSKJDKp>; Sat, 9 Nov 2002 22:10:45 -0500
Date: Sat, 9 Nov 2002 19:17:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
In-Reply-To: <m1of8ycihs.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 9 Nov 2002, Eric W. Biederman wrote:
> 
> And despite my utter puzzlement on why you want the syscall cut in two.

I'm amazed about your puzzlement, since everybody else seem to get my 
arguments, but as long as you play along I don't much care.

I will explain once more why it needs to be cut into two, even if you're 
apparently willing to do it even without understanding:

When you reboot, you often cannot load the image.

	This is _trivially_ true for panics or things like 

	 - I don't understand why you do not want to accept this. Even if 
	   your code doesn't even _handle_ panics, it's so obvious that 
	   this is true that I don't understand why you want a limitation
	   in your particular current implementation to be a fundamental
	   flaw of the whole idea.

	But it is _also_ true for any standard setup where you don't have
	a special "init" that knows about loading the kernel, and where to
	load it from.

	 - Do you want to rewrite every "init" setup out there, adding 
	   some way to tell init where to load the kernel from?

	   Or do you want to just split the thing in two, so that you can 
	   load the kernel _before_ you ask init to shut down, and just 
	   happily use bog-standard tools that everybody is already 
	   familiar with..

The two-part loader can clearly handle both cases. And if _you_ don't want
a two-part loader, you can do exactly what you do now by just doing two 
system calls. 

As to vmalloc - I don't actually much care how the first and second parts
are implemented. I suggested a vmalloc()-like approach just because your
patch looks unnecessarily complicated to me. But while I am convinced that 
the two-phase loading/exec is absolutely the way to do it, the actual 
low-level implementation is just a detail.

			Linus

