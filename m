Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262350AbVAUMeU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262350AbVAUMeU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbVAUMeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:34:20 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:14058 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262350AbVAUMd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:33:57 -0500
Date: Fri, 21 Jan 2005 13:33:39 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matt Mackall <mpm@selenic.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org
Subject: Re: Radeon framebuffer weirdness in -mm2
In-Reply-To: <20050121060928.GI12076@waste.org>
Message-ID: <Pine.LNX.4.61.0501211315010.6118@scrub.home>
References: <20050120232122.GF3867@waste.org> <20050120153921.11d7c4fa.akpm@osdl.org>
 <20050120234844.GF12076@waste.org> <20050120160123.14f13ca6.akpm@osdl.org>
 <20050121035758.GH12076@waste.org> <20050120200530.4d5871f9.akpm@osdl.org>
 <20050120200711.4313dbcc.akpm@osdl.org> <20050121060928.GI12076@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 20 Jan 2005, Matt Mackall wrote:

> On Thu, Jan 20, 2005 at 08:07:11PM -0800, Andrew Morton wrote:
> > Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > Next suspects would be:
> > > 
> > >  +cleanup-vc-array-access.patch
> > >  +remove-console_macrosh.patch
> > >  +merge-vt_struct-into-vc_data.patch
> > > 
> > > 
> > 
> > Make that:
> > 
> > +cleanup-vc-array-access.patch
> > +remove-console_macrosh.patch
> > +merge-vt_struct-into-vc_data.patch
> > +vgacon-fixes-to-help-font-restauration-in-x11.patch
> 
> It's something in this batch. Which is good, as I'd be a bit
> disappointed if the "vt leakage" were somehow attributable to the fb
> layer. More bisection after dinner.

Could you try the patch below. I cleaned up the logic a little in 
redraw_screen() and the code below really wants to do a update_screen().
The old switch_screen(fg_console) behaved like update_screen(fg_console).

bye, Roman

Index: linux-2.6/drivers/video/console/fbcon.c
===================================================================
--- linux-2.6.orig/drivers/video/console/fbcon.c	2005-01-21 13:02:45.000000000 +0100
+++ linux-2.6/drivers/video/console/fbcon.c	2005-01-21 13:03:03.000000000 +0100
@@ -609,7 +609,7 @@
 				   fg_vc->vc_rows);
 	}
 
-	switch_screen(vc_cons[fg_console].d);
+	update_screen(vc_cons[fg_console].d);
 }
 
 /**
