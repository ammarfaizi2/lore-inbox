Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVC2IAZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVC2IAZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 03:00:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbVC2Htk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:49:40 -0500
Received: from ds01.webmacher.de ([213.239.192.226]:25244 "EHLO
	ds01.webmacher.de") by vger.kernel.org with ESMTP id S262569AbVC2Hr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:47:58 -0500
In-Reply-To: <1112067369.19014.24.camel@mindpipe>
References: <1111966920.5409.27.camel@gaston> <1112067369.19014.24.camel@mindpipe>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Marcin Dalecki <martin@dalecki.de>
Subject: Re: Mac mini sound woes
Date: Tue, 29 Mar 2005 09:47:35 +0200
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-03-29, at 05:36, Lee Revell wrote:

> On Mon, 2005-03-28 at 09:42 +1000, Benjamin Herrenschmidt wrote:
>> It seems that Apple's driver has an in-kernel framework for doing 
>> volume
>> control, mixing, and other horrors right in the kernel, in temporary
>> buffers, just before they get DMA'ed (gack !)
>>
>> I want to avoid something like that. How "friendly" would Alsa be to
>> drivers that don't have any HW volume control capability ? Does 
>> typical
>> userland libraries provide software processing volume control ? Do you
>> suggest I just don't do any control ? Or should I implement a double
>> buffer scheme with software gain as well in the kernel driver ?
>
> alsa-lib handles both mixing (dmix plugin) and volume control (softvol
> plugin) in software for codecs like this that don't do it in hardware.
> Since Windows does mixing and volume control in the kernel (ugh) it's
> increasingly common to find devices that cannot do these.  You don't
> need to handle it in the driver at all.
>
> dmix has been around for a while but softvol plugin is very new, you
> will need ALSA CVS or the upcoming 1.0.9 release.

Instead of the lame claims on how ugly it is to do hardware mixing in
kernel space the ALSA fans should ask them self the following questions:

1. Where do you have true "real-time" under linux? Kernel or user space?
2. Where would you put the firmware for an DSP? Far away or as near to 
hardware as possible?
3. How do you synchronize devices on non real time system?
4. Why the hell do we have whole network protocols inside the kernel? 
Couldn't those
be perfectly handled in user space? Or maybe there are good reasons?
5. Should a driver just basically map the hardware to the user space or 
shouldn't
it perhaps provide abstraction from the actual hardware implementing it?
6. Is there really a conceptual difference between a DSP+CPU+driver and 
just
looking at the MMX IP core of the CPU as an DSP?

