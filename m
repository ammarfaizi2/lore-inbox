Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbTCZKY0>; Wed, 26 Mar 2003 05:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261538AbTCZKYZ>; Wed, 26 Mar 2003 05:24:25 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:43528 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S261533AbTCZKXp>; Wed, 26 Mar 2003 05:23:45 -0500
Subject: Re: [Linux-fbdev-devel] [BK FBDEV] A few more updates.
From: Antonino Daplas <adaplas@pol.net>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303260519380.12718-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303260519380.12718-100000@phoenix.infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048673964.1025.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Mar 2003 18:20:19 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 13:34, James Simmons wrote:
> 
> > 3.  BTW, there are too many kmalloc's/kfree's in accel_cursor() and
> > softcursor().  Personally, I would rather have 2 64-byte buffers for the
> > mask and the data in the info->cursor structure than allocating/freeing
> > memory each time the cursor flashes.  However, if you prefer doing it
> > this way, the patch also includes changes so kmallocs are only done when
> > necessary.  Still, accel_cursor() has unnecessary work being done, such
> > as always creating the mask bitmap, when a simple flag to monitor cursor
> > shape changes could prevent all this.
> 
> I agree. The problem is the upper layer of the console system is to brain 
> dead. Its either erase the cursor or redraw it again. There is no way to 
> just say cursor just moved. There is a CM_MOVE but the upper layer doesn't 
> even use it :-( If you look at vgacon and friends you will see they 
> recreate the cursor every time the cursor blinks. Yes even vgacon.c does 
> this. It is stupid and brain dead but that is the way the upper layers of 
> the console work. The correct solution would be to use actually use 
> CM_MOVE in the upper layers.

Even so, (and I don't really fault the console cursor as it only needs
to show, hide and move the cursor), accel_cursor() can easily monitor
shape changes.  We can use a bitfield somewhere in fb_cursor(perhaps the
high 8 bits of info->fb_cursor.set?) to "remember" the current cursor
shape.

Tony


