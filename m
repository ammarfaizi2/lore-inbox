Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261598AbTCZLXr>; Wed, 26 Mar 2003 06:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261610AbTCZLXr>; Wed, 26 Mar 2003 06:23:47 -0500
Received: from pine.compass.com.ph ([202.70.96.37]:31756 "HELO
	pine.compass.com.ph") by vger.kernel.org with SMTP
	id <S261598AbTCZLXp>; Wed, 26 Mar 2003 06:23:45 -0500
Subject: Re: [Linux-fbdev-devel] [BK FBDEV] A few more updates.
From: Antonino Daplas <adaplas@pol.net>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <84D3825146@vcnet.vc.cvut.cz>
References: <84D3825146@vcnet.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1048677567.1025.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Mar 2003 19:20:19 +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 18:42, Petr Vandrovec wrote:
> On 26 Mar 03 at 17:53, Antonino Daplas wrote:
> > On Wed, 2003-03-26 at 13:34, James Simmons wrote:
> > > 
> > > > 5.  softcursor should not concern itself with memory bookkeeping, and
> > > > must be able to function with just the parameter passed to it in order
> > > > to keep it as simple as possible.  These tasks are moved to
> > > > accel_cursor.
> > > 
> > > We do if we make a ioctl for cursors. I'm trying to avoid reprogramming 
> > > the hardware over and over again if the properties of the cursor don't 
> > > change. The idea is similar to passing in var and comparing it to the var 
> > > in struct fb_info. 
> > 
> > Of course, that's what the fb_cursor.set field is for, and drivers have
> > the option of ignoring or not ignoring bits in this field. Whoever calls
> > fb_cursor has the responsibility of setting any cursor state changes. 
> > 
> > Unlike fb_set_var(), cursor states change very frequently (ie, each
> > blink or movement of the cursor are considered state changes), so just
> > forego the memcmp() and call fb_cursor unconditionally.  Let the
> > low-level method sort it out by checking bits in fb_cursor.set.
> 
> accel_cursor unconditionally sets FB_CUR_SETPOS. Can you write it
> down to the TODO list to eliminate this? Cursor position lives 
> in different registers than cursor enable/disable on my hardware...
> 

The patch that I submitted to James does that already.

> And if we could rename FB_CUR_SETCUR to FB_CUR_SETVISIBILITY and
> leave cursor->enable setting on accel_cursor's caller, it would
> be even better.
> 
> And if we could change enable value to 0: disable; 1: enable;
> 2: disable due to blink (called from vbl), it would be even better,
> as then fbdev which does hardware blinking could just completely
> ignore changes which set only FB_CUR_SETVISIBILITY with enable == 2.


Okay.


Tony


