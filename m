Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267933AbTAHUnl>; Wed, 8 Jan 2003 15:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267934AbTAHUnl>; Wed, 8 Jan 2003 15:43:41 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:55311 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267933AbTAHUnk>; Wed, 8 Jan 2003 15:43:40 -0500
Date: Wed, 8 Jan 2003 20:52:20 +0000
From: John Levon <levon@movementarian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [PATCH] /proc/sys/kernel/pointer_size
Message-ID: <20030108205220.GB35912@compsoc.man.ac.uk>
References: <20030108195934.GA35912@compsoc.man.ac.uk> <Pine.LNX.4.44.0301081222430.5369-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301081222430.5369-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18WNBV-000FRG-00*HDWZv4W/HcI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 12:28:23PM -0800, Linus Torvalds wrote:

> doesn't change suddenly on the machine, there's no point at all in doing
> something like this and exporting it through proc, when the information is
> perfectly available in other ways

What other ways ? Dave M reasonably argued it wasn't part of the
architecture's ABI, so did not have a place in the headers.

> or could even be a user program config file option.

Eww.

> Quite frankly, just compile oprofile for the architecture and be done with 
> it. Or add a command line option. Don't add stupid bloat to the kernel 
> because somebody is silly enough to care about a 32-bit oprofile working 
> with a 64-bit kernel. 

It's not silly, it's a necessity on architectures like pa-risc, sparc64,
ppc64, etc. where pointers are 32 bit in userspace. OProfile simply
cannot work at all on such systems without being able to figure out the
units of the oprofile kernel buffer.

We could force the oprofile kernel buffer to always be u64s but that
just eats unnecessary space and time on x86.

So, what solution do you suggest instead ?

regards
john

-- 
"CUT IT OUT FACEHEAD"
	- jeffk
