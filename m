Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315901AbSEGQw2>; Tue, 7 May 2002 12:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315903AbSEGQw1>; Tue, 7 May 2002 12:52:27 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11532 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315901AbSEGQwZ>; Tue, 7 May 2002 12:52:25 -0400
Date: Tue, 7 May 2002 09:51:57 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Padraig Brady <padraig@antefacto.com>
cc: Anton Altaparmakov <aia21@cantab.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
In-Reply-To: <3CD800FE.4050004@antefacto.com>
Message-ID: <Pine.LNX.4.44.0205070944020.2509-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 May 2002, Padraig Brady wrote:
>
> All the info I've ever needed is /proc/ide/hdx/capacity
> which I could get from /proc/partitions with more a bit
> more effort, so I vote for removing /proc/ide.

Note that one thing that we might do is to leave the remnants of /proc/ide
but _without_ the very verbose per-chipset reporting.

At least to me it looks like it's all the chipset reporting that causes
the huge kernel bloat, and it shouldn't be impossible to reinstate a
minimal /proc/ide without those parts - while still keeping most of the
backwards compatibility.

However, since I really don't much like the idea of having special
"ide-only" /proc files, I personally think any information people actually
used should be either in truly generic files (/proc/partitions as an
example), _or_ they should be in the generic device tree (talk to Pat
Mochel about that).

So my personal reaction to removal of /proc/ide is: "good riddance, but if
it turns out that we seriously need it for backwards compatibility, we can
add back a skeleton without the bloat".

(Side note: I'm afraid that don't think backwards compatibility weighs
very heavily on an embedded setup - I'm more thinking about things like "a
regular RedHat/SuSE/Debian/whatever install won't work any more".)

As to existing binaries (your list is interesting), I don't see what they
are doing about ide-specific stuff, since I sure hope those binaries are
happy with a SCSI-only system.

> For e.g. could the same arguments could be made for lspci only
> interface to pci info rather than /proc/bus/pci? The following
> references are made to /proc/bus/pci on my system:

I personally do like ASCII /proc files, as long as they don't add
maintainability problems etc.

		Linus

