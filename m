Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbQKSNz7>; Sun, 19 Nov 2000 08:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132406AbQKSNzt>; Sun, 19 Nov 2000 08:55:49 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:31754 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129904AbQKSNzf>;
	Sun, 19 Nov 2000 08:55:35 -0500
Date: Sun, 19 Nov 2000 14:25:30 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
Message-ID: <20001119142530.B31695@almesberger.net>
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001111171158.B17692@progenylinux.com> <m1bsvmcb4z.fsf@frodo.biederman.org> <20001114154953.E8753@almesberger.net> <m1vgtn7rfw.fsf@frodo.biederman.org> <20001119032439.H23033@almesberger.net> <m1wve04ed5.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1wve04ed5.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sun, Nov 19, 2000 at 12:20:38AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> The code wasn't trivially reusable, and the structures had a lot
> of overhead.

There's some overhead, but I think it's not too bad. I'll give it a
try ...

> The rebooting is done the rest is not yet.

Ah, and I already wondered where in all the APIC code you've hidden
the magic to avoid the config data clobbering issues ;-)

> I agree writing the code to understand the table may be a significant
> issue.  On the other hand I still think it is worth a look, being
> able to unify option parsing for multiple platforms is not a small
> gain, nor is getting out from short sighted vendor half standards.

Well, you certainly have a point where stupid vendors and BIOS nonsense
are concerned. However, if we ignore LinuxBIOS for a moment, each
platform already has a set of configuration parameter passing conventions
imposed by the firmware. So we need to be able to handle this anyway, and
most of the information is highly platform-specific.

LinuxBIOS is a special case, because you have your own firmware. But
what you're suggesting is basically yet another parameter format, which
needs to incorporate and possibly unify much of the information
contained in all those platform-specific formats. I'm not sure it's worth
the effort.

And, besides, I think it complicates the kernel, because you either
have to add a parallel set of functions extracting and processing data
from the "native" or the UBE environment, or you have to add a converter
between "native" and UBE for each platform. Or do you have a better
plan ?

When I started with bootimg, I also thought that we'd need some
parameter passing mechanism, a bit similar to UBE (although I would
have tried to be more text-based). Then I realized that there are
actually only a few tables, and we can just keep them in memory. And
some of them need to be modified before we can re-use them. (Trivial
example: the boot command line. Video modes are a similar, although
much more complicated issue.)

> Besides which most tables seem to contain a lot of information that
> is probeable.  Which just makes them a waste of BIOS space, and
> sources of bugs.

Agreed with BIOS bugs ;-) Where probing is possible, is it reliable ?
It'd take some baroque BIOS parameter table over yet another mandatory
boot command line parameter any time ...

> Hmm. I wonder how hard it would be to add -fPIC to the compilation
> line for that file.  But I'm not certain that would do what I want
> in this instance...

Are there actually architectures where the compiler generates
position-dependent code even if you're careful ? (I.e. all functions
inlined, only auto variables.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
