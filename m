Return-Path: <linux-kernel-owner+w=401wt.eu-S1030218AbWLTRkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWLTRkO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWLTRkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:40:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:57699 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030218AbWLTRkM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:40:12 -0500
Message-ID: <45897478.6070308@redhat.com>
Date: Wed, 20 Dec 2006 12:35:52 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com> <458913AC.7080300@s5r6.in-berlin.de>
In-Reply-To: <458913AC.7080300@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
> Kristian Høgsberg wrote:
> ...
>> to sum up the changes:
>>
>>  - Got rid of bitfields.
>>
>>  - Tested on ppc, ppc64 x86-64 and x86.
>>
>>  - ioctl interface tested on 32-bit userspace / 64-bit kernels.
>>
>>  - ASCIIfied sources.
>>
>>  - Incorporated Jeff Garziks comments.
>>
>>  - Updated to work with the new workqueue API changes.
>>
>>  - Moved subsystem to drivers/firewire from drivers/fw.
>>
>> plus a number of bug fixes.
> 
> Congrats. WRT the 1st, 3rd, and 5th item you are now ahead of mainline's
> stack. :-)

Hehe, yeah, I saw the big FIXME in raw1394.c about compat_ioctl.  But 
raw1394.c shouldn't be that hard to fix, the ioctl structs are using 
explicitly sized types and u64 for userspace pointers, the one problem I see 
is that some of the 64-bit fields aren't 64-bit aligend.

>> As mentioned last time, the stack still lacks isochronous receive
>> functionality to be on par with the old stack, feature-wise.  This is
>> the one remaining piece of feature work kernel-side.  When that is
>> done, I have a couple of TODO items in user space:
> 
> Actually there are also eth1394 and pcilynx to be pulled over. Eth1394
> should be quite easy to do for anybody after iso reception is settled in
> your stack. Pcilynx could follow depending on developer interest. It's
> increasingly rare hardware and the few old machines which have it can be
> cheaply upgraded to OHCI (which performs better for SBP-2 anyway).

Well... I don't think eth1394 was ever used much and it's not something I plan 
to port over.  The only thing I've ever heard people say about it is that it's 
annoying because it screws up their network interface ordering.  And Windows 
Vista will drop the IP over 1394 functionality, which is another data point 
about how widely used this standard is.

I'm not planning to port the pcilynx driver either.  I think it's a sore point 
for the old stack as it is - nobody uses it or tests it and it's continously 
bit-rotting.  So I'd rather not support it.  However, it can perform as well 
as an OHCI card for SBP-2.  If you set up a self-modifying DMA program it can 
read and write system memory without CPU intervention too.

>>  - Make a libraw1394 compatibility library
> 
> Consider using libraw1394 right from the start of this porting project.
> If there is only one libraw1394 (which works with raw1394 and with
> fw-device-cdev), enthusiasts might have an easier time to test your stack.

Hmm, maybe.  There is going to be completely different code paths for each API 
entry point and not a lot of code sharing.  But there is definitely some merit 
to only having one library, and if it could detect the kernel interface 
automatically and just work that would be even better.

cheers,
Kristian


