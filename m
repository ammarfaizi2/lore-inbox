Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263242AbUB1Bqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 20:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUB1Bqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 20:46:35 -0500
Received: from gate.crashing.org ([63.228.1.57]:14268 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263244AbUB1Bqe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 20:46:34 -0500
Subject: Re: Radeon Framebuffer Driver in 2.6.3?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: arief# <arief_m_utama@telkomsel.co.id>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0402280048120.2216-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0402280048120.2216-100000@phoenix.infradead.org>
Content-Type: text/plain
Message-Id: <1077932239.23405.71.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 12:37:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Rememeber we have to modify every driver then to support FB_ACTIVATE_FORCE.
> You have to ask yourself what do you want to do exactly? 

No we don't. Only fbmem, and that's part of the patch. What we could
do is strip the FB_ACTIVATE_FORCE (and actually clear out the
activate field completely) when copying to the driver's var structure
in fb_set_var().

In fact, we should certainly fix fb_set_var to _ignore_ the activate
field when comparing the var structures... this is a bug in the
current version imho.

It's a bit difficult to fix it while keeping memcmp, except if we do
a local copy of the var structure, which would eat stack space...

One problem with unblank is that it can be called at interrupt time,
but I don't think that ever happens with mode_switch set to true.
So we may just kmalloc a local copy of the var...

Ben.


