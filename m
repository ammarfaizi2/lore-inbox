Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266097AbRGDRTI>; Wed, 4 Jul 2001 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266093AbRGDRS7>; Wed, 4 Jul 2001 13:18:59 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:262 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266096AbRGDRSr>; Wed, 4 Jul 2001 13:18:47 -0400
Date: Wed, 4 Jul 2001 10:05:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dave J Woolley <david.woolley@bts.co.uk>, <andrew.grover@intel.com>,
        <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
In-Reply-To: <E15HkR1-0000lb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Jul 2001, Alan Cox wrote:
>
> > I argued this at the very beginning, but there was a very strong
> > view that you needed to run most of the code before you had a user
> > space to run it in.  I've not followed things closely enough to
>
> That bit is clearly untrue.

It's untrue only in the sense of "it is technically possible to do it",
but it _is_ true that right now it's not very convenient to set up an easy
initrd system.

We migth want to just make initrd a built-in thing in the kernel,
something that you simply cannot avoid. A lot of these things (ie dhcp for
NFS root etc) are right now done in kernel space, simply because we don't
want to depend on initrd, and people want to use old loaders.

I don't like the current initrd very much myself, I have to admit. I'm not
going to accept a "you have to have a ramdisk" approach - I think the
ramdisks are really broken.

But I've seen a "populate ramfs from a tar-file built into 'bzImage'"
patch somewhere, and that would be a whole lot more palatable to me.

If anybody were to send me a patch that just unconditionally does this, I
would probably not be adverse to putting it into 2.5.x. We have all the
infrastructure to make all this a lot cleaner than it used to be (ie the
"pivot_root()" stuff etc means that we can _truly_ do things from user
mode, with no magic kernel flags).

But if we do this, then we should _truly_ get rid of all the root device
etc setup crap (and the "search for init" etc stuff - it _is_ going to be
there, and THAT process is the one that should then search for the real
init once it has booted).

That, together with reasonable interfaces to let ACPI set irq data for the
kernel etc, might make moving ACPI back into user space possible in
_practice_ and not just in theory.

		Linus

