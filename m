Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbSJIPNm>; Wed, 9 Oct 2002 11:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261804AbSJIPNm>; Wed, 9 Oct 2002 11:13:42 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:44292 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261768AbSJIPNl>; Wed, 9 Oct 2002 11:13:41 -0400
Date: Wed, 9 Oct 2002 11:19:04 -0400
From: Ben Collins <bcollins@debian.org>
To: Kent Borg <kentborg@borg.org>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: Loading init and ld.so.1 for Coldfire V4e
Message-ID: <20021009151904.GG26771@phunnypharm.org>
References: <20021008155415.D9391@borg.org> <20021008214044.GA22488@codepoet.org> <20021009111407.B17419@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009111407.B17419@borg.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 11:14:07AM -0400, Kent Borg wrote:
> In response to my question about how ld.so.1 is supposed to get an elf
> file up and running Ben Collins and Erik Andersen suggested I write a
> simple statically linked program.  Thanks for your help.  (My boss had
> suggested the same thing earlier but I didn't listen to him, the
> kernel list I listened to.)
> 
> Alas, it doesn't simplify matters.  I wrote a tivial program (all it
> does is a link instruction to make an empty stack frame, two moves, an
> unlink to remove the empty stack frame, and a return--only 5
> instructions long) but it is still an elf file.  And, following
> through the code, the kernel still wants to load ld.so.1, it seems to
> interpret the elf (Linux can run different kinds of executables,
> remember).  And in the process something gets messed up.
> 
> So I am back to trying to figure out what is going wrong with loading
> init and ld.so.1.  I am suspicious that do_mmap_pgoff() calls are not
> all happening right and will be comparing them with what mappings.
> But I wish I knew more about what ld.so.1 does...

If you compiled it static (e.g. pass -static to gcc), then the
dynamic-linker shouldn't be referenced in the executable. The kernel
doesn't assume that elf requires ld.so.1, that's something that is
placed into the executable itself as the INTERP. If you have an INTERP
section in your test executable, you didn't link it properly. There
should be no references to NEEDED and INTERP when you do:

# coldfirev4e-elf-objdump -x hello | less

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
