Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbTCZSWd>; Wed, 26 Mar 2003 13:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261407AbTCZSWd>; Wed, 26 Mar 2003 13:22:33 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:42501 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261319AbTCZSWc>; Wed, 26 Mar 2003 13:22:32 -0500
Date: Wed, 26 Mar 2003 18:33:40 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Thomas Molina <tmolina@cox.net>
cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: fbcon sleeping function call from illegal context
In-Reply-To: <Pine.LNX.4.44.0303261049490.1347-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0303261811350.18664-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Running with the patch as posted by Mr. Simmons I didn't get any further 
> instances of the sleeping function call from illegal context messages I 
> reported before, until screenblanking went into effect.  I then got the 
> following:

Oh no!!! I just look at the console timer blanking code. It calls alot of 
stuff. Not only does this mean we are limited in using kmalloc if we need 
it but also using a semaphore to sync up the fb_pixmap stuff. At present 
we use a spinlock. I tried it with a semphore but it kept hosing my 
system. Now I know why. 

What should be done is the console blank timer be passed onto 
console_callback.

P.S
     I reversed some of the cursor changes. It uses static buffers again 
until we have these issues solved. The code works as long as you don't use 
more than one framebuffer device but it is rock solid like before for a 
single framebuffer device. I will have a patch ready in the hour.



