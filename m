Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbSKVRKg>; Fri, 22 Nov 2002 12:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265096AbSKVRKg>; Fri, 22 Nov 2002 12:10:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10843 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S265092AbSKVRKf>; Fri, 22 Nov 2002 12:10:35 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] export e820 table on x86
References: <Pine.LNX.4.44.0211212355060.7728-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 Nov 2002 10:17:08 -0700
In-Reply-To: <Pine.LNX.4.44.0211212355060.7728-100000@home.transmeta.com>
Message-ID: <m17kf5zfqj.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Thu, 21 Nov 2002, Dave Hansen wrote:
> >
> >   BIOS-e820: 0000000000000000 - 000000000009dc00 (usable)
> >   BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
> >   BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
> >   BIOS-e820: 0000000000100000 - 000000003fff9380 (usable)
> >   BIOS-e820: 000000003fff9380 - 0000000040000000 (ACPI data)
> >   BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
> >   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> >   BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
> > 
> > I added a " e820" onto the end of each of the cases in 
> > register_memory().  Where does the "00000000000e0000 - 
> > 0000000000100000 (reserved)" entry go?

Dave please don't keep the "e820" appending in the final patch.
 
> The kernel removes all region claims in the 0xa0000 - 0x100000 area, since 
> there are broken bioses that claim there is good memory there even if 
> there isn't.

And I have at least one system that actually has useable memory there.
But it is running LinuxBIOS which makes that an entirely different
problem is this regard.  
 
> >  I wonder if it is vital to the  next boot...
> 
> Nope, the next boot would also just remove it..

To be clear all that is really critical is getting the entries marked
System RAM/(useable). The kernel really does not use the rest.  And
while it may be nice to do better, it is not necessary.

As a first pass, all that is needed is we come close enough to the
true amount of ram that peoples machines don't become unuseable,
and that repeated invocations don't make the situation worse.

The kernel is an abstraction layer, and the BIOS is an abstraction
layer.  I don't expect to exactly, or trivially replicate what the
BIOS reports with the kernels abstraction layer.  Instead I intend to
do well enough, so the loaded kernel is useable.  Eventually it may be
worth letting the kernel know this information came from another
kernel and not the BIOS.  But we don't need that currently.

Eric
