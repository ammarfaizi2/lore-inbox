Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316663AbSFFBmj>; Wed, 5 Jun 2002 21:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSFFBmi>; Wed, 5 Jun 2002 21:42:38 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:49137 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316663AbSFFBmh>; Wed, 5 Jun 2002 21:42:37 -0400
Date: Wed, 5 Jun 2002 21:42:38 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@redhat.com>, lord@sgi.com, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020605214238.K4697@redhat.com>
In-Reply-To: <20020604225539.F9111@redhat.com> <1023315323.17160.522.camel@jen.americas.sgi.com> <20020605183152.H4697@redhat.com> <20020605.161342.71552259.davem@redhat.com> <m3d6v5mcm2.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 03:15:17AM +0200, Andi Kleen wrote:
> The scenario Steve outlined was rather optimistic - more pessimistic
> case would be e.g:
> you run NBD which calls the network stack with an complex file system on top
> of it called by something else complex that does a GFP_KERNEL alloc and VM 
> wants to flush a page via the NBD file system - I don't see how you'll ever 
> manage to fit that into 4K.

Which is, honestly, a bug.  The IO subsystem should not be capable of 
engaging in such deep recursion.  ext2/ext3 barely allocate anything 
on the stack (0x90 bytes at most in only a couple of calls), the vm 
is in a similar state, and even the network stack's largest allocations 
are in syscalls and timer code.  Face it, the majority of code that is 
or could cause problems are things that probably need fixing anyways.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
