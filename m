Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbSKSRfw>; Tue, 19 Nov 2002 12:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbSKSRfv>; Tue, 19 Nov 2002 12:35:51 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48981 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266968AbSKSRfu>; Tue, 19 Nov 2002 12:35:50 -0500
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>
	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>
	<m1k7jb3flo.fsf_-_@frodo.biederman.org>
	<m1el9j2zwb.fsf@frodo.biederman.org>
	<m11y5j2r9t.fsf_-_@frodo.biederman.org> <3DD99EA6.4010000@us.ibm.com>
	<m1of8l27fy.fsf@frodo.biederman.org> <3DDA65B7.8070703@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2002 10:42:06 -0700
In-Reply-To: <3DDA65B7.8070703@us.ibm.com>
Message-ID: <m165ut1moh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen <haveblue@us.ibm.com> writes:

> Eric W. Biederman wrote:
> > Dave Hansen <haveblue@us.ibm.com> writes:
> >>The NUMAQ is another story, though.  I get nothing after "Starting new
> kernel".
> 
> >>But, I wasn't expecting much.  The NUMAQ is pretty weird hardware and god
> knows
> 
> >>what is actually happening.  I'll try it some more when I'm more confident in
> >>what I'm doing.
> > I suspect the hardware shutdown and start up logic for NUMAQ cpus needs some
> > special handling.  Does kexec_test not print anything, or were you not patient
> 
> > enough?
> 
> Starting new kernel
> kexec_test 1.6 starting...
[snip successful run of kexec_test]
 

Hmm.  So it looks like you can make bios calls, on the NUMAQ machine.
It is worth a try to see if "kexec --real_mode bzImage...." will start
up your kernel.   Probably not but at least the basic mechanism of kexec
is working.  I would be very surprised if you couldn't at least start
a uniprocessor kernel.

> I have a couple of ideas.  But, first, is it hard to reconstruct the memory map?

>From your kexec_test run, your memory map...

> E820 Memory Map.
> 000000000009FC00 @ 0000000000000000 type: 00000001
> 00000000EFF00000 @ 0000000000100000 type: 00000001
> 0000000000180000 @ 00000000FFE80000 type: 00000002
> 0000000000009000 @ 00000000FEC00000 type: 00000002
> 0000000100000000 @ 0000000100000000 type: 00000001
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The e820 memory map is printed out on boot up.
> 
> Will all 1GB systems have the same memory map? 

Most will have pretty much the same memory map, but in general all systems
with same amount of ram will have different memory maps.   

>  Do you have documentation of the
> format?  I don't think that any of these qualify as the "right thing".  But, as
> hacks, they should keep me happy for a bit.
> 
> For now, I can write a quick script to fix it: --command-line="`memscript`"
> 
> Until it is working a --hack-mem option might be a good idea
> 
> Perhaps we could just save a copy off when the kernel loads for the first
> time. If we export it somewhere, the kexec executable can just copy it.  For
> now, we can just printk it and paste it into each version of kexec that we
> compile.

Yep, essentially that is what needs to happen.

Eric
