Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSFFCff>; Wed, 5 Jun 2002 22:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316746AbSFFCfe>; Wed, 5 Jun 2002 22:35:34 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:34537 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S316723AbSFFCfd>;
	Wed, 5 Jun 2002 22:35:33 -0400
Subject: Re: [RFC] 4KB stack + irq stack for x86
From: Stephen Lord <lord@sgi.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020605214238.K4697@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 Jun 2002 21:30:05 -0500
Message-Id: <1023330607.1178.21.camel@snafu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 20:42, Benjamin LaHaise wrote:
> On Thu, Jun 06, 2002 at 03:15:17AM +0200, Andi Kleen wrote:
> > The scenario Steve outlined was rather optimistic - more pessimistic
> > case would be e.g:
> > you run NBD which calls the network stack with an complex file system on top
> > of it called by something else complex that does a GFP_KERNEL alloc and VM 
> > wants to flush a page via the NBD file system - I don't see how you'll ever 
> > manage to fit that into 4K.
> 
> Which is, honestly, a bug.  The IO subsystem should not be capable of 
> engaging in such deep recursion.  ext2/ext3 barely allocate anything 
> on the stack (0x90 bytes at most in only a couple of calls), the vm 
> is in a similar state, and even the network stack's largest allocations 
> are in syscalls and timer code.  Face it, the majority of code that is 
> or could cause problems are things that probably need fixing anyways.
> 

Well, reclaiming memory within the same thread which is allocating
memory is surely the root cause of this, not the I/O system.


Steve


