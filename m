Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265571AbSKFCpH>; Tue, 5 Nov 2002 21:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265568AbSKFCpH>; Tue, 5 Nov 2002 21:45:07 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:64834 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265571AbSKFCpG>; Tue, 5 Nov 2002 21:45:06 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	<3DC19A4C.40908@pobox.com> <20021031193705.C2599@almesberger.net>
	<20021105171230.A11443@in.ibm.com>
	<20021105150048.H1408@almesberger.net>
	<1036521360.5012.116.camel@irongate.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Nov 2002 19:48:58 -0700
In-Reply-To: <1036521360.5012.116.camel@irongate.swansea.linux.org.uk>
Message-ID: <m1lm47fm5h.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Tue, 2002-11-05 at 18:00, Werner Almesberger wrote:
> > Yes, I've just checked with Eric, and he hasn't received any
> > indication from Linus so far. I posted a reminder to linux-kernel.
> > I'd really hate to see kexec miss 2.6.
> 
> Let me ask the same dumb question - what does kexec need that a dumper
> doesn't. In other words given reboot/trap hooks can kexec happily live
> as a standalone module ?

Kexec primarily needs the reboot/trap hooks in working order, and exported,
for it to live externally to the kernel.  

Currently the reboot_notifier call chain is private to sys.c, and is not
exported even to other parts of the kernel.

Even together device_shutdown, and the reboot_notifier do not properly shutdown
the cpus on an SMP system.

Plus we are missing quite a ->shutdown methods at random in the kernel, and if
kexec is not easily available someone might not get around to writing
and debugging them.

Plus a system call seems the natural interface for something that
appears to be a reboot.

Eric
