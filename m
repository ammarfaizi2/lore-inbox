Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312882AbSDFXeS>; Sat, 6 Apr 2002 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312885AbSDFXeR>; Sat, 6 Apr 2002 18:34:17 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38969 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S312882AbSDFXeR>; Sat, 6 Apr 2002 18:34:17 -0500
To: "Martin J. Bligh" <fletch@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
In-Reply-To: <1650399759.1018005181@[10.10.2.3]>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Apr 2002 16:27:40 -0700
Message-ID: <m1d6xco1ar.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <fletch@aracnet.com> writes:

> My real motivation for this isn't actually faster reboots,
> it's rebooting at all - I have some strange hardware that
> won't do init 6 in traditional ways ... but it might mean
> a faster reboot for others.
> 
> What's to stop me rebooting by having machine_restart load
> the first sector of the first disk (as the BIOS does), where
> the LILO code should be, and just jumping to it?

Be very careful with loading a boot sector.  The problem is
that lilo will ask the BIOS to drive the disk, and the disk
is almost certainly in a different state than when the BIOS left it,
and the BIOS hasn't been given a reset state command.  Without letting
the BIOS know you did something strange you are going out and looking
for trouble.

But if you can load a boot sector you can just about as easily load
the whole kernel, which on startup will only ask the BIOS hardware
information and not to drive the hardware (which should be safe).


> 1. Are there tables that are created by the BIOS that we 
> destroy during Linux runtime? mps tables spring to mind - 
> I can't see where we preserve them ...

Generally MPS tables are in regions of memory that we preserve anyway.

> 2. Things that are reset by reboot that we don't reset during
> normal kernel boot?

A sane BIOS will toggle the board level reset line on reboot.
The all don't but that makes it look like a fresh boot, with
a negligible speed penalty.

> As a side effect, this means we could potentially take 
> crashdumps on the way up, rather than the way down, so
> the kernel is more likely to be in a working state (we'd
> have to load a minimal kernel / crashdumper to take the
> dump first ... this is similar to what we did with PTX).

I guess if you were careful you could.  The fact that you can't rely
on the BIOS to drive the hardware is significant though.

Eric
