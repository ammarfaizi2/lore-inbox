Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTADWel>; Sat, 4 Jan 2003 17:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbTADWel>; Sat, 4 Jan 2003 17:34:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17727 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261640AbTADWek>; Sat, 4 Jan 2003 17:34:40 -0500
To: suparna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Andy Pfiffer <andyp@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       wa@almesberger.net, lkcd-devel@lists.sourceforge.net
Subject: Re: [PATCH][CFT] kexec (rewrite) for 2.5.52
References: <m1smwql3av.fsf@frodo.biederman.org>
	<20021231200519.A2110@in.ibm.com> <m11y3uldt9.fsf@frodo.biederman.org>
	<20030103181100.A10924@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Jan 2003 15:42:00 -0700
In-Reply-To: <20030103181100.A10924@in.ibm.com>
Message-ID: <m1k7hkk05j.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> writes:

> On Fri, Jan 03, 2003 at 03:37:06AM -0700, Eric W. Biederman wrote:
> > A dump question.  Why doesn't the lkcd stuff use the normal ELF core
> > dump format?  allowing ``gdb vmlinux core'' to work?

Digesting....  Of the pieces I have no problem if a valid
ELF core dump is written but gdb does not know what to do with it out
of the box.  The piece that disturbed me most is that the file format
seemed to be mutating from release to release.

An ELF core dump consists of:
ELF header
ELF Program header
ELF Note segment
Data Segments...

All of the weird processor specific information can be stored as
various ELF note types.

Compression of pages that are zero can be handled by treating
them as BSS pages and not putting them in the image. 

I do admit it would likely take an extra pass to generate the ELF
program header if anything non-trivial like zero removal or
compression was going on.   But at the same time that should also
quite dramatically reduce the per page overhead.  A pure dump of ram
on x86 should take only 2 or 3 segments.

Using physical addresses is no problem in an ELF core dump.  The ELF
program header has both physical and virtual addresses, and you just
fill in the physical addresses.

I keep asking and thinking about ELF images, because they are 
simple, clean, extensible, and well documented.  With an added bonus
that using the allows a large degree of code reuse with existing
tools.


[snip a good description of the usefulness of the existing core dump format]

> Am cc'ing lkcd-devel on this one - there are experts who can
> add to this or answer this question better than I can. 

Thanks,

Eric
