Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSJVOoa>; Tue, 22 Oct 2002 10:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbSJVOoa>; Tue, 22 Oct 2002 10:44:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52270 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S262796AbSJVOo2>; Tue, 22 Oct 2002 10:44:28 -0400
To: landley@trommello.org
Cc: Andy Pfiffer <andyp@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: [Fastboot] [CFT] kexec syscall for 2.5.43 (linux booting linux)
References: <m1k7kfzffk.fsf@frodo.biederman.org>
	<m1ptu3t3ec.fsf@frodo.biederman.org>
	<m1fzuyub3z.fsf@frodo.biederman.org>
	<200210212257.40050.landley@trommello.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Oct 2002 08:48:43 -0600
In-Reply-To: <200210212257.40050.landley@trommello.org>
Message-ID: <m17kgattpw.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <landley@trommello.org> writes:

> On Tuesday 22 October 2002 03:33, Eric W. Biederman wrote:
> 
> > j < Printed from the second callback in setup.S, just before the
> > kernel decompresser is run >
> >
> >
> > I have a very strange node that makes it all of the way to 'j' before
> > rebooting. The concept that something is dying in protected mode will all
> > of the interrupts disabled is so novel that I really don't know what to
> > make of it, yet.
> 
> It would almost have to be the MMU.  Any way to dump the page tables?

I don't know yet.  I need to find a way to install some additional hooks
at run time so I can narrow down where the failure is occuring.  I
will have to look, but I should be able to set up an interrupt
descriptor table and single step through the code.  

What has me very puzzled is that I can boot that same kernel if I run
a substitute for setup.S that makes a similar set of BIOS calls.

The kernel I am having problems with is an old 2.4.17 kernel.  But
more than anything my goal is to make the boot process debuggable
without requiring a recompile.  So I can ask users to throw a switch
and I can find out where things are failing.

I may be able to recompile that 2.4.17 kernel and then edit the build
so I can get more debug information.  But if it is my preference to
attempt to track down what is happening without doing that.
Especially as it is more useful if that does not happen.

The compressor in misc.c runs without a page table enabled, so it may
be something before the page tables are enabled. 

Eric
