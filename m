Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313895AbSDPVvs>; Tue, 16 Apr 2002 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313906AbSDPVvr>; Tue, 16 Apr 2002 17:51:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41546 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S313895AbSDPVvq>; Tue, 16 Apr 2002 17:51:46 -0400
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8
In-Reply-To: <200204162051.g3GKpDb05800@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Apr 2002 15:44:37 -0600
Message-ID: <m1n0w3iaii.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> ebiederm@xmission.com said:
> > - There is no way to build a generic kernel, that just needs
> >   a command line to select the architecture.  Something that is
> > important
> >   for installers.  Even better would auto detection of the platform
> > from
> >   firmware information, but you can't always do that. 
> 
> The design is to do this from config.in, not to modularise so you can select 
> on boot.  Is that what you were asking?

Yes.  I'm totally for the ability to select from config.in.  But at
the same time having being able to build a kernel that works in all
kinds of configurations comes in quite handy.  I know the alpha does
this I'm not quite certain about ARM.


> > - By just allowing redirecting setup_memory_region you don't allow for
> >   architectures that don't have the 384K memory hole. 
> 
> True.  The split has been evolved only far enough to let me slot in the 
> voyager port fairly easily, and it has a 384K hole too.  The idea is more to 
> begin the framework, so others can adapt it as more machine types come along.
> 
> Like all abstractions, unless they're tightly bound to the actual use, they 
> can become unwieldy and unusable very quickly as you abstract out things that 
> no-one is ever going to want.  I erred on the side of utility.

True.  It's just that I have a machine that doesn't have the 384K hole..
I found all I needed to export was add_memory_region and
print_memory_region, and then I could do whatever was needed.
 
> > - setup_arch.h is nasty.  What code it has depends on what it is
> > defined
> >   when it is included.  Couldn't 2 headers to this job better?  Or
> > better yet
> >   can't you just use function calls? 
> 
> I agree with both of these.  The main problem with the memory setup calls is 
> that most of them are static.  I could export them and do overrides, like I do 
> for everything else, but as someone who also debugs the kernel, I like static 
> functions because they tell me the use is tightly isolated.  I could easily do 
> two files, it was just looking more messy.
> 
> I'll see if I can export some of the setup.c internals and re-arrange this in 
> a more orderly way.
> 
> > - The hooks you add aren't used and are so generic it isn't obvious
> > what
> >   they are supposed do from their names. 
> 
> All of them are used if you look at the additional voyager stuff, what names 
> would you like to be more explicit?

O.k.  When I was looking I hadn't gotten that post yet.

The names pre_arch_setup_hook is my best example, seems to
answer nothing.

And ARCH_SETUP looks nasty.  

> 
> > And of course you don't look at allowing different firmware
> > implementations, but I'm doing that, so it is covered. :) 
> 
> actually, I've silently ignored all the boot problems as well.

Do you have boot problems on the NCR voyagers?  If so I'd be
interested in hearing what the issues are.

Eric
