Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272848AbTG3MXI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 08:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272857AbTG3MXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 08:23:08 -0400
Received: from modemcable198.171-130-66.que.mc.videotron.ca ([66.130.171.198]:61829
	"EHLO gaston") by vger.kernel.org with ESMTP id S272848AbTG3MXF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 08:23:05 -0400
Subject: Re: [PATCH] Framebuffer: client notification mecanism & PM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <1059510171.8538.53.camel@gaston>
References: <Pine.LNX.4.44.0307291753530.5874-100000@phoenix.infradead.org>
	 <1059510171.8538.53.camel@gaston>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1059567764.8538.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 30 Jul 2003 08:22:44 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I knew it was a matter of time before "client" management would happen. 
> > Is this a 2.6.X thing tho or shoudl we wait for the next developement 
> > cycle. I don't mind working on experimental stuff.

Note, BTW, there's also a locking issue. Typically, we must make sure
the fbcon (which may be running another CPU) have finished doing whatever
it was doing before returning, and we don't get any mode change or 
whatever ioctl initiated thing at that moment (or be in the middle of
doing it).

Right now, my code assumes any operation on the fbdev is protected by
the console sem. However, looking at the console & fbmem code, that is
not always true. Typically, userland ioctls in fbmem aren't, and vt.c
may call into consoles in some cases without holding it neither.

That should probably be fixed, though I haven't had time to work on
it yet.

Ben.

