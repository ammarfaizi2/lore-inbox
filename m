Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVA0BGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVA0BGK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 20:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVA0APy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:15:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:43478 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262471AbVAZWLW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 17:11:22 -0500
Subject: Re: [PATCH 1/1] pci: Block config access during BIST (resend)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: brking@us.ibm.com
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@muc.de>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41F7C6A1.9070102@us.ibm.com>
References: <200501101449.j0AEnWYF020850@d03av01.boulder.ibm.com>
	 <m14qhpxo2j.fsf@muc.de> <41E2AC74.9090904@us.ibm.com>
	 <20050110162950.GB14039@muc.de> <41E3086D.90506@us.ibm.com>
	 <1105454259.15794.7.camel@localhost.localdomain>
	 <20050111173332.GA17077@muc.de>
	 <1105626399.4664.7.camel@localhost.localdomain>
	 <20050113180347.GB17600@muc.de>
	 <1105641991.4664.73.camel@localhost.localdomain>
	 <20050113202354.GA67143@muc.de>  <41ED27CD.7010207@us.ibm.com>
	 <1106161249.3341.9.camel@localhost.localdomain>
	 <41F7C6A1.9070102@us.ibm.com>
Content-Type: text/plain
Date: Thu, 27 Jan 2005 09:10:05 +1100
Message-Id: <1106777405.5235.78.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 10:34 -0600, Brian King wrote:

> Here is the last one. I've looked at making userspace sleep until BIST 
> is finished. The downside I see to this is that is complicates the patch 
> due to the following reasons:
> 
> 1. In order to also make this work for Ben's PPC power management usage 
> would require an additional flag and additional APIs to set and clear 
> the flag.
> 2. Since BIST can be run at interrupt context, the interfaces to block 
> and unblock userspace accesses across BIST must be callable from 
> interrupt context. This prevents the usage of semaphores or simple 
> wait_event macros and requires new macros that carefully check the new 
> pci device flag and manage the spinlock.
> 

Well, I honestly think that this is unnecessary burden. I think that
just dropping writes & returning data from the cache on reads is enough,
blocking userspace isn't necessary, but then, I may be wrong ;)

Ben.


