Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135589AbREEXSK>; Sat, 5 May 2001 19:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135590AbREEXSB>; Sat, 5 May 2001 19:18:01 -0400
Received: from thepigsty.demon.co.uk ([158.152.99.38]:56269 "EHLO
	mad.pigsty.org.uk") by vger.kernel.org with ESMTP
	id <S135589AbREEXR5>; Sat, 5 May 2001 19:17:57 -0400
To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: ipv6 activity causing system hang in kernel 2.4.4
From: Tim Haynes <kernel@stirfried.vegetable.org.uk>
Reply-To: kernel@stirfried.vegetable.org.uk (Tim Haynes)
Date: 06 May 2001 00:17:47 +0100
Message-ID: <871yq3mllw.fsf@straw.pigsty.org.uk>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    [I can't see evidence of this being reported before; apols if I'm
     wrong. Please also Cc: me as I only read l-k intermittently but would
     like to help out more.]

Hi,

I've been making very tentative forays into IPv6. However, in my simple
experiments thus far I appear to have located a bug:

1/ configure 2 machines with site-local IP#s - I'm using 
        ifconfig eth0 inet6 add fec0:1234:5:6::n 
2/ flood-ping from one to the other
3/ after about 15s, watch one box hang, needing magic-sysreq or hard reset

This is only with kernel 2.4.4; 2.4.2, 2.4.3 and NetBSD boxes are not
affected. It is independent of platform; I've reproduced it at will on a
lowly p75, an athlon, a p3-800 and on a powerbook/PPC.

All kernels are compiled to have ipv6 modular, netfilter modular...
everything with which I'm playing, modular.

Compiler versions:
| zsh, 12:06AM % gcc -v
| Reading specs from /usr/lib/gcc-lib/powerpc-linux/2.95.4/specs
| gcc version 2.95.4 20010319 (Debian prerelease)
| zsh, 12:06AM % gcc -v
| Reading specs from /usr/lib/gcc-lib/i386-linux/2.95.4/specs
| gcc version 2.95.4 20010319 (Debian prerelease)
(I'm tracking Debian/Unstable here.)

I have tcpdump logs (<http://spodzone.org.uk/~tim/ipv6/> - they're 570K
apiece); the `victim' machine receives nothing but ping-requests and sends
nothing but ping-replies until the file is truncated; the surviving box
sends nothing but requests and receives nothing but replies until it
becomes requests-only. (IOW there is no evidence of ARP, fragmentation
traffic, only the pings.)

The Changelog lists an `IPv6 packet re-assembly fix' in -pre2; my
suspicions lie in this area or with my compiler.

If there's anything else I can provide by way of diagnostics, please let me
know.

Cheers,

~Tim
-- 
<http://spodzone.org.uk/>
