Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbSKKR7t>; Mon, 11 Nov 2002 12:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbSKKR7t>; Mon, 11 Nov 2002 12:59:49 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52298 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266886AbSKKR7p>; Mon, 11 Nov 2002 12:59:45 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 Nov 2002 11:03:43 -0700
In-Reply-To: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>
Message-ID: <m1znsg9e68.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 9 Nov 2002, Eric W. Biederman wrote:
> > 
> > And despite my utter puzzlement on why you want the syscall cut in two.
> 
> I'm amazed about your puzzlement, since everybody else seem to get my 
> arguments, but as long as you play along I don't much care.

I think this comes from being the guy down in the trenches implementing
the code.   And it is sometimes hard to look up, far enough to have design
discussions.

I totally agree that having a load/exec split is the right
approach now that I can imagine an implementation where the code will
actually work for the panic case.  Before it felt like lying.  Doing
the  split-up, promising that kexec on panic will work eventually,
when I could not even see it as a possibility was at the core of my
objections.

What brought me around is that I can add a flag field to kexec_load.
With that flag field I can tell the kernel please step extra carefully
this code will be used to handle kexec on panic.  Without that I may
be up a creek without a paddle for figuring out how to debug that code.

To be able to support this at all I have had to be very creative in
inventing debugging code.  Which is why I have the serial console
program kexec_test.  It provides visibility into what is happening
when nothing else will.  That and memtest86 which will occasionally
catch DMA's that have not been stopped, (memory errors on good ram) I
at least have a place to start rather than a blank screen when
guessing why the new kernel did not start up.

Eric
