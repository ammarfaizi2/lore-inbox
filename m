Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSG3Heg>; Tue, 30 Jul 2002 03:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSG3Heg>; Tue, 30 Jul 2002 03:34:36 -0400
Received: from ns.suse.de ([213.95.15.193]:19460 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315214AbSG3Hef>;
	Tue, 30 Jul 2002 03:34:35 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Paul Larson <plars@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vfs_read/vfs_write small bug fix (2.5.29)
References: <Pine.LNX.4.33.0207291510340.1492-100000@penguin.transmeta.com>
X-Yow: It's the land of DONNY AND MARIE as promised in TV GUIDE!
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 30 Jul 2002 09:37:50 +0200
In-Reply-To: <Pine.LNX.4.33.0207291510340.1492-100000@penguin.transmeta.com> (Linus
 Torvalds's message of "Mon, 29 Jul 2002 15:17:32 -0700 (PDT)")
Message-ID: <jefzy1wtrl.fsf@sykes.suse.de>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

|> On 29 Jul 2002, Paul Larson wrote:
|> > > 
|> > > (Or maybe glibc doesn't know that the kernel pread/pwrite system calls 
|> > > were always 64-bit clean, and it just happened to work).
|> ?
|> > No, with just this patch it still fails on pread02 and pwrite02.
|> 
|> Ok, that just means that it's a library issue now - having looked at
|> historical kernel behaviour (and a lot of 64/bit architectures emulating
|> their old 32/bit system calls), the kernel system call interface is
|> clearly a 64-bit value, ie the kernel only export pread64/pwrite64, not a
|> "traditional" pread/pwrite at all.
|> 
|> So the question is what the library should do with a 32-bit negative 
|> "offset_t" passed in to the user-level "pread()" implementation. 
|> 
|> Looking at the disassembly of glibc pread, the implementation seems to be 
|> to just clear %edx on x86 (which are the high bits of the 64-bit offset 
|> value passed into sys_pread64()). 
|> 
|> And equally clearly your test wants to get EINVAL.
|> 
|> Your test would pass if glibc just sign-extended the 32-bit value to 64 
|> bits, instead of zero-extending it.

Yes, this was a bug in glibc, it has been fixed already in CVS.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
