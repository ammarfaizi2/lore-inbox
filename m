Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268867AbRHKWDQ>; Sat, 11 Aug 2001 18:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268865AbRHKWDH>; Sat, 11 Aug 2001 18:03:07 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:11917
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268862AbRHKWDA>; Sat, 11 Aug 2001 18:03:00 -0400
Date: Sat, 11 Aug 2001 15:02:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] Announce: Kernel Build for 2.5, Release 1.1 is available.
Message-ID: <20010811150255.G4657@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <1904.997542180@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1904.997542180@ocs3.ocs-net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 01:03:00AM +1000, Keith Owens wrote:

> Changes from Release 1.
[snip]
>   Document kbuild targets and C to assembler conversions.  As always,
>   Documentation/kbuild/kbuild-2.5.txt is your friend.

Okay, I've played with this a bit on PPC, and got it working to boot :)
Now here's what I see as the slight problems with it.  At least on PPC
what we do is generate the offset bits, and then have another file,
arch/ppc/kernel/ppc_asm.h include that file and have some other useful
macros for .S files.  So any of the .S files which include ppc_asm.h
would need an additional
extra_aflags(foo.o $(src_includelist /arch/$(ARCH)))
or extra_aflags_all($(src_includelist /arch/$(ARCH))
or my ugly workaround for the moment of #include <../arch/ppc/offsets.h>
which is wrong, but works.

But aside from that, it's nice that the file isn't generated every make
like it was w/ the user_command workaround :)

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
