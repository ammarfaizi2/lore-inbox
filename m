Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311242AbSDDTjz>; Thu, 4 Apr 2002 14:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310917AbSDDTjp>; Thu, 4 Apr 2002 14:39:45 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22070 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310637AbSDDTj2>; Thu, 4 Apr 2002 14:39:28 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>
	<a8flgc$ms2$1@cesium.transmeta.com>
	<m1lmc3qtaz.fsf@frodo.biederman.org> <3CAC9BD4.5050500@zytor.com>
	<m1hemrqo9b.fsf@frodo.biederman.org> <3CACA74A.1000004@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Apr 2002 12:32:58 -0700
Message-ID: <m1d6xfqmxh.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Agreed.  Note that so far putting the real mode code *above* 0x90000 is
> completely untested.  It *should* work with boot protocol 2.02 support; it
> almost certainly *does not* work with earlier boot protocols (due to the "move
> it back to 0x90000" braindamage.)

:)

When I got to thinking about this the biggest savings in memory usage I can
implement is having misc.c relocate it's compressed data before
decompression, instead of having it relocate the decompressed data
afterwards.  Ugh more heavy lifting to do.

Running the real mode code above 0x90000 is likely to happen in one of my
test cases.  
- Load the kernel under a normal BIOS.  
- Enter through the 32bit entry point
- Decompress the kernel
- Realize we need to do 16bit BIOS calls
- Renter through the 16bit entry point.

Sounds like fun.

I suspect the reason I didn't consider moving the real mode address
lower is that (a) I haven't run into the problems with 0x900000 and
(b) under etherboot I can easily load the real mode code at 0x1000,
which makes it look absolutely absurd.  And won't work because of the
current misc.c code.

Eric
