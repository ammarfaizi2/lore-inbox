Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVDEVvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVDEVvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVDEVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:48:36 -0400
Received: from smtpout.mac.com ([17.250.248.70]:52173 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262054AbVDEVrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:47:48 -0400
In-Reply-To: <Pine.LNX.4.61.0504050803590.15387@chaos.analogic.com>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no> <524d7fda64be6a3ab66a192027807f57@xs4all.nl> <1112559934.5268.9.camel@tiger> <d5b47c419f6e5aa280cebd650e7f6c8f@mac.com> <3821024b00b47598e66f504c51437f72@xs4all.nl> <42511BD8.4060608@osvik.no> <c3057294a216d19047bdca201fc97e2f@xs4all.nl> <20050404205718.GZ8859@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.61.0504041718580.5550@chaos.analogic.com> <62f8215dd556d5a50b307f5b6d4f578b@mac.com> <Pine.LNX.4.61.0504050803590.15387@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <32e408a1593b89b3ad08ea3d4b34ecc4@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Grzegorz Kulewski <kangur@polcom.net>, Adrian Bunk <bunk@stusta.de>,
       Renate Meijer <kleuske@xs4all.nl>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andreas Schwab <schwab@suse.de>, Kenneth Johansson <ken@kenjo.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Dag Arne Osvik <da@osvik.no>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Use of C99 int types
Date: Tue, 5 Apr 2005 17:47:05 -0400
To: linux-os@analogic.com
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 05, 2005, at 08:18, Richard B. Johnson wrote:
> One cannot just use 'int' or 'long', in particular when interfacing
> with an operating system. For example, look at the socket interface
> code. Parameters are put into an array of longs and a pointer to
> this array is passed to the socket interface. It's a mess when
> converting this code to 64-bit world.

Exactly

> If originally one used a structure of the correct POSIX integer
> types, and a pointer to the structure was passed, then absolutely
> nothing in the source-code would have to be changed at all when
> compiling that interface for a 64-bit machine.

But you _can't_ use the POSIX integer types.  When compiling the
kernel, if you use the types, you must define them in the kernel
headers.  On the other hand, when compiling userspace stuff, you
_can't_ have them defined in the kernel headers because libc also
defines them.  The solution is to use __{s,u}{8,16,32,64}, which
are _only_ defined by the kernel, not by libc or gcc, and can be
therefore used in the ABI.

> The continual short-cuts, with the continual "special-case"
> hacks is what makes porting difficult. That's what the POSIX
> types was supposed to help prevent.

Except the POSIX types themselves are not usable for the boundary
code for the reasons of double definition.  Google for Linus'
posts on this topic a couple months ago.

> That's why I think if there was a stdint.h file in the kernel,
> when people were performing maintenance or porting their code,
> they could start using those types.

The types _are_ available from the kernel headers, but only when
compiling with __KERNEL__, to avoid conflicts from the libc
definitions.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


