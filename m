Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289047AbSBDVEA>; Mon, 4 Feb 2002 16:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289054AbSBDVDu>; Mon, 4 Feb 2002 16:03:50 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:4625 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S289047AbSBDVDk>;
	Mon, 4 Feb 2002 16:03:40 -0500
Date: Mon, 4 Feb 2002 22:02:35 +0100
From: Werner Almesberger <wa@almesberger.net>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
Message-ID: <20020204220234.B5079@almesberger.net>
In-Reply-To: <3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov> <m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com> <m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com> <m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com> <20020204134927.A5079@almesberger.net> <m1sn8h6ngb.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sn8h6ngb.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Mon, Feb 04, 2002 at 12:45:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> I have come to agree with this sentiment.

Great !

> However I do have a small issue with the current bootimg api.
> Everything is done in page sized chunks.  Which feels like it is
> exporting too much of the current implementation.

Well, it keeps things simple for the kernel, and bootimg(8) needs
to know the target architecture anyway. But there isn't really a
design reason why it would have to use pages, agreed.

> Except for the case of Loadlin where the old firmware is destroyed,
> and you cannot requery the firmware.  You have a more robust solution
> if you let the new kernel query the firmware itself.

Yes, I was thinking of
 - BIOS does IDE bus scan, boots boot loader kernel
 - first kernel does IDE bus scan again, boots real kernel
 - real kernel does IDE bus scan again

It should be possible to avoid at least the third IDE bus scan, at
least as an optimization.

> For the most part I agree, that the bootimg type interface will avoid
> bloat.  At the same time, some of this information that we would like
> to pass is easier to get at in kernel space, oh well.

You can always look it up in /dev/mem, just like bootimg(1) did :-)
BTW, that's what I like about this approach: incremental development
is much easier this way, and you can hide all the ugly spots in the
library, if necessary.

> I will stop just a moment to say it is extremely nasty to read the ELF
> section header instead of the ELF program header for boot purposes.
> For an ELF static executable it is totally valid not to have a section
> header.

Touche ;-) I admit that I'm not much of an ELF expert. This was just
a surprisingly easy hack, so I was content with what I got.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
