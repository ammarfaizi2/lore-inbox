Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUJ0KVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUJ0KVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262376AbUJ0KUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:20:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:28645 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262374AbUJ0KBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:01:45 -0400
Subject: Re: [ACPI] Re: [Proposal]Another way to save/restore PCI config
	space for suspend/resume
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Len Brown <len.brown@intel.com>
Cc: Li Shaohua <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <417F409A.5060409@intel.com>
References: <fa.fvou17m.1f5oa9u@ifi.uio.no> <fa.ivj042g.g5qnoo@ifi.uio.no>
	 <417F409A.5060409@intel.com>
Content-Type: text/plain
Date: Wed, 27 Oct 2004 19:57:37 +1000
Message-Id: <1098871057.9478.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-27 at 02:30 -0400, Len Brown wrote:
> Li Shaohua wrote:
> > On Tue, 2004-10-26 at 17:21, Pavel Machek wrote:
> 
> >>>Here is a another idea: 
> >>>Record all PCI writes in Linux kernel...
> >>
> >>That looks extremely ugly to me. If you want to do something special
> >>in resume function, just do it there. It will probably share a lot of
> >>code with your init function, anyway.
> > 
> > How can you handle devices without driver? And how to save/restore
> > config space for special devices, such as LPC bridge and host bridge?
> 
> Say that writing the missing drivers is the only workable solution.
> Does anybody have an estimate of how many there are and how big
> a task that would be?

This has been discussed a bit on linux-pm (on osdl lists, it's a new
list to discuss PM specific matters). I tend to think the core should
know at least a few "standard" things like P2P bridges, by simply
saving/restoring a bigger chunk of config space. We also need to fix the
current restore code I suppose, so that it disables IO & MEM, then
restore all registers, then re-enable those 2 ones...

I don't want to cross-post between lists, but people are welcome to join
linux-pm to talk about implementation issues related to power
management, including the changes we are trying to define to the various
driver callbacks. 

Ben.


