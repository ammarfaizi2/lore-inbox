Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRCATOc>; Thu, 1 Mar 2001 14:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRCATMX>; Thu, 1 Mar 2001 14:12:23 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30087 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129816AbRCATMP>;
	Thu, 1 Mar 2001 14:12:15 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15006.40524.929644.25622@pizda.ninka.net>
Date: Thu, 1 Mar 2001 11:09:00 -0800 (PST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com>
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > I'm, of course open to any comments about this (in fact, I'd really like
 > some feedback). One thing is that we also need to find a way to pass
 > those infos to userland. Currently, we implement an arch-specific syscall
 > that allow to retreive the IO physical base of a given PCI bus. That may
 > be enough, but we may also want something that match more closely what we
 > do in the kernel.

Same problem on sparc64.  Using a special PCI syscall is fine, _if_ we
all end up using the same one.  However, I would prefer another
mechanism...

I think a cleaner scheme is to allow mmap() on
/proc/bus/pci/${BUS}/${DEVICE} nodes, that is much cleaner and solves
transparently any "different word size between userland and kernel"
issues (specifically 32-bit userlands executing on 64-bit kernels).

I played around with something akin to this, and some of the necessary
Xfree86-4.0.x hackery needed, some time ago.  But I never finished
this.

Later,
David S. Miller
davem@redhat.com

