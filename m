Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135637AbRD1VI1>; Sat, 28 Apr 2001 17:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135639AbRD1VIS>; Sat, 28 Apr 2001 17:08:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14982 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135637AbRD1VID>;
	Sat, 28 Apr 2001 17:08:03 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15083.12585.159124.505983@pizda.ninka.net>
Date: Sat, 28 Apr 2001 14:07:53 -0700 (PDT)
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPv4 NAT doesn't compile in 2.4.4
In-Reply-To: <20010428172554.H21792@flint.arm.linux.org.uk>
In-Reply-To: <20010428172554.H21792@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Russell King writes:
 > ip_nat_standalone.c:
 > 
 > static int init_or_cleanup(int init)
 > {
 > ...
 >  cleanup_nat:
 >         ip_nat_cleanup();
 > ...
 > }

Call ip_nat_cleanup();

 > ip_nat_core:
 > 
 > void __exit ip_nat_cleanup(void)
 > {
 >         ip_ct_selective_cleanup(&clean_nat, NULL);
 >         ip_conntrack_destroyed = NULL;
 > }

Define ip_nat_cleanup() as an __exit function.

 > *Don't* do this - its fundamentally wrong.  Code in the kernel should _not_
 > reference code that has been removed by the linker.

Why would ip_nat_cleanup() be removed by the linker?  All the "unused"
attribute should do is shut up gcc if the thing is marked static yet
not called.  The GCC manual even states "... means that the function
is meant to be possibly unused.  GNU CC will not produce a warning
for this function."  It makes no mention of any effect on the actual
code output, or that the linker will delete it.

It doesn't remove the function on any platform I could test this on.

If the linker removed it, why did it give a relocation truncation
error instead of a missing symbol error?  And more importantly, what
specifically was the reason that the linker removed the function on
ARM, what made this happen?

Please explain this in detail so we don't have to guess as I have
seen no other report of this.

Later,
David S. Miller
davem@redhat.com
