Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313904AbSDPUvY>; Tue, 16 Apr 2002 16:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313908AbSDPUvY>; Tue, 16 Apr 2002 16:51:24 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:48464
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id <S313904AbSDPUvW>; Tue, 16 Apr 2002 16:51:22 -0400
Message-Id: <200204162051.g3GKpDb05800@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: ebiederm@xmission.com (Eric W. Biederman)
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 arch subdivision into machine types for 2.5.8 
In-Reply-To: Message from ebiederm@xmission.com (Eric W. Biederman) 
   of "16 Apr 2002 13:30:19 MDT." <m1r8lfigqc.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 16 Apr 2002 15:51:12 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com said:
> - There is no way to build a generic kernel, that just needs
>   a command line to select the architecture.  Something that is
> important
>   for installers.  Even better would auto detection of the platform
> from
>   firmware information, but you can't always do that. 

The design is to do this from config.in, not to modularise so you can select 
on boot.  Is that what you were asking?

> - By just allowing redirecting setup_memory_region you don't allow for
>   architectures that don't have the 384K memory hole. 

True.  The split has been evolved only far enough to let me slot in the 
voyager port fairly easily, and it has a 384K hole too.  The idea is more to 
begin the framework, so others can adapt it as more machine types come along.

Like all abstractions, unless they're tightly bound to the actual use, they 
can become unwieldy and unusable very quickly as you abstract out things that 
no-one is ever going to want.  I erred on the side of utility.

> - setup_arch.h is nasty.  What code it has depends on what it is
> defined
>   when it is included.  Couldn't 2 headers to this job better?  Or
> better yet
>   can't you just use function calls? 

I agree with both of these.  The main problem with the memory setup calls is 
that most of them are static.  I could export them and do overrides, like I do 
for everything else, but as someone who also debugs the kernel, I like static 
functions because they tell me the use is tightly isolated.  I could easily do 
two files, it was just looking more messy.

I'll see if I can export some of the setup.c internals and re-arrange this in 
a more orderly way.

> - The hooks you add aren't used and are so generic it isn't obvious
> what
>   they are supposed do from their names. 

All of them are used if you look at the additional voyager stuff, what names 
would you like to be more explicit?

> And of course you don't look at allowing different firmware
> implementations, but I'm doing that, so it is covered. :) 

actually, I've silently ignored all the boot problems as well.

James


