Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277572AbRJRDXr>; Wed, 17 Oct 2001 23:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277573AbRJRDXi>; Wed, 17 Oct 2001 23:23:38 -0400
Received: from zok.SGI.COM ([204.94.215.101]:52363 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277572AbRJRDX3>;
	Wed, 17 Oct 2001 23:23:29 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: MODULE_LICENSE and EXPORT_SYMBOL_GPL
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 18 Oct 2001 13:23:53 +1000
Message-ID: <8658.1003375433@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That has been a lot of uninformed and confused comment on l-k about
MODULE_LICENSE and EXPORT_SYMBOL_GPL.  I will try to make this as
simple as possible, to improve the signal to noise ration on this list.

Don't bother cc'ing me on any replies.  Also I don't care what your
view of the GPL is or should be.

MODULE_LICENSE

MODULE_LICENSE() allows kernel developers to identify kernels that have
been tainted by modules whose source code is not generally available.
No source code means that only the supplier can debug the problem so
send the bug report to them, not l-k.  Precisely which license string
indicates that source is freely available is still being fine tuned.

A module without a license must be assumed to be proprietary.  Not all
existing modules have a MODULE_LICENSE() yet but most do, the rest are
not far behind.  For code that is not in the standard kernel tree, it
is up to the supplier to set the license string accordingly.  I
recommend that binary only modules contain a string like :-

  MODULE_LICENSE("Proprietary.  Send bug reports to joe.bloggs@somewhere")

Modutils marks the kernel as tainted when it loads a module without a
GPL compatible MODULE_LICENSE(), reporting the license string so users
know where to send bug reports.  Oops reports the tainted status of the
kernel.  Kernel developers can decide if they want to look at tainted
bug reports or not.  End of story.

Somebody raised the red herring of linking proprietary code into the
kernel.  If you compile and link code into the kernel and do not
provide the source then you cannot distribute the resulting kernel.  To
do so is a breach of GPL conditions, read the GPL if you don't believe
me.  There is nothing to stop you building your own kernel with binary
only code and using it internally, but any bugs are your problem and
you cannot distribute the result.

EXPORT_SYMBOL_GPL

Some kernel developers are unhappy with providing external interfaces
to their code, only to see those interfaces being used by binary only
modules.  They view it as their work being appropriated.  Whether you
agree with that view or not is completely irrelevant, the person who
owns the copyright decides how their work can be used.

EXPORT_SYMBOL_GPL() allows for new interfaces to be marked as only
available to modules with a GPL compatible license.  This is
independent of the kernel tainting, but obviously takes advantage of
MODULE_LICENSE() strings.

EXPORT_SYMBOL_GPL() may only be used for new exported symbols, Linus
has spoken.  I believe the phrase involved killer penguins with
chainsaws for anybody who changed existing exported interfaces.

System calls are not affected and cannot be, that is yet another red
herring.  Anybody who thinks otherwise does not understand the GPL.
System calls define how user space code accesses the kernel, nobody
pretends that a binary only user space program cannot use a syscall.

