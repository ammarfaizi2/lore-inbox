Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130439AbRCCKgR>; Sat, 3 Mar 2001 05:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130441AbRCCKgI>; Sat, 3 Mar 2001 05:36:08 -0500
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:1777 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S130439AbRCCKf5>; Sat, 3 Mar 2001 05:35:57 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linuxppc-dev@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>
Subject: Re: The IO problem on multiple PCI busses
Date: Sat, 3 Mar 2001 03:25:06 +0100
Message-Id: <19350125195650.22439@mailhost.mipsys.com>
In-Reply-To: <15008.17278.154154.210086@pizda.ninka.net>
In-Reply-To: <15008.17278.154154.210086@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.6 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>No, don't do this, it is evil.  Use mappings, specify the device
>related info somehow when creating the mapping (in the userspace
>variant you do this by openning a specific device to mmap, in the
>kernel variant you can encode the bus/dev/etc. info in the device's
>resource and decode this at ioremap() time, see?).

Well, except that drivers doing IOs don't ioremap...

Maybe we could define an ioremap-like function for IOs, but the more
we discuss this, the more I feel that for in-kernel, a simple function
that returns a per-bus io base (and another one for ISA mem) is plenty
enough for the few legacy things we have to deal with (mostly VGA).

For PCI drivers doing IOs, we just need to have the IO resource
structures to be properly fixed up (include the correct iobase already).

That iobase can either be a mix of a real io address and a "cooking" in
the high bits like parisc, or it can be an address ioremap'd in the
correct bus mapping when it's possible, or whatever...

Ben.
