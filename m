Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317579AbSGYHnw>; Thu, 25 Jul 2002 03:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSGYHnw>; Thu, 25 Jul 2002 03:43:52 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:11259 "EHLO
	mta02ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S317579AbSGYHnv>; Thu, 25 Jul 2002 03:43:51 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Russell King <rmk@arm.linux.org.uk>, "D. A. M. Revok" <marvin@synapse.net>
Subject: Re: Compile Bogons in 2.4.19-rc3 with Caldera OpenLinux 3.1's patched 2.95.2
Date: Thu, 25 Jul 2002 14:32:52 +1000
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org
References: <20020724082557Z318273-685+17059@vger.kernel.org> <20020724090042Z315293-686+2972@vger.kernel.org> <20020724101620.A25115@flint.arm.linux.org.uk>
In-Reply-To: <20020724101620.A25115@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207251432.52687.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 19:16, Russell King wrote:
> On Wed, Jul 24, 2002 at 05:03:52AM -0400, D. A. M. Revok wrote:
> > Oh, fucking great, /usr/include/asm /isn't/ a symlink to
> > /usr/src/linux/include/asm, it's its own directory.
>
> That's 100% correct.  /usr/include/asm and /usr/include/linux are supposed
> to be the kernel headers glibc was compiled with, not the kernel headers
> for the kernel you're trying to build.
I don't think that this is the whole story.

Some applications talk to the kernel (eg via ioctl()). This is related to the 
kernel version that is running (not anything to do with the libs).

In reality, we need three sets of headers:
1. Things that are kernel independent, and depend on the glibc functionality
This is probably /usr/include
2. Things that are related to the kernel that the libs are compiled against
This is probably /usr/include/sys
3. Things that are related to the kernel that is running.
This is probably /usr/include/linux

The hard part is that the applications need to be matched to the kernel
binary API, which is essentially an impossible problem unless you have
a source tree that you recompile whenever you change the kernel 
API (and an API versioning system that tells you which version you 
need for each application).

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
