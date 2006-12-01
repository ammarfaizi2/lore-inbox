Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162145AbWLAXD0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162145AbWLAXD0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162160AbWLAXD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:03:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50124 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1162145AbWLAXDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:03:25 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Peter Stuge <stuge-linuxbios@cdy.org>
Cc: Greg KH <gregkh@suse.de>, Andi Kleen <ak@suse.de>,
       Stefan Reinauer <stepan@coresystems.de>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org, "Lu, Yinghai" <yinghai.lu@amd.com>
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<20061201191916.GB3539@suse.de> <20061201204249.28842.qmail@cdy.org>
	<m164cvgvwz.fsf@ebiederm.dsl.xmission.com>
	<20061201214631.6991.qmail@cdy.org>
Date: Fri, 01 Dec 2006 16:02:03 -0700
In-Reply-To: <20061201214631.6991.qmail@cdy.org> (Peter Stuge's message of
	"Fri, 1 Dec 2006 22:46:31 +0100")
Message-ID: <m1wt5bfces.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Stuge <stuge-linuxbios@cdy.org> writes:

> On Fri, Dec 01, 2006 at 02:15:24PM -0700, Eric W. Biederman wrote:
>> Right.  For LinuxBIOS not a problem for earlyprintk in the kernel
>> somethings might need to be refactored.  The challenge in the
>> kernel is we don't know at build to how to do a pci_read_config...
>> 
>> The other hard part early in the kernel is the fact that the
>> bar is memory mapped I/O.  Which means it will need to get mapped
>> into the kernels page tables.
>
> I see.
>
>
>> >> And I have some code that barely works for this already, perhaps
>> >> Eric and I should work together on this :)
>> >
>> > I would be interested in having a look at any code for it too.
>> 
>> Sure, I will send it out shortly.  I currently have a working
>> user space libusb thing (easy, but useful for my debug)
>
> Hm - for driving which end?

Either.  The specific device we are talking about doesn't care.

>> and a rude read/write to the bar from user space program that
>
> How does that work? /dev/{port,mem}?

mmap /dev/mem.

>> allowed me to debug the worst of the state machine from user
>> space.  I don't think I have the state setup logic correct yet
>> but that is minor in comparison.
>> 
>> I really wish the EHCI spec had made that stupid interface 16 bytes
>> instead of 8 or had a way to chain multiple access together.  The
>> we could have used a normal usb cable.  As it is most descriptors
>> are 1 byte too big to read.
>
> Which descriptors are you reading?

Minor.  I was just wishing for less magic in this process, which
would make these kinds of devices much more available.

> The debug port isn't really supposed to be used with anything but a
> debug device - which can't be enumerated normally anyway.

It depends.  If you have a debug cable with magic ends and a hardcoded
address of 127 the normal enumeration doesn't work.  I don't think
anyone actually makes one of those.  Debug devices are also allowed to
be normal devices that just support the debug descriptor.  Which
is what I'm working with.

Eric

