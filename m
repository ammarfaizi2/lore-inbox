Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264663AbUESXia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264663AbUESXia (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 19:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264664AbUESXia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 19:38:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:60093 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264663AbUESXiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 19:38:20 -0400
Subject: Re: [Linux-fbdev-devel] Re: FB accel capabilities patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Eger <eger@theboonies.us>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040519030319.1f0e6eec.akpm@osdl.org>
References: <Pine.LNX.4.58.0405191118170.4760@rosencrantz.theboonies.us>
	 <20040519030319.1f0e6eec.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1085009460.15182.87.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 20 May 2004 09:31:01 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 20:03, Andrew Morton wrote:
> David Eger <eger@theboonies.us> wrote:
> >
> > A month or two ago I noticed that the framebuffer console driver doesn't
> >  know to do proper framebuffer acceleration in Linux 2.6;
> 
> For what fbdev operations will acceleration be used?

Ok, the story is ... fbdevs do have optional accel hooks for copyarea,
rectfill, and imageblit. However, the current fbcon console subsystem
doesn't properly adapt it's drawing techniques based on the accel
capabilities (blit + redraw is more efficient for example when you have
a fast accelerated copyarea, while full redraw is better in other cases,
etc...)

This patch adds "hints" provided by the fbdev to inform fbcon what are
its accel capabilities.

Ben.


