Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264741AbSKJEWv>; Sat, 9 Nov 2002 23:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264742AbSKJEWv>; Sat, 9 Nov 2002 23:22:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36680 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264741AbSKJEWu>; Sat, 9 Nov 2002 23:22:50 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 21:26:53 -0700
In-Reply-To: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
Message-ID: <m1r8duaw36.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 9 Nov 2002, Eric W. Biederman wrote:
> > 
> > And despite my utter puzzlement on why you want the syscall cut in two.
> 
> I'm amazed about your puzzlement, since everybody else seem to get my 
> arguments, but as long as you play along I don't much care.
> 
> I will explain once more why it needs to be cut into two, even if you're 
> apparently willing to do it even without understanding:
> 
> When you reboot, you often cannot load the image.
> 
> 	This is _trivially_ true for panics or things like 

That the load needs to be separate for handling panics is trivially
true.  I simply have a very hard time believing that the load you want
for the normal case will be the load you want for a panic.  I think
I want to be much more paranoid in preparing for the kernel to blow
up.  And I want to move data around much more carefully.  And that
care adds restrictions I want for the normal case.

So splitting it up to prepare for panic handling just looks like over
design. 

> 	But it is _also_ true for any standard setup where you don't have
> 	a special "init" that knows about loading the kernel, and where to
> 	load it from.
> 
> 	 - Do you want to rewrite every "init" setup out there, adding 
> 	   some way to tell init where to load the kernel from?
> 
> 	   Or do you want to just split the thing in two, so that you can 
> 	   load the kernel _before_ you ask init to shut down, and just 
> 	   happily use bog-standard tools that everybody is already 
> 	   familiar with..

When you can change the init setup with just a couple of lines of
shell script seeing if file exists in magic location (say a special
ramfs or tmpfs), I guess it does not look hard to me.

> The two-part loader can clearly handle both cases. And if _you_ don't want
> a two-part loader, you can do exactly what you do now by just doing two 
> system calls. 

Right which is why I don't much care, so long as I don't have to test
reboot on panic any time soon...

I doubt we will see eye to eye on this one.  So I will now finish up
the patch to split this all up.
 
> As to vmalloc - I don't actually much care how the first and second parts
> are implemented. I suggested a vmalloc()-like approach just because your
> patch looks unnecessarily complicated to me. 

I'd love to make it simpler as well if I saw a clear opportunity that
wasn't just moving the complexity somewhere else.  But when I really
look at it I think that I am just wordy.

Eric
