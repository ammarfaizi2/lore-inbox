Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129228AbQLOSRs>; Fri, 15 Dec 2000 13:17:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLOSRi>; Fri, 15 Dec 2000 13:17:38 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:11536 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129228AbQLOSRc>;
	Fri, 15 Dec 2000 13:17:32 -0500
Date: Fri, 15 Dec 2000 18:46:44 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: ferret@phonewave.net
Cc: Alexander Viro <viro@math.psu.edu>, LA Walsh <law@sgi.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linus's include file strategy redux
Message-ID: <20001215184644.R573@almesberger.net>
In-Reply-To: <20001215152137.K599@almesberger.net> <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.96.1001215090857.16439A-100000@tarot.mentasm.org>; from ferret@phonewave.net on Fri, Dec 15, 2000 at 09:15:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ferret@phonewave.net wrote:
> Just out of curiosity, what would happen with redirection if your source
> tree for 'the currently running kernel' version happens to be configured
> for a different 'the currently running kernel', perhaps a machine of a
> foreign arch that you are cross-compiling for?

Two choices:
 1) try to find an alternative. If there's none, fail.
 2) make the corresponding asm or asm/arch branch available (non-trivial
    and maybe not desirable)

> I do this: I use ONE machine to compile kernels for five: four i386 and
> one SUN4C. My other machines don't even HAVE /usr/src/linux, so where does
> this redirection leave them?

Depends on your distribution: if it doesn't install any kernel-specific
headers, you wouldn't be able to compile programs requiring anything
beyond what it provided by your libc. Otherwise, there could be a
default location (such as /usr/src/linux is a default location now).

The main advantage of a script would be that one could easily compile
for multiple kernels, e.g. with

export TARGET_KERNEL=2.0.4
make

Even if your system is running 2.4.13-test1.

The architecture could be obtained from the tree or the tree could be
picked based on the architecture. This is a policy decision that could
be hidden in the script.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
