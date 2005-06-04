Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVFDNpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVFDNpd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 09:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVFDNpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 09:45:33 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:25770 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261348AbVFDNpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 09:45:25 -0400
Date: Sat, 4 Jun 2005 19:13:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Message-ID: <20050604134306.GB7439@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20050603112524.GB7022@in.ibm.com> <20050603182147.GB5751@kroah.com> <m13brz9tkf.fsf@ebiederm.dsl.xmission.com> <200506041618.24736.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506041618.24736.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 04, 2005 at 04:18:24PM +0300, Denis Vlasenko wrote:
> On Friday 03 June 2005 21:36, Eric W. Biederman wrote:
> > 
> > As I recall the drivers were not getting the interrupts but the interrupts
> > were happening.  To stop being spammed the kernel disables the irq line,
> > at the interrupt controller.  Then when the driver registered the
> > interrupt it would never receive the interrupt.
> 
> Shouldn't kernel keep all interrupt lines initially disabled 
> (sans platform-specific magic), and enable each like only when
> a device driver requests IRQ? This sounds simpler to do...

This doesn't help kdump folks. Interrupt pending from a device
from the first boot can flood the system when another driver
sharing the irq gets enabled in the second boot (kdump boot).
The disabling of interrupts need to be done on a per-device
basis for kdump to avoid this problem.

That said, I am not sure what is the issue with the console
drivers. What good is the irq for the console driver if
it hasn't requested for it ? Why should disabling it affect
consoles ? The interrupt will get enabled as soon as the driver
requests for it as per Vivek's patch. Am I missing something here ?

Thanks
Dipankar
