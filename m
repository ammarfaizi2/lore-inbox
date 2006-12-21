Return-Path: <linux-kernel-owner+w=401wt.eu-S964943AbWLULju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWLULju (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 06:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbWLULjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 06:39:49 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:37650 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964956AbWLULjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 06:39:48 -0500
Date: Thu, 21 Dec 2006 06:38:14 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jean Delvare <khali@linux-fr.org>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Patch "i386: Relocatable kernel support" causes instant reboot
Message-ID: <20061221010814.GA30299@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061220141808.e4b8c0ea.khali@linux-fr.org> <m1tzzqpt04.fsf@ebiederm.dsl.xmission.com> <20061220214340.f6b037b1.khali@linux-fr.org> <m1mz5ip5r7.fsf@ebiederm.dsl.xmission.com> <20061221101240.f7e8f107.khali@linux-fr.org> <20061221102232.5a10bece.khali@linux-fr.org> <m164c5pmim.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m164c5pmim.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2006 at 03:32:33AM -0700, Eric W. Biederman wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> 
> > On Thu, 21 Dec 2006 10:12:40 +0100, Jean Delvare wrote:
> >> On Wed, 20 Dec 2006 15:22:20 -0700, Eric W. Biederman wrote:
> >> > Ok.  Here is a small diff that inserts the infinite loops, between
> >> > each section of code in head.S  Procedurally please trying booting
> >> > this unmodified and see if it boots, then remove the infinite loop
> >> > until you come to the one where the system reboots instead of hangs.
> >> >
> >> > That should at least give me a good idea of where to look.
> >> > If 20 hangs and 21 still reboots we are into misc.c and the
> >> > decompressor.  And I will have to ask something different.
> >>
> >> OK, I'll start the tests now, I'll let you know the outcome when I'm
> >> done.
> >
> > Hm, that was quick... Even with your unmodified patch, the machine
> > still reboots. Does that make any sense to you?
> >
> > I can try installing a more recent system on the same hardware if it
> > helps.
> 
> Grr.  I guessed the problem was to late in the game it seems the problem
> is in setup.S  Before we switch to 32bit mode.
> 
> Ok.  There is almost enough for inference but here is a patch of stops
> for setup.S let's see if one of those will stop the reboots.
> 
> I have a strong feeling that we are going to find a tool chain issue,
> but I'd like to find where we ware having problems before we declare
> that to be the case.
> 

Looks like it might be a tool chain issue. I took Jean's config file and
built my own kernel and I am able to boot the kernel. But I can't boot
his bzImage. I observed the same behaviour as jean is experiencing. It jumps
back to BIOS.

I am using grub 0.97. So any dependency on lilo can be ruled out in this
case.

Following is my software environment.

gcc version 4.1.1 20061130 (Red Hat 4.1.1-43)
GNU ld version 2.17.50.0.6-2.el5 20061020

I got Intel Xeon machine.

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.40GHz
stepping        : 3
cpu MHz         : 3400.483
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe lm constant_tsc pni monitor ds_cpl est cid cx16 xtpr
bogomips        : 6805.59
clflush size    : 64

Thanks
Vivek
