Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTJFMo1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 08:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTJFMo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 08:44:27 -0400
Received: from jack.stev.org ([217.79.103.51]:54290 "EHLO jack.stev.org")
	by vger.kernel.org with ESMTP id S261844AbTJFMoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 08:44:25 -0400
Date: Mon, 6 Oct 2003 13:47:43 +0100 (BST)
From: James Stevenson <james@stev.org>
X-X-Sender: james@Beast.ez-dsp.com
To: Takashi Iwai <tiwai@suse.de>
cc: Kees Bakker <kees.bakker@xs4all.nl>, <linux-kernel@vger.kernel.org>,
       James Stevenson <james@ez-dsp.com>
Subject: Re: [2.6.0-test6] Scratchy sound with via82xx (VT8233)
In-Reply-To: <s5hllryo86f.wl@alsa2.suse.de>
Message-ID: <Pine.LNX.4.44.0310061344010.7448-100000@Beast.ez-dsp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Oct 2003, Takashi Iwai wrote:

> At Thu, 2 Oct 2003 21:05:59 +0100 (IST),
> James Stevenson wrote:
> > 
> > > > 
> > > > I saw the note about dxs_support, but I have the driver built-in. How do I set
> > > > dxs_support from the /proc/cmdline?
> > > 
> > > pass via boot parameter:
> > > 
> > >   snd-via82xx=1,0,,-1,48000,XXX
> > > 
> > > where XXX is the value from 0 to 3 for dxs_support.
> > > see the comment in sound/via82xx.c.
> > 
> > 
> > will this work for a 2.4.x kernel as well ?
> 
> only if the driver is built in the kernel...

Actually i found a different solution to my problem.
This patch against 2.4.22 seems to sort out my troubles.

Was running this on saturday for around 6/7 hours didnt
skip once. From a problem that used to badly effect me
everytime large windows were redrawn in X like a X virtual
screen switch.


--- via82cxxx_audio.c	1 Sep 2003 10:50:01 -0000	1.1.1.16
+++ via82cxxx_audio.c	4 Oct 2003 10:58:44 -0000
@@ -79,14 +79,14 @@
 #define VIA_COUNTER_LIMIT	100000
 
 /* size of DMA buffers */
-#define VIA_MAX_BUFFER_DMA_PAGES	32
+#define VIA_MAX_BUFFER_DMA_PAGES	128
 
 /* buffering default values in ms */
 #define VIA_DEFAULT_FRAG_TIME		20
-#define VIA_DEFAULT_BUFFER_TIME		500
+#define VIA_DEFAULT_BUFFER_TIME		100
 
 /* the hardware has a 256 fragment limit */
-#define VIA_MIN_FRAG_NUMBER		2
+#define VIA_MIN_FRAG_NUMBER		16
 #define VIA_MAX_FRAG_NUMBER		128
 
 #define VIA_MAX_FRAG_SIZE		PAGE_SIZE


