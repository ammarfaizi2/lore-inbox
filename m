Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130751AbQKLNXQ>; Sun, 12 Nov 2000 08:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130745AbQKLNXH>; Sun, 12 Nov 2000 08:23:07 -0500
Received: from slc150.modem.xmission.com ([166.70.9.150]:58375 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130788AbQKLNXA>; Sun, 12 Nov 2000 08:23:00 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
        Tigran Aivazian <tigran@veritas.com>,
        "H. Peter Anvin" <hpa@transmeta.com>, Max Inux <maxinux@bigfoot.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: bzImage ~ 900K with i386 test11-pre2
In-Reply-To: <Pine.LNX.4.21.0011111644110.1036-100000@saturn.homenet> <m1ofzmcne5.fsf@frodo.biederman.org> <20001112122910.A2366@athlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Nov 2000 06:14:36 -0700
In-Reply-To: Andrea Arcangeli's message of "Sun, 12 Nov 2000 12:29:10 +0100"
Message-ID: <m1k8a9badf.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Sat, Nov 11, 2000 at 12:35:46PM -0700, Eric W. Biederman wrote:
> > With respect to .bss issues we should clear it before we set up page tables.
> 
> We could sure do that but that's a minor win since we still need a
> large mapping (more than 1 pagetable) for the bootmem allocator. (and we need
> at least 1 pagetable setup as ident mapping at 0x100000 for the instruction
> where we enable paging)
> 
> > We also do stupid things like set segment registers before setting up
> > a GDT.  Yes we set them in setup.S but it is still a stupid non-obvious
> 		     ^^^^
> I think you meant: we set "it" (gdt_48) up.

I was thinking segment descriptors.

> 
> > dependency.  We we can do it in setup.S
> 
> I removed that dependency in x86-64.

Maniacal cackle....

x86-64 doesn't load the segment registers at all before use.
This is BAD BAD BAD!!!!!!!
I can tell you don't have real hardware.  The non obviousness
of correct operation tripped you up as well.

So while you load the gdt before you set a segment register later,
which is good the more important part was still missed.

O.k. on monday I'll dig up my patch and that clears this up.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
