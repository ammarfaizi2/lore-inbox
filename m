Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129884AbRCAUaG>; Thu, 1 Mar 2001 15:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129883AbRCAU3q>; Thu, 1 Mar 2001 15:29:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10120 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129876AbRCAU3n>;
	Thu, 1 Mar 2001 15:29:43 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15006.45225.631466.969004@pizda.ninka.net>
Date: Thu, 1 Mar 2001 12:27:21 -0800 (PST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <19350124134100.15285@smtp.wanadoo.fr>
In-Reply-To: <15006.42475.79484.578530@pizda.ninka.net>
	<19350124134100.15285@smtp.wanadoo.fr>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Benjamin Herrenschmidt writes:
 > Also, an ioctl to retreive the iobase would be useful too

No, the whole point of my suggested mmap() interface is to
_ENTIRELY_ eliminate any reason for the user to even see
what the physical addressing of the machine looks like.

If you start pushing iobases to the user, you break this.

I do not want an interface where the user still has to do
grotty stuff like mmap() on /dev/{mem,kmem}, this was the
core of the problem I had with the syscall idea, don't bring
it back.

Make mmap()'s on a PCI-->ISA bridge do something special, for
example.

The user doesn't need to know anything about physical addressing of
the machine, it all can and should be abstracted away.  This is why I
really detest the XFree86 PCI bus probing layer, it should not need to
poke around at so much of the config space information of devices :-(

It is the reason why, at least still today in Xfree86 CVS, it simply
cannot cope with multiple PCI controllers in a machine because it
assumes a flat MEM/IO space.  They know about the problem and are
working on fixes, but my point is that making this overly knowledgable
PCI prober in the first place is what created these problems.

Later,
David S. Miller
davem@redhat.com
