Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWHBFZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWHBFZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWHBFZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:25:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:22678 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751246AbWHBFZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:25:15 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
Date: Wed, 2 Aug 2006 07:21:44 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <200608020507.50590.ak@suse.de> <m1slkfvinh.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1slkfvinh.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020721.44139.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 August 2006 06:57, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> >> > Actually the best way to reuse would be to first do 64bit uncompressor
> >> > and linker directly, but short of that #includes would be fine too.
> >> 
> >> > Would be better to just pull in lib/string.c
> >> 
> >> Maybe.  Size is fairly important 
> >
> > Why is size important here?
> 
> For the same reason that we compress the kernel. ;)
> 
> This is the one chunk of code that we don't compress so every extra
> byte makes our executable bigger.  Now I think the code size is
> actually in the 32k - 64k range so as long as it is a minor change
> it doesn't really matter.

   text    data     bss     dec     hex filename
   1909     352      12    2273     8e1 arch/x86_64/kernel/early_printk.o
   2212       0       0    2212     8a4 lib/string.o

It's minor.

> 
> The big pain with using lib/string.c and
> arch/x86_64/kernel/early_printk.c is that it is significant change
> in how the code of misc.c is constructed.  

Not if you use #include

> Which means some 
> serious reevaluation of all kinds of things need to be considered.
> Making it a lot of work :)
> 
> One of the practical dangers is that we make it more likely
> we can kill the boot by messing up the shared code.

If they're messed up the later boot will fail too. Doesn't make
too much difference.

> 
> I'm not certain what to think when even including normal
> kernel headers causes problems.  It certainly makes me leery
> of including normal kernel code.  But it might simplify some
> of the problems too.

On x86-64 some trouble comes from it being 32bit code. 
That is why I suggested making it 64bit first, which would
avoid many of the problems.
 
> Whichever way I go scrutinizing that possibility carefully is
> a lot of work.

64bit conversion would be some work, the rest isn't I think.

Alternatively if you don't like it we can just drop these compressor patches.
I don't think they were essential.

-Andi
