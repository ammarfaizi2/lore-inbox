Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWIADiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWIADiL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 23:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751011AbWIADiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 23:38:11 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:10625 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750982AbWIADiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 23:38:09 -0400
Message-ID: <44F7AB16.30405@myri.com>
Date: Thu, 31 Aug 2006 23:37:58 -0400
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Matt Porter <mporter@embeddedalley.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Simple userspace interface for PCI drivers
References: <20060830062338.GA10285@kroah.com> <20060830143410.GB19477@gate.crashing.org> <20060830175529.GB6258@kroah.com> <44F78E88.8050602@myri.com> <20060901032236.GB336@kroah.com>
In-Reply-To: <20060901032236.GB336@kroah.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>> Additionally, the current code might not be flexible enough regarding
>> acknowledging of interrupts. It might be good to use the bit that PCI
>> 2.2 defines in the config space to mask/unmask interrupt in a generic
>> way. Something like : when an interrupt comes, the driver mask the
>> interrupts using this bit, and then passes the event to user-space. The
>> user-space interrupt handler acknowledges the interrupt with the device
>> specific code, and then unmask with the PCI 2.2 bit.
>>     
>
> You can do that today with this code.  Remember, you have to have a
> tiny kernelspace portion of your driver to handle the interrupt.  You
> can do whatever you want in that interrupt handler.
>   

The whole point of masking interrupt with this config-space bit is that
we might not need any tiny kernelspace portion for our driver anymore.
It won't work for devices that are not PCI 2.2 compliant. But, it might
be good for the ones that are?

Brice

