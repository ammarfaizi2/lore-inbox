Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289346AbSBEHtl>; Tue, 5 Feb 2002 02:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289347AbSBEHtb>; Tue, 5 Feb 2002 02:49:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:45372 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289346AbSBEHtS>; Tue, 5 Feb 2002 02:49:18 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Werner Almesberger <wa@almesberger.net>,
        "Erik A. Hendriks" <hendriks@lanl.gov>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS
In-Reply-To: <3C58CAE0.4040102@zytor.com> <20020131103516.I26855@lanl.gov>
	<m1elk6t7no.fsf@frodo.biederman.org> <3C59DB56.2070004@zytor.com>
	<m1r8o5a80f.fsf@frodo.biederman.org> <3C5A5F25.3090101@zytor.com>
	<m1hep19pje.fsf@frodo.biederman.org> <3C5ADDD1.6000608@zytor.com>
	<20020204134927.A5079@almesberger.net>
	<m1sn8h6ngb.fsf@frodo.biederman.org>
	<20020204220234.B5079@almesberger.net> <3C5EF846.1070501@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 05 Feb 2002 00:45:33 -0700
In-Reply-To: <3C5EF846.1070501@zytor.com>
Message-ID: <m1aduo74o2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Werner Almesberger wrote:
> 
> > 
> > Well, it keeps things simple for the kernel, and bootimg(8) needs
> > to know the target architecture anyway. But there isn't really a
> > design reason why it would have to use pages, agreed.
> > 
> 
> 
> I looked at this point at some time, and I found that it made it a lot
> easier to write code to permute memory arbitrarily, as may be required.
>   The reason is that you really want to keep an array that's O(N) in the
> size of memory to keep track of where things are, and in order to do that,
> realistically, you need to have some reasonably large granularity -- 4K
> pages are just about right.

On the kernel side I still plan to use pages, though my ideal case
would be to allocate one great big slab of non-conflicting memory, and
just copy everything to where it needs to go.

On the user space side what I am proposing actually increases the
granularity quite a bit.  For a linux kernel with a ramdisk you should
only need to pass the kernel 3 segments.  (Assuming everything is
contiguous in user space memory).  The setup code, the kernel, and the
ramdisk.

> Of course, maybe I was just using a dumb algorithm... :)

Perhaps.  So far I don't need an array that is O(N) in the size of
memory just O(N) in the size of the image I am copying.   The
permutations that are necessary to avoid conflicts in the pathological
cases are a pain.  But I've already done that...

Anyway now it's back to the trenches...

Eric
