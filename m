Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbVFDNSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbVFDNSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 09:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVFDNSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 09:18:41 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:49132 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261344AbVFDNSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 09:18:39 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: ebiederm@xmission.com (Eric W. Biederman), Greg KH <greg@kroah.com>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
Date: Sat, 4 Jun 2005 16:18:24 +0300
User-Agent: KMail/1.5.4
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>, Alan Stern <stern@rowland.harvard.edu>
References: <20050603112524.GB7022@in.ibm.com> <20050603182147.GB5751@kroah.com> <m13brz9tkf.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m13brz9tkf.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506041618.24736.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 June 2005 21:36, Eric W. Biederman wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Fri, Jun 03, 2005 at 04:55:24PM +0530, Vivek Goyal wrote:
> > > Hi,
> > > 
> > > In kdump, sometimes, general driver initialization issues seems to be cropping
> > 
> > > in second kernel due to devices not being shutdown during crash and these 
> > > devices are sending interrupts while second kernel is booting and drivers are
> > 
> > > not expecting any interrupts yet.
> > 
> > What are the errors you are seeing?
> > How would the drivers be able to be getting interrupts delivered to them
> > if they haven't registered the irq handler yet?
> 
> As I recall the drivers were not getting the interrupts but the interrupts
> were happening.  To stop being spammed the kernel disables the irq line,
> at the interrupt controller.  Then when the driver registered the
> interrupt it would never receive the interrupt.

Shouldn't kernel keep all interrupt lines initially disabled 
(sans platform-specific magic), and enable each like only when
a device driver requests IRQ? This sounds simpler to do...
--
vda

