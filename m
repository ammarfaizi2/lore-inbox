Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130415AbRCBL0u>; Fri, 2 Mar 2001 06:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130416AbRCBL0b>; Fri, 2 Mar 2001 06:26:31 -0500
Received: from mailhost.mipsys.com ([62.161.177.33]:22992 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S130415AbRCBL0W>; Fri, 2 Mar 2001 06:26:22 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: The IO problem on multiple PCI busses
Date: Fri, 2 Mar 2001 12:25:15 +0100
Message-Id: <19350125045659.29820@mailhost.mipsys.com>
In-Reply-To: <15006.45225.631466.969004@pizda.ninka.net>
In-Reply-To: <15006.45225.631466.969004@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I do not want an interface where the user still has to do
>grotty stuff like mmap() on /dev/{mem,kmem}, this was the
>core of the problem I had with the syscall idea, don't bring
>it back.
>
>Make mmap()'s on a PCI-->ISA bridge do something special, for
>example.
>
>The user doesn't need to know anything about physical addressing of
>the machine, it all can and should be abstracted away.  This is why I
>really detest the XFree86 PCI bus probing layer, it should not need to
>poke around at so much of the config space information of devices :-(
>
>It is the reason why, at least still today in Xfree86 CVS, it simply
>cannot cope with multiple PCI controllers in a machine because it
>assumes a flat MEM/IO space.  They know about the problem and are
>working on fixes, but my point is that making this overly knowledgable
>PCI prober in the first place is what created these problems.

Ok, I see your point and I agree.

There is still the need, in the ioctl we use the "select" what need to be
mapped by the next mmap, to ask for the "legacy IO range of the bus where
the card reside" (if it exist of course). That would be the 0-64k (or less,
actually a couple of pages would probably be enough) that generates IO cycles
in the "low" addresses used for VGA registers on the card.

Ben.

