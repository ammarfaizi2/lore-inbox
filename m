Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279370AbRKFN5Z>; Tue, 6 Nov 2001 08:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279321AbRKFN5R>; Tue, 6 Nov 2001 08:57:17 -0500
Received: from ausxc10.us.dell.com ([143.166.98.229]:42767 "EHLO
	ausxc10.us.dell.com") by vger.kernel.org with ESMTP
	id <S279394AbRKFN5H>; Tue, 6 Nov 2001 08:57:07 -0500
Message-ID: <2FE007705F88044F8B2866EB5AB86070012D6292@ausxmrr803.aus.amer.dell.com>
From: Steve_Boley@Dell.com
To: c.pascoe@itee.uq.edu.au, hvisage@is.co.za
Cc: ext2-devel@lists.sourceforge.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com,
        Michael_E_Brown@Dell.com
Subject: RE: another 2.4.12 + aacraid + SuSE failure.
Date: Tue, 6 Nov 2001 07:56:54 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You are the first person that has reported this issue with anything below
2.4.10 kernel.  I'm kicking this over to one of our engineers and hopefully
we can start coming up with something and figure what the fault is here.
Here is something that Hendrik has found that might help find an answer.
Hendrik any luck so far?????  Can you kick back and tell what if anything
you have updated besides the kernel in the system?

Using SGL (sorcerer.wox.org) Linux 2.4.13 + patches
It appears to be only for the ext2 FS's and not for the reiserfs.

Interesting, if you've compiled in kernel debugging & the SysReq key stuff, 
and then issue an emergency sync (Alt-SysReq-S) it works to break the ext2
out of the lock. 

An strace of a hanging e2fsck, hangs at the opening of the device...

I'll perhaps have to try the -ac patches then ...

Hendrik

-----Original Message-----
From: Chris Pascoe [mailto:c.pascoe@itee.uq.edu.au]
Sent: Tuesday, November 06, 2001 7:29 AM
To: Steve_Boley@exchange.dell.com
Subject: RE: another 2.4.12 + aacraid + SuSE failure.


Hi Steve,

I don't understand what you're trying to tell me - so perhaps you read my
message wrong.  I know about alan's patches, I've written a fair bit of
kernel code over the past few years for various reasons, and tracked the
ac kernels along the way - and do know how to clean the kernel tree
completely, etc.  I thought we also determined it was a kernel problem a
while back too.

The problem _is still there_ in the official RH kernel 2.4.9-13 - based on
Alan's kernel!!!  It's not fixed by the AC patches at 2.4.9, at least.
It appeared to be fine, but after a few days of running variants of them,
it dies just the same as before.

RH7.1 is supposedly "supported" by Dell; the kernel I am running is an
errata upgrade for it, so it needs to be fixed back in this kernel version
- going to "vanilla" 2.4.10 and losing the little support that we have
isn't an option.  Going to non-redhat kernels also isn't an option if I
want to run the tested XFS kernel releases on my 3 identical production
servers too, and expect any support from the XFS guys when there's
hiccups.

So, I've got a RH 2.4.9-13 compiled locally now with kdb in it.
Eventually the machine runs out of memory (it seems) if you leave it
sitting at the "Checking root filesystem" and I get a traceback of the
kernel state.  If you break to kdb prior to the crash (i.e.  while the
machine appears hung), or wait for it to crash you get an extremely
strange traceback on the fsck.ext2 process - that suggests something in
the kernel has overwritten something in memory in a bad way.  I just hard
crashed my machine setting breakpoints to try to figure out what was going
on / where this overwriting happens, so I can't try any more (it's 11pm
local time, anyway - I should be sleeping).

Chris

On Tue, 6 Nov 2001 Steve_Boley@Dell.com wrote:

> Found that the problem is kernel oriented in some way.  I went and got
Alan
> Cox's patches for the 2.4.10 and applied the latest did a make mrproper
> which starts completely over and then applied the aacraid patch again and
> then recompiled and is coming up clean every time now.  RedHat kernels are
> built and based on Alan Cox's kernel so there is some patch he has in the
> kernel that is fixing the issues.  So if you go to kernel.org and go to
> linux and then kernel and then people his folder is alan and he has
patches
> for every 2.4 version there is in this folder.  I was experiencing the
same
> hangs due to the fact that I have Mandrake 8.1 loaded on the PE2500
instead
> of Redhat and it seems to be for now that Suse and Mandrake have the
problem
> for sure and I'm not very sure about Debian at this point.
>
> -----Original Message-----
> From: Chris Pascoe [mailto:c.pascoe@itee.uq.edu.au]
> Sent: Monday, November 05, 2001 8:06 PM
> To: Steve_Boley@exchange.dell.com
> Cc: linux-PowerEdge@exchange.dell.com;
> linux-aacraid-devel@exchange.dell.com
> Subject: Re: another 2.4.12 + aacraid + SuSE failure.
>
>
> Hi Steve,
>
> > Been pounding away on recompiling 2.4.10 on PE2500 with PERC3/DI and was
> > getting the same hang at CHECKING ROOT FILESYSTEM.
> [...]
>
> I'm now seeing these hangs with the RedHat 2.4.9-13 kernel - 4 consecutive
> reboots now, it's just hung on but it has been fine before.  I'll power
> cycle the machine (test box) shortly.  Any further ideas / news on this
bug?
>
> Chris
>
>
> _______________________________________________
> Linux-PowerEdge mailing list
> Linux-PowerEdge@dell.com
> http://lists.us.dell.com/mailman/listinfo/linux-poweredge
>


