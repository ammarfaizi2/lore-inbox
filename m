Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129845AbRCGCKD>; Tue, 6 Mar 2001 21:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129847AbRCGCJx>; Tue, 6 Mar 2001 21:09:53 -0500
Received: from h24-70-162-27.wp.shawcable.net ([24.70.162.27]:32275 "EHLO ubb")
	by vger.kernel.org with ESMTP id <S129845AbRCGCJk>;
	Tue, 6 Mar 2001 21:09:40 -0500
Message-Id: <v04003a06b6cb43b4f87c@[24.70.162.12]>
In-Reply-To: <Pine.LNX.4.30.0103061657570.19700-100000@waste.org>
In-Reply-To: <15008.17278.154154.210086@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Organisation: Judean People's Front; Department of Whips, Chains, Thumb-Screws, Six Tons of Whipping Cream, the Entire Soprano Section of the Mormon Tabernacle Choir and Guest Apperances of Eva Peron aka Eric Conspiracy Secret Laboratories
X-Disclaimer-1: This message has been edited from it's original form by members of the Eric Conspiracy.
X-Disclaimer-2: There is no Eric Conspiracy.
Date: Tue, 6 Mar 2001 20:07:33 -0600
To: Oliver Xymoron <oxymoron@waste.org>, "David S. Miller" <davem@redhat.com>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: The IO problem on multiple PCI busses
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        <linuxppc-dev@lists.linuxppc.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:01 PM -0600 3/6/2001, Oliver Xymoron wrote:
>On Fri, 2 Mar 2001, David S. Miller wrote:
>
>>  > On PPC, we don't have an "IO" space neither, all we have is a range of
>>  > memory addresses that will cause IO cycles to happen on the PCI bus.
>>
>> This is precisely what the "next MMAP is XXX space" ioctl I've
>> suggested is for.  I think I've addressed this concern in my
>> proposal already.  Look:
>>
>> 	fd = open("/proc/bus/pci/${BUS}/${DEV}", ...);
>> 	if (fd < 0)
>> 		return -errno;
>> 	err = ioctl(fd, PCI_MMAP_IO, 0);
>
>I know I'm coming in on this late, but wouldn't it be cleaner to have
>separate files for memory and io cycles, eg ${BUS}/${DEV}.(io|mem)?
>They're logically different so they might as well be embodied separately.

If I were designing this (and I'm not), I would do it as thus:

/proc/bus/pci/${BUS}/${DEV} is same as it always is
/proc/bus/pci/${BUS}/${DEV}.d/io.n for IO resources, where n is the number
of the IO resource
/proc/bus/pci/${BUS}/${DEV}.d/mem.n for Mem resouces, where n is...
/proc/bus/pci/${BUS}/${DEV}.d/ints for interrupts, which would block on
read when there are no interrupts pending, and after an interrupt is
triggered the data read would be some sort of information about the
interrupt.

And that should (in theory) be all you need for writing a basic userspace
PCI device driver. (You wouldn't really be able to set up DMA or such, but
at that point I think "put the damn driver in the kernel" would be an
appropriate utterance)


This is just off the top of my head, so no warranties expressed or implied
about the sanity of this kind of system.

Come to think of it, is /proc really the best place to put all this stuff?
It would be a pain to put it in /dev and mess with assigning majors and
minors and making sure all the special devices get created and stuff...
Makes me wish Linux had an /hw fs like on IRIX. (I suppose devfs is close,
but I don't personally like the idea of completely replacing /dev with an
automatic filesystem)

Anyways...


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


