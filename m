Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280638AbRLWV0p>; Sun, 23 Dec 2001 16:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281059AbRLWV0e>; Sun, 23 Dec 2001 16:26:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:33880 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280638AbRLWV0Y>; Sun, 23 Dec 2001 16:26:24 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D81C@orsmsx111.jf.intel.com>
	<m1r8pmqotz.fsf@frodo.biederman.org>
	<a04989$7n0$1@cesium.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Dec 2001 14:24:36 -0700
In-Reply-To: <a04989$7n0$1@cesium.transmeta.com>
Message-ID: <m1heqhr5nv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Very well said!!  I really think that an initramfs protocol which
> allows (but does not require!!) synthesis in the boot loader is the
> way to go.

Agreed.  Just one more thought before I take off on vacation.  

The concept of a generic boot protocol is something I like.  And it
seems the ability to include at least one and in general multiple
files with a kernel is highly desireable. 

In concepts that are well understood we have several potential
candidates.  We have the concept of a single file.  We have the
concept of multiple files.  And we have the concept of object files.

A single file works but it really doesn't offer much flexibility in
those cases where you really need it.  Modules don't need any support
by the loaded kernel at all because they are linked in transparently.
The downside with modules is that because the bootloader must include
a linker this requires a fair amount of work in the bootloader.  It
needs a very particular kernel setup.  Plus it has issues with binary
only modules and a GPL'd kernel.  A filesystem in a stream format
(tar/cpio/pax...) gets the job done.  You can use a relatively stupid
bootloader, so verification for correctness is easier.  Plus a
bootloader can inject files into the filesystem with the expectation
that they will meat with a reasonable interpretation.  Something not
possible with modules as they are code first data second.

So in the generic sense I agree that a bootloader loaded filesystem is
the way to go.  The attributes given by the GRUB filesystem are
inadequate, you can't even describe a device node.  And except for
permissions something running in userspace at kernel init time is
going to exercise the system to it's limit.  So we really need a
filesystem format that can handle extended attributes and all kinds of
other weird and strange things.  Which is basically a requirement for
simple extensibility.

So we have the choice now of being picky in the format we select or
long term needing to support multiple stream filesystems.  Given that
we would like bootloaders to have the ability to inject individual
files being picky now is probably a good idea.  Since it would be
silly to support multiple filesystems in the bootloader.  Everyone
except GRUB seems reluctant to do that sort of thing.

Eric
