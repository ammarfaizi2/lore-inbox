Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129032AbRBNGJr>; Wed, 14 Feb 2001 01:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130203AbRBNGJi>; Wed, 14 Feb 2001 01:09:38 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:57100 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129032AbRBNGJ0>;
	Wed, 14 Feb 2001 01:09:26 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102140609.f1E69Bc346946@saturn.cs.uml.edu>
Subject: Re: Video drivers and the kernel
To: louisg00@bellsouth.net (Louis Garcia)
Date: Wed, 14 Feb 2001 01:09:10 -0500 (EST)
Cc: linux-kernel@vger.kernel.org, xpert@XFree86.Org
In-Reply-To: <3A89F1A5.7050603@bellsouth.net> from "Louis Garcia" at Feb 13, 2001 09:47:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was wondering why video drivers are not part of the kernel like every 
> other piece of hardware. I would think if video drivers were part of the 
> kernel and had a nice API for X or any other windowing system, would not 
> only improve performance but would allow competing windowing systems 
> without having to develop drivers for each. Has anyone thought or 
> rejected this idea.

Yes.

Problem is, X is a big old wad of code. It wasn't designed to run
in a kernel environment. It isn't easy to rewrite, and getting rid
of it isn't currently reasonable for normal desktop Linux systems.

So then what, split X, with only the hardware access in the kernel?
This can actually reduce performance, by a small or great amount
depending on how it is done. Stability would improve a bit, assuming
the new drivers have Linux quality rather than XFree86 quality.
The gain is tiny, while the difficulty is large. At least we'd get
a safe and reliable way to print an oops though.

Both options could eat some memory. (but NOT anything like the VM size
of an X server, much of which is the video memory itself) Putting the
whole thing in the kernel does allow for memory pressure hooks though.

Both options cause political troubles. Currently the X server is
shared with OS/2 and other crummy systems. If the Linux kernel had
serious video drivers for PC hardware, then driver support for the
other operating systems would mostly go away. Linux would become
a better desktop OS, at the expense of various crummy systems.

Both options would tend to hurt people who like to leave X running
on a low-memory web or NFS server. For a kernel X server, swapping
must be done more-or-less explicitly.

Both options cause more work for Linus. This totally kills the idea.
See his past postings flaming the GGI/KGI developers.

If you ever write this, go ahead and throw in the rest. I mean the
window manager, xterm, and a GDK system call even. My hardware can
spare the memory, but CPU cycles are way too scarce. Clean design
can go screw itself when it eats CPU time. Don't worry about being
accepted into the main kernel, because that won't happen no matter
what you do. Have fun hacking, and whip XFree86's ass.



