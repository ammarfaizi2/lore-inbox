Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVG2PzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVG2PzI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVG2PzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:55:07 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:15033 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262637AbVG2PxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:53:23 -0400
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D72313E7-E2EC-4066-AD2A-02DAFE66B7E6@freescale.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: RFC: 64-bit resources and changes to pci, ioremap, ...
Date: Fri, 29 Jul 2005 10:53:14 -0500
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I started to update the existing patches to make struct resource  
have 64-bit start and end values I started to see all the places that  
this effects and was hoping to get some discussion on what direction  
we want to take.

One of the main reasons to make this change is to handle processors  
that have larger physical address space than effective.  A number of  
higher-end embedded processors are starting to support larger  
physical address space while still having a 32-bit effective  
address.  I was wondering if any x86 variants support this type of  
feature?

The main issue that I'm starting to see is that the concept of a  
physical address from the processors point of view needs to be  
consistent throughout all subsystems of the kernel.  Currently the  
major usage of struct resource is with the PCI subsystem and PCI  
drivers.  The following are some questions that I was hoping to get  
answers to and discussion around:

* How many 32-bit systems support larger than 32-bit physical  
addresses (I know newer PPCs do)?
* How many 32-bit systems support a 64-bit PCI address space?
* Should ioremap and variants start taking 64-bit physical addresses?
* Do we make this an arch option and wrap start and end in a typedef  
similar to pte_t and provide accessor macros to ensure proper use?

Andrew has also asked me to post size comparisons of drivers/*/*.o  
building allmodconfig with 32-bit resources and 64-bit resources to  
see what the size growth is.  I'll post logs for people to take a  
look at in a followup email.

- Kumar
