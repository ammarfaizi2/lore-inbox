Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTD3UYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTD3UYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:24:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:6672 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S262379AbTD3UYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:24:36 -0400
Date: Wed, 30 Apr 2003 22:36:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Erik Andersen <andersen@codepoet.org>, David van Hoose <davidvh@cox.net>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
Message-ID: <20030430203647.GA7356@alpha.home.local>
References: <20030424212508.GI14661@codepoet.org> <200304251401.36430.m.c.p@wolk-project.de> <200304251410.31701.m.c.p@wolk-project.de> <20030430090242.GA15480@codepoet.org> <3EB02D0F.1080101@cox.net> <20030430202238.GA20412@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430202238.GA20412@codepoet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I add to fix it too, and I sent the patch to Erik privately but it
was not clear that it would indeed fix this problem. It comes from
sound_core.c not including adriver.h which contains the compat code.

Here is a simple patch which works for me.

cheers,
willy

--- ./sound/sound_core.c.orig	Wed Apr 30 15:11:14 2003
+++ ./sound/sound_core.c	Wed Apr 30 15:11:52 2003
@@ -45,6 +45,7 @@
 #include <linux/major.h>
 #include <linux/kmod.h>
 #include <linux/devfs_fs_kernel.h>
+#include <sound/driver.h>
 
 #define SOUND_STEP 16
 
On Wed, Apr 30, 2003 at 02:22:39PM -0600, Erik Andersen wrote:
> On Wed Apr 30, 2003 at 03:07:43PM -0500, David van Hoose wrote:
> > I'm getting an unresolved in soundcore.o that is preventing me from 
> > having sound.
> > /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: unresolved symbol 
> > devfs_remove
> > /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod 
> > /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o failed
> > /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod snd-card-0 failed
> > 
> 
> It compiles for me, but I don't use devfs.  Perhaps there is
> a problem with the compatibility code in include/sound/adriver.h
> 
> > Can that be fixed?
> 
> I am certain it can.  But since it works for me and since I am
> moving this week (lots of packing to do) it may not be till sometime
> next week before I get the time to work further on it.
