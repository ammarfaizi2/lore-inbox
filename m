Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287578AbSBCSrY>; Sun, 3 Feb 2002 13:47:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287588AbSBCSrO>; Sun, 3 Feb 2002 13:47:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35386 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S287578AbSBCSrA>; Sun, 3 Feb 2002 13:47:00 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Erik A. Hendriks" <hendriks@lanl.gov>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Werner Almesberger <wa@almesberger.net>
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <m1elk7d37d.fsf@frodo.biederman.org>
	<3C586355.A396525B@zip.com.au> <m1zo2vb5rt.fsf@frodo.biederman.org>
	<3C58B078.3070803@zytor.com> <m1vgdjb0x0.fsf@frodo.biederman.org>
	<3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>
	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>
	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>
	<m1665fame3.fsf@frodo.biederman.org> <3C5C54D2.2030700@zytor.com>
	<m1k7tv8p2z.fsf@frodo.biederman.org> <3C5C98E6.2090701@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2002 11:43:08 -0700
In-Reply-To: <3C5C98E6.2090701@zytor.com>
Message-ID: <m1y9ia76f7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > It can be argued that general purpose systems have enough ram that
> > putting drivers for all mass produced devices in ram is possible, and
> > practical.  But that is a cop out.
> >
> 
> 
> Indeed.  Worse, it may not be possible for the *boot medium* to hold all those
> devices...

O.k. I have been thinking about this some more, and I have come up with a couple
alternate of solutions.

The simplest is the observation that right now 10MB is about what it
takes to hold every Linux driver out there.  So all you really need is
a 16MB system, to avoid a device probing loader.  And probably
noticeably less than that.  The only systems I see having real
problems are old systems where device enumeration is not reliable, and
require human intervention anyway.

A second is to just make certain there is some kind of fallback path
so if the image is too large have a way to load a smaller one.  When
you consider that older systems had less memory it has a reasonable
chance of working properly.

My final and favorite is to take an ELF image, define a couple of ELF
note types, and add a bunch those notes saying which pieces are
hardware dependent.  So a smart ELF loader can prune the image as it
is loaded, and a stupid one will just attempt to load everything.  And
with the setup for this not being bootloader specific it will probably
encourage device pruning loaders.

Am I being optimistic or are there any pressing cases for callbacks to
the firmware?

Eric
