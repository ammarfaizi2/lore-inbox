Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbUBZAki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 19:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUBZAki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 19:40:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:50103 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262576AbUBZAka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 19:40:30 -0500
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402260014130.24952-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402260014130.24952-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077755580.22232.89.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 26 Feb 2004 11:33:01 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Well now that we have one input api that can happen. Of course with 
> graphics its much more diverse with what you can do. That is one of the 
> reasons for so many graphics libraries. It would be really hard to write
> a one size fits all library when it comes to graphics.

Note that I am NOT talking about a graphics library. This has NO
BUSINESS doing any kind of rendering. It's only the userland interface
to the underlying kernel drivers as far as mode switching & geometry
is concerned. That's _ALL_. In the same  was as libGL is the userland
interface to DRI, or iptables the userlnad interface to netfilter,
etc...
 
> By state machine I mean the physical hardware state. If it's hardware 
> access then it should be in the kernel. Note I'm refering to mode setting 
> not acceleration. Now EDID overrides per monitor model and saving the 
> state to disk is different. That should be userland. 

I agree. The HW access is done in kernel space. That's even true for
acceleration actually. You are mixing things. What I'm taking about
is exactly that: The userland library gets the various EDID & other
probing informations coming from the kernel drivers. It does the various
policy decisions on mode setting, it provides the API for userland to
deal with mode setting & monitor placement (what I call geometry)
and saving/restoring of configurations. The actual banging of the mode
to the HW is done by the kernel driver though. (The card specific back
end of the library probably builds either a mode description or a
register list and pass that to the kernel driver).

> I think we are fine for whats in the kernel. As for multiple head and 
> geometry stuff its not that hard if done right. I have been using 
> multi-head systems for years. I have multip desktop systems for years!!!

I have been using multi head systems for years and I've seen how good
it can be, but also a bunch of the pitfalls when trying to design a
driver for it. If it was that easy, we would have had the right support
in fbdev for ages. We don't.

Ben.

