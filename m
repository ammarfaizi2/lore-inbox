Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264894AbUFAFyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264894AbUFAFyA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 01:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264895AbUFAFyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 01:54:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56025 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264894AbUFAFx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 01:53:57 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Phy Prabab <phyprabab@yahoo.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4g/4g for 2.6.6
References: <20040523194302.81454.qmail@web90007.mail.scd.yahoo.com>    
	<Pine.LNX.4.58.0405231329460.25502@ppc970.osdl.org>
	<40B10EC1.3030602@pobox.com>
	<Pine.LNX.4.58.0405231854240.25502@ppc970.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 31 May 2004 23:52:10 -0600
In-Reply-To: <Pine.LNX.4.58.0405231854240.25502@ppc970.osdl.org>
Message-ID: <m1acznygdx.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 23 May 2004, Jeff Garzik wrote:
> > 
> > Sorta like I'm hoping that cheap and prevalent 64-bit CPUs make PAE36 
> > and PAE40 on ia32 largely unnecessary.  Addressing more memory than 32 
> > bits of memory on a 32-bit CPU always seemed like a hack to me, and a 
> > source of bugs and lost performance...
> 
> I agree. I held out on PAE for a longish while, in the unrealistic hope 
> that people would switch to alpha's. 
> 
> Oh, well. I don't expect _everybody_ to switch to x86-64 immediately, but 
> I hope we can hold out long enough without 4g that it does work out this 
> time.

Sounds sane. 

One of the real problems on machines with more than 4GB in 32bit mode
is where do you put all of the pci resources.  Especially when you start
getting into machines with large memory mapped resources of 128MB or more.

On Intel chipsets that is usually not a problem because you can relocate the
memory from under those resources and still get at it with PAE36.  Other
chipsets don't really have that kind of capability.

>From what I can tell all of the large PCI memory mapped resources are
64bit.  Which gives another solution of simply moving all of those
large memory mapped I/O resources above the memory entirely.  Besides
solving my immediate problem of loosing 1/2GB of memory in some
cases, that looks like the only sane long term solution.

So to encourage x86-64 usage, I am going to implement that in
LinuxBIOS and encourage any other BIOS vendor I run into to
follow suit.  That way the only painful customer questions I will
get will be why doesn't this high performance card work with a
32bit kernel :)  Which is much easier to explain :)

Can anyone think of a reason that would not be a good solution?


Eric










