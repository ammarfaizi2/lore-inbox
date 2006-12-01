Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161767AbWLAVQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161767AbWLAVQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:16:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161764AbWLAVQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:16:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60829 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161767AbWLAVQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:16:32 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Greg KH <gregkh@suse.de>, Andi Kleen <ak@suse.de>
Cc: "Lu, Yinghai" <yinghai.lu@amd.com>,
       Stefan Reinauer <stepan@coresystems.de>, linuxbios@linuxbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] #57: libusb host program for PLX NET20DC debug device
References: <5986589C150B2F49A46483AC44C7BCA4907276@ssvlexmb2.amd.com>
	<20061201191916.GB3539@suse.de> <20061201204249.28842.qmail@cdy.org>
Date: Fri, 01 Dec 2006 14:15:24 -0700
In-Reply-To: <20061201204249.28842.qmail@cdy.org> (Peter Stuge's message of
	"Fri, 1 Dec 2006 21:42:49 +0100")
Message-ID: <m164cvgvwz.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Stuge <stuge-linuxbios@cdy.org> writes:

> On Fri, Dec 01, 2006 at 11:19:16AM -0800, Greg KH wrote:
>> Well, earlyprintk will not work, as you need PCI up and running.
>
> Not all of it though. LinuxBIOS will probably do just enough PCI
> setup to talk to the EHCI controller and use the debug port _very_
> soon after power on.

Right.  For LinuxBIOS not a problem for earlyprintk in the kernel
somethings might need to be refactored.  The challenge in the kernel
is we don't know at build to how to do a pci_read_config...

The other hard part early in the kernel is the fact that the
bar is memory mapped I/O.  Which means it will need to get mapped
into the kernels page tables.

>> And I have some code that barely works for this already, perhaps
>> Eric and I should work together on this :)
>
> I would be interested in having a look at any code for it too.

Sure, I will send it out shortly.  I currently have a working
user space libusb thing (easy, but useful for my debug) and 
a rude read/write to the bar from user space program that
allowed me to debug the worst of the state machine from user
space.  I don't think I have the state setup logic correct yet
but that is minor in comparison.

I really wish the EHCI spec had made that stupid interface 16 bytes
instead of 8 or had a way to chain multiple access together.  The
we could have used a normal usb cable.  As it is most descriptors
are 1 byte to big to read.

>> Yes, that will work just fine today using the usb-serial generic
>> driver.
>
> Ugh. I did not know it was that generic. The irony is that I always
> ask other libusb users to check the kernel drivers to see if they
> really need to write a libusb app.
>
>
>> I'll knock up a "real" driver for the device later today and send
>> it to Linus, as it's trivial to do so, and will make it simpler
>> than using the module parameters.
>
> Awesome. Thanks!

Yep. It looks like it sufficient generic.  The Maximum packet size
appears to be reported correctly for writes which is the tidbit
I was worried about but otherwise it is just a pair of bulk transfer
endpoints.

Eric
