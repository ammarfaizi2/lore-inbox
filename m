Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSKLHXT>; Tue, 12 Nov 2002 02:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSKLHXT>; Tue, 12 Nov 2002 02:23:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47691 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266271AbSKLHXR>; Tue, 12 Nov 2002 02:23:17 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Kexec for v2.5.47 (test feedback)
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 12 Nov 2002 00:22:11 -0700
In-Reply-To: <1037055149.13304.47.camel@andyp>
Message-ID: <m1isz39rrw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Mon, 2002-11-11 at 10:15, Eric W. Biederman wrote:
> > kexec is a set of system calls that allows you to load another kernel
> > from the currently executing Linux kernel.
> 
> > And is currently kept in two pieces.
> > The pure system call.
> > http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.47.x86kexec.diff
> 
> FYI: that patch applies cleanly to pure 2.5.47 (bk ChangeSet@1.823).
> 
> The current front of the tree does not patch 100% cleanly (conflicts
> with recent module changes).

I will have to take a look next time a snapshot is uploaded.  bk and I have
not yet become friends.
 
> Results on my usual problem machine:
> 
> # ./kexec-1.5 ./kexec_test-1.5
> Shutting down devices
> Debug: sleeping function called from illegal context at include/asm/semaphore.h9
> 
> Call Trace: [<c011a698>] [<c0216193>] [<c012b165>] [<c0132dec>] [<c0140357>

Hmm. I wonder what is doing that.  Do you have the semaphore problem on a normal reboot?

> Starting new kernel
> 
> kexec_test 1.5 starting...
> eax: 0E1FB007 ebx: 00001078 ecx: 00000000 edx: 00000000
> esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
> idt: 00000000 C0000000
> gdt: 00000000 C0000000
> Switching descriptors.
> Descriptors changed.
> Legacy pic setup.
> In real mode.
> <hang>

Yep it works until it runs into your apics that are not shutdown.
That looks like one of the next things to tackle.
 
> Same as last time, but the good news is that splitting the load and reboot
> operations works as expected.

That is what my test machine said as well.  But the confirmation is nice. 
And it definitely means I uploaded a working sample user space.
 
> > And the set of hardware fixes known to help kexec.
> >
> http://www.xmission.com/~ebiederm/files/kexec/linux-2.5.47.x86kexec-hwfixes.diff
> 
> 
> Missing or inaccessible.  I'll try some duct tape and the
> linux-2.5.44.x86kexec-hwfixes.diff and see what happens.

The .47 version is pretty much just a forward port.  It is uploaded now.
My apologies for not getting to it earlier.

The challenge is with the apic shutdown is that currently the apics are not
in the device tree so that needs to happen before I can submit a good version
for 2.5.x
 

> Confirming some earlier suspicions:
> CONFIG_SMP=y
> CONFIG_X86_GOOD_APIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> 
> Last time I tried to run a UP kernel (and no APIC support) on this system
> it wasn't pretty.  I'll add that to my list of combinations to try.

I would not worry about it to much.  I'm just happy my tools are good enough
that with a little thinking I can figure out what the problem is.
Getting there was hard.

Eric


