Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261494AbVFCSmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbVFCSmA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 14:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVFCSmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 14:42:00 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28840 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261494AbVFCSlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 14:41:51 -0400
To: Greg KH <greg@kroah.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC/PATCH] Kdump: Disabling PCI interrupts in capture kernel
References: <20050603112524.GB7022@in.ibm.com>
	<20050603182147.GB5751@kroah.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Jun 2005 12:36:00 -0600
In-Reply-To: <20050603182147.GB5751@kroah.com>
Message-ID: <m13brz9tkf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

> On Fri, Jun 03, 2005 at 04:55:24PM +0530, Vivek Goyal wrote:
> > Hi,
> > 
> > In kdump, sometimes, general driver initialization issues seems to be cropping
> 
> > in second kernel due to devices not being shutdown during crash and these 
> > devices are sending interrupts while second kernel is booting and drivers are
> 
> > not expecting any interrupts yet.
> 
> What are the errors you are seeing?
> How would the drivers be able to be getting interrupts delivered to them
> if they haven't registered the irq handler yet?

As I recall the drivers were not getting the interrupts but the interrupts
were happening.  To stop being spammed the kernel disables the irq line,
at the interrupt controller.  Then when the driver registered the
interrupt it would never receive the interrupt.

Eric
