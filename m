Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288245AbSAMWi2>; Sun, 13 Jan 2002 17:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288234AbSAMWiT>; Sun, 13 Jan 2002 17:38:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3906 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S288238AbSAMWiI>; Sun, 13 Jan 2002 17:38:08 -0500
To: Alexander Viro <viro@math.psu.edu>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201131656190.27390-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Jan 2002 15:35:27 -0700
In-Reply-To: <Pine.GSO.4.21.0201131656190.27390-100000@weyl.math.psu.edu>
Message-ID: <m17kqlria8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On 13 Jan 2002, Eric W. Biederman wrote:
>  
> > Which we are reusing for a different purpose.  And because of that we
> > become trustees of our version of the format.  To make it clear that
> > someone else defines how this format works a reference to the
> > appropriate specification is called for.  
> 
> We are using it for precisely the same purpose - to put a bunch of
> files on a filesystem.

Anytime you are specifying semantics beyond what was in the original
specification it isn't precisely the same case.  Close enough not to
matter yes but not precisely the same.  The original cpio format does
not specify compression or concatenation of images.  It is not
mandated that the cpio format handle the needs of everyones root
filesystem.

Additionally we now have the potential of generating cpio files from
the bootloaders.  And bootloaders should be the kinds of programs that
don't need constant maintenance or upgrading, (that is very
destabilizing).  So totally reworking the format is not a solution
when we need to change something.  Even if is ok for cpio in general.

This changing the format in incompatible ways when there is a new
requirement does seem to be the traditional cpio method.
 
> > The cases where initramfs will be used are some of the most operating
> > specific cases I can imagine.  To handle those cases it is necessary
> > to support the full breadth of the capability of the operating system.
> 
> Huh?  It's a bloody archive - collection of files and nothing else.
> What "capability of the operating system"?

Exactly.  But the standard unix stream of bytes does not cover everyones
concept of files.  Things like:
Symbolic Links
Device Nodes,
Resource Forks,
Device links,
Persistent mount points,
ACL's,
Persistent capabilities,

Are all partial exceptions to everything is the same kind of file.
The cpio format as is doesn't handle all of these which is fine, but
we may need some of these later, so we need someplace to expand to
when if/when these kinds of things become important.

The startup process is likely to need everything the operating system
can do, to handle some special case or the other.  So if at some
future date we support odd types of special files we will probably
need to use them in the system startup code.  We already require device
nodes, and find symbolic links very helpful.

Further Linux is dynamic and always changing, so not having some elbow
room for growth is just asking for trouble.  All I noted is that
the c_magic field exists so if/when the need arises we can handle
really strange cases.  With everyone in linux being able to use an
initramfs as their root filesystem actually makes the odds of a change
that requires special root filesystem support much more likely.
Because you only have to change one filesystem.

All I am asking is two things.  If we are not assuming guardianship
for our variant of the cpio format we should reference those who do
have guardianship, in the specification.  We should be aware that the
cpio format as it now exists may not handle all future needs so
having a mechanism to extend the format when those needs arise without
breaking all existing users is important.

Eric
