Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313846AbSDIL25>; Tue, 9 Apr 2002 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313849AbSDIL24>; Tue, 9 Apr 2002 07:28:56 -0400
Received: from [62.221.7.202] ([62.221.7.202]:38281 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313846AbSDIL2z>; Tue, 9 Apr 2002 07:28:55 -0400
Date: Sun, 7 Apr 2002 17:36:46 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 problems with netfilter linking
Message-Id: <20020407173646.40d7c0b7.rusty@rustcorp.com.au>
In-Reply-To: <15086.1018068482@ocs3.intra.ocs.com.au>
X-Mailer: Sylpheed version 0.7.2 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Apr 2002 14:48:02 +1000
Keith Owens <kaos@ocs.com.au> wrote:

> AKA - Rusty shoots himself in the foot :)
> 
> kbuild 2.5 defines
> 
>  -DKBUILD_OBJECT=module, the name of the module the object is linked
>     into, without the trailing '.o' and without any paths.  If the
>     object is a free standing module or is linked into vmlinux then the
>     "module" name is the object itself.  Automatically generated.
> 
> This variable is aimed at standardizing boot and module parameters, so
> 'insmod foo option=value' and booting with 'foo.option=value' will have
> exactly the same effect.  Rusty already has code to do this and is
> waiting for kbuild 2.5 to go in.
> 
> Alas netfilter has objects that are linked into multiple modules,
> $(ip_nf_compat-objs) is linked into both ipfwadm and ipchains so
> KBUILD_OBJECT is ambiguous.  Two possible solutions -
> 
> * Change netfilter so the objects are not linked twice.  That will
>   require $(ip_nf_compat-objs) to be a module in its own right with
>   extra exported symbols.

I considered this very carefully when I wrote the code, but the interface
exposed by it is quite ugly: it really is an internal interface between
the two.

> * Change kbuild 2.5 to detect multi linked objects and not set
>   KBUILD_OBJECT for those objects.  It follows that multi linked
>   objects cannot have module or boot parameters, so change modules.h to
>   barf on MODULE_PARM() and __setup() when KBUILD_OBJECT is not
>   defined.
> 
> I am tending towards the second solution.

You missed "#include "foo.c"" as a possible workaround.  Note that it's
a waste of disk space, not memory, since these cannot be loaded at the
same time.

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
