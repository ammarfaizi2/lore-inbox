Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265987AbTAYBuB>; Fri, 24 Jan 2003 20:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTAYBuB>; Fri, 24 Jan 2003 20:50:01 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265987AbTAYBt7>;
	Fri, 24 Jan 2003 20:49:59 -0500
Date: Fri, 24 Jan 2003 17:53:40 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <rpjday@mindspring.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: test suite?
In-Reply-To: <Pine.LNX.4.33L2.0301240850070.9816-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0301241741470.9816-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jan 2003, Randy.Dunlap wrote:

| | From: Robert P. J. Day <rpjday@mindspring.com>
| |
| |   i've noticed references to "test suites" for kernels, but
| | is there any one-step convenient way to select every possible
| | option for test-compiling a new kernel, just to see if it builds?
| | perhaps an "everything" option?
| |
| |   and, related to that, should such a kernel theoretically
| | work?  as in, are there any options that would be mutually
| | exclusive that would cause such a build to fail?

I tried this...see below.
Short answer is that the resulting kernel is considered too large,
but I don't know by what.
Anyone, where is this kernel size limit coming from?

| | still thinking about reorganizing the overall option structure,
|
| Hi,
|
| I notice that you've already had a reply on this (use "make help",
| "make allmodconfig" or "make allyesconfig" etc.).
|
| OSDL's PLM does this (make allmodconfig) for each new (2.5) kernel
| release and the results are posted at
|   http://www.osdl.org/archive/cherry/stability/
| and also in the PLM web page interface.
| The script that is used for this is at that same URL above.
| PLM is at http://www.osdl.org/cgi-bin/plm/ .
|
| Has anyone tried to boot an 'allyesconfig' kernel?
| I'll give that a shot now.

On a dual-proc P4 x86 machine, with 2.5.59, I did 'make allyesconfig'
and tried to build the kernel.  There were several classes of problems.

a.  many syntax errors (> 50 source files):  disabled these configs

b.  many linker errors (> 50 object files):  disabled these configs
    (mostly references to save_flags/restore_flags etc.)

c.  One particular error implies that 2 frame buffer options are
    mutually exclusive:  linking hgafb and fbmem give 6 duplicate
    symbols (all of the form 'linux_logo*').

d.  There were 4 cases of referenced symbols being discarded or being
    outside of the referencing code section.  I used Keith's
    'reference_discarded.pl' script and fixed these (or tried to).
    I will post a separate email for these.

e.  Now the only remaining error is this:
  arch/i386/boot/tools/build -b arch/i386/boot/bootsect
  arch/i386/boot/setup arch/i386/boot/vmlinux.bin CURRENT >
    arch/i386/boot/bzImage
  Root device is (3, 4)
  Boot sector 512 bytes.
  Setup is 4880 bytes.
  System is 8384 kB
  System is too big. Try using modules.
  make[1]: *** [arch/i386/boot/bzImage] Error 1
  make: *** [bzImage] Error 2

-- 
~Randy

