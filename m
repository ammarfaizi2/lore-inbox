Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287668AbRLaWHQ>; Mon, 31 Dec 2001 17:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287666AbRLaWHG>; Mon, 31 Dec 2001 17:07:06 -0500
Received: from oss.sgi.com ([216.32.174.27]:24556 "EHLO oss.sgi.com")
	by vger.kernel.org with ESMTP id <S287661AbRLaWGw>;
	Mon, 31 Dec 2001 17:06:52 -0500
Date: Mon, 31 Dec 2001 19:42:11 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] global errno considered harmful
Message-ID: <20011231194211.A27020@dea.linux-mips.net>
In-Reply-To: <20011230110623.A17083@gnu.org> <200112301956.OAA02630@ccure.karaya.com> <20011230190020.A14157@dea.linux-mips.net> <3C2F90E1.DADE7F54@didntduck.org> <20011230235939.A16384@dea.linux-mips.net> <jen0zz8hfa.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <jen0zz8hfa.fsf@sykes.suse.de>; from schwab@suse.de on Mon, Dec 31, 2001 at 05:48:09PM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 31, 2001 at 05:48:09PM +0100, Andreas Schwab wrote:

> |> A sufficient number take the unavailability of new syscall in everybody's
> |> glibc as a sufficient excuse for broken code.  util-linux as a major
> |> offender comes to mind or also e2fsprogs.
> 
> Userspace should be using syscall(2/3) for new syscalls.

Which just replaces one problem with another, slightly smaller one.
So something like syscall(SYS_pwrite, fd, buf, count, pos) will not work
on all architectures because pos is a 64-bit argument which as to be
passed in an aligned register pair on some machines, so an additional
argument has to be inserted.  So the glorious attempt to use syscall()
will now write data to fantasy positions in a file.  Great.  And just
an example demonstrating that the syscall interface is seriously dangerous
and non-portable.  I don't think there is anyway except people limiting
themselfes APIs provided by libc or similar but not using syscalls directly.

  Ralf
