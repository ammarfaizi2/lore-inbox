Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTE0WHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbTE0WHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:07:11 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:31245 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264208AbTE0WHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:07:10 -0400
Date: Tue, 27 May 2003 23:20:22 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] matroxfb update to new API
In-Reply-To: <20030527175021.GA2453@vana.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0305272254580.26160-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (Mis) Features:
> Removed support for text mode. No way for it with current API.

The issue is putc[s]. Th eothers could be done pretty easy. The question 
is do we want to use fbcon for text modes. Fbcon is so big and heavy for
text mode. The /dev/fb interface in this case also doesn't make sense.

> Removed support for hardware cursor. Generic cursor code has enough 
> 	troubles as is, in software mode.

I have patches that explain the new cursor api. Right now I'm recovering 
from being sick so I haven't worked on fixes.

> No reasonable fbset support... It is especially annoying on multihead
> 	system, as 'stty cols XXX rows YYY' does not change pixclock...

Look at fbmon.c. There are functions that can generate reasonable values.
Personally I like to see tha ability to set the pixclock via sysfs.
The truth is that I never had go luck with that functionality. Many 
drivers would freak out when I switched modes.

> Removed fastfont support. No way for it with current API.

Its there but I haven't implemented it yet, struct pixmap. In this case 
struct pixmap would be a static map not a dynamic map as it is currently. 
We can fix that one together.  

> (Mis) Features inherited from generic fbdev API:
> Cursor on other framebuffers than primary one does not blink.

Each framebuffer will need a indepenednt timer. 

> Contents of visible, but not foreground, display is not updated.

Ah the broken console system. Blanking is the same way. When the console 
system blank all VTs blank. I will be working on my VGA/MDA system and 
then all the sudden both console go blank. This will take some magic to do 
without touching the core console code. 

