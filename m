Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129861AbRCAUDO>; Thu, 1 Mar 2001 15:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCAUDG>; Thu, 1 Mar 2001 15:03:06 -0500
Received: from 216-064-003-018.inaddr.vitts.com ([216.64.3.18]:33806 "EHLO
	mail.netx4.com") by vger.kernel.org with ESMTP id <S129853AbRCAUC5>;
	Thu, 1 Mar 2001 15:02:57 -0500
Message-ID: <3A9EAA2F.7C89C88@mvista.com>
Date: Thu, 01 Mar 2001 14:59:43 -0500
From: Dan Malek <dan@mvista.com>
Organization: MontaVista Software, Inc.
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.15-2.9.d ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com>
		<15006.40524.929644.25622@pizda.ninka.net>
		<3A9EA3FA.1A86893B@mvista.com> <15006.42475.79484.578530@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

> There is only one sticking point, and that is how to convey to the
> mmap() call whether you want I/O or Memory space.

Isn't I/O space obsolete by now :-)?  It actually caused me to think
of something else....I have cards with multiple memory and I/O
spaces (rare, but I have them).  What if we did:

	/proc/bus/pci/${BUS}/${DEVICE}/mem
	/proc/bus/pci/${BUS}/${DEVICE}/io
	/proc/bus/pci/${BUS}/${DEVICE}/BARn

The 'mem' or 'io' would map the first instance of these spaces
on the device, and would probably be suitable for nearly all devices.
If you really knew what you were doing (or wanted to make a big mess),
you could use the 'BARn' to specify the area.

You could even do something like map in as much virtually contiguous
space as indicated in the mmap().  For example, if the card has 2M I/O
and 8 M memory (in this order), the first 2M of the mmap()'ed space
would the the I/O and the next 8M would be the memory.  I know, some
cards lie about the actual amount of space they have or need, but it
was just another idea that popped in.......

Thanks.

	-- Dan
