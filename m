Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269774AbUJWBGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269774AbUJWBGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 21:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269610AbUJWBCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 21:02:46 -0400
Received: from gate.crashing.org ([63.228.1.57]:19644 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269748AbUJWBAM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 21:00:12 -0400
Subject: Re: [PATCH] ppc64: Add mecanism to check existence of legacy ISA
	devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410221730560.2101@ppc970.osdl.org>
References: <1098490981.11740.109.camel@gaston>
	 <Pine.LNX.4.58.0410221730560.2101@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1098493130.6008.122.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 23 Oct 2004 10:58:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 10:32, Linus Torvalds wrote:
> On Sat, 23 Oct 2004, Benjamin Herrenschmidt wrote:
> > 
> > This patch adds an arch function that can be overriden by the various
> > platforms at runtime, to query if a given legacy IO device actually
> > exist on the platform (based on the standard base port).
> 
> Ehh..
> 
> Why don't you use the "isapnp" or "acpi" interfaces?
> 
> Yeah yeah, you don't actually have isapnp on your system. But like it or 
> not, when we talk ISA enumeration, there is an existing standard for doing 
> it. And since the drivers involved don't actually do BIOS calls or 
> anything like that, they don't need to know that your "acpi" or "isapnp" 
> enumeration comes from ppc64 firmware..

Hrm... currently, those drivers just blindly go tap IO ports and ...

 - the isapnp stuff is _huge_, it's quite difficult to figure out what
to bring in and what not, and how to adapt it, especially since my
knowledge of the ISA stuff isn't that big

 - It's only about 2 or 3 drivers and none of theem uses isapnp at this
point anyway

It's really only about keyboard, floppy, and _maybe_ parport, I'm not
sure bringing in the whole isapnp stuff is worth it, but I'll have a
look. I'd appreciate if the workaround I posted could get in for now
though.

Ben.


