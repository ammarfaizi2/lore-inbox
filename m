Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbTCZVpa>; Wed, 26 Mar 2003 16:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbTCZVpa>; Wed, 26 Mar 2003 16:45:30 -0500
Received: from AMarseille-201-1-1-208.abo.wanadoo.fr ([193.252.38.208]:21543
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262505AbTCZVpa>; Wed, 26 Mar 2003 16:45:30 -0500
Subject: Re: [Linux-fbdev-devel] Re: fbcon sleeping function call from
	illegal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Thomas Molina <tmolina@cox.net>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303261811350.18664-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303261811350.18664-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048715864.10475.61.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 26 Mar 2003 22:57:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 19:33, James Simmons wrote:
> > Running with the patch as posted by Mr. Simmons I didn't get any further 
> > instances of the sleeping function call from illegal context messages I 
> > reported before, until screenblanking went into effect.  I then got the 
> > following:
> 
> Oh no!!! I just look at the console timer blanking code. It calls alot of 
> stuff. Not only does this mean we are limited in using kmalloc if we need 
> it but also using a semaphore to sync up the fb_pixmap stuff. At present 
> we use a spinlock. I tried it with a semphore but it kept hosing my 
> system. Now I know why. 

Junk. Move that console blanking stuff to process context too.

Actually, I've never fully understood some of the console blanking
code, especially the PM callback in there which does really weird
things. On pmacs, this code cause the screen to first blank, then
unblank, then blank again when the machine is going to sleep.

Ben.

