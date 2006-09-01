Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWIABge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWIABge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964850AbWIABge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:36:34 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:35062 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S964849AbWIABgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:36:33 -0400
Message-ID: <44F78E88.8050602@myri.com>
Date: Thu, 31 Aug 2006 21:36:08 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matt Porter <mporter@embeddedalley.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <20060830175529.GB6258@kroah.com>
In-Reply-To: <20060830175529.GB6258@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Aug 30, 2006 at 09:34:10AM -0500, Matt Porter wrote:
>   
>> On Tue, Aug 29, 2006 at 11:23:38PM -0700, Greg KH wrote:
>>     
>>> A while ago, Thomas and I were sitting in the back of a conference
>>> presentation where the presenter was trying to describe what they did in
>>> order to add the ability to write a userspace PCI driver.  As was usual
>>> in a presentation like this, the presenter totaly ignored the real-world
>>> needs for such a framework, and only got it up and working on a single
>>> type of embedded system.  But the charts and graphs were quite pretty :)
>>>
>>> Thomas and I lamented that we were getting tired of seeing stuff like
>>> this, and it was about time that we added the proper code to the kernel
>>> to provide everything that would be needed in order to write PCI drivers
>>> in userspace in a sane manner.  Really all that is needed is a way to
>>> handle the interrupt, everything else can already be done in userspace
>>> (look at X for an example of this...)
>>>       
>> What about portable access to the PCI DMA API from userspace?
>>     
>
> It currently does not provide this, but if you know how your card works,
> I'm pretty sure you can get this working without such an interface.
>
> If you wish to add this functionality, to make it easier, that would be
> great.
>   

I might be nice to have something like a copy-block where the
application writes/reads data, while the device does DMA only from/to
there. We would need an easy way to mmap some anonymous DMA-ready memory
in user-space, and something to give the corresponding DMA addresses to
the application.


Additionally, the current code might not be flexible enough regarding
acknowledging of interrupts. It might be good to use the bit that PCI
2.2 defines in the config space to mask/unmask interrupt in a generic
way. Something like : when an interrupt comes, the driver mask the
interrupts using this bit, and then passes the event to user-space. The
user-space interrupt handler acknowledges the interrupt with the device
specific code, and then unmask with the PCI 2.2 bit.

Brice

