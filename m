Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbUK3XOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbUK3XOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbUK3XLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:11:23 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262441AbUK3XGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:06:06 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	<19865.1101395592@redhat.com>
	<20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	<1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	<20041127032403.GB10536@kroah.com>
	<16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	<ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	<8219.1101828816@redhat.com>
	<Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
	<ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	<orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
	<Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 30 Nov 2004 21:05:39 -0200
In-Reply-To: <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
Message-ID: <orzn0zq6nw.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2004, Linus Torvalds <torvalds@osdl.org> wrote:

> Wrong. They'll _still_ have to maintain duplicates, since they can't rely
> ont he end-user to have a recent enough kernel.

No.  They just won't have the headers for the newer kernel installed
on their system.  They stick with the kernel ABI headers provided by a
baseline kernel, and that's probably from an older kernel tarball.

> It's just that they can hopefully start _copying_ their dupliates more 
> easily.

It's still the headers from the kernel, copied or not.  From a
different, baseline version, maybe.

> At RH you may see only the case where people do a whole-system upgrade. 

I personally don't care about the case you perceive as the Red Hat
case, because I work on embedded systems development, in a different
organization within Red Hat than the people who develop Red Hat
Enterprise Linux and Fedora.  So yes, in the case that actually
benefits me, it's even more of a whole-system thing, since for our
group it's *the* kernel, not *a* random kernel version.  It's the
kernel we port and ship to the customer, and the corresponding
kernel<->userland ABI.

That said, I do understand the issues of kernel baseline ABI settings,
or at least part of them.  I know you don't want to assume the
presence of a certain system call just because you're running a kernel
that implements it.  In fact, I know you don't want to assume the
presence of a system call just because it's defined in linux/unistd.h.
As long as the userland software keeps this distinction in mind, I
don't see why taking the latest kernel<->userland ABI headers, that
describe the newest system calls and any corresponding data
structures, could hurt anything.  In fact, if you don't have the
corresponding system call numbers and data structures, you can't
possibly take advantage of the new syscalls even if they happen to be
available, unless you duplicate the syscall numbers and data structure
definitions in your own code, which, from a software engineering
standpoint, is bad.

Of course, badly written software can assume the syscalls are present
just because their numbers are given, and then people who rely on such
bad software lose, but such is the nature of bad software.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
