Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261538AbTCZKbf>; Wed, 26 Mar 2003 05:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbTCZKbf>; Wed, 26 Mar 2003 05:31:35 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:63946 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261538AbTCZKbe>;
	Wed, 26 Mar 2003 05:31:34 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Antonino Daplas <adaplas@pol.net>
Date: Wed, 26 Mar 2003 11:42:35 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [Linux-fbdev-devel] [BK FBDEV] A few more updates.
Cc: jsimmons@infradead.org,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <84D3825146@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Mar 03 at 17:53, Antonino Daplas wrote:
> On Wed, 2003-03-26 at 13:34, James Simmons wrote:
> > 
> > > 5.  softcursor should not concern itself with memory bookkeeping, and
> > > must be able to function with just the parameter passed to it in order
> > > to keep it as simple as possible.  These tasks are moved to
> > > accel_cursor.
> > 
> > We do if we make a ioctl for cursors. I'm trying to avoid reprogramming 
> > the hardware over and over again if the properties of the cursor don't 
> > change. The idea is similar to passing in var and comparing it to the var 
> > in struct fb_info. 
> 
> Of course, that's what the fb_cursor.set field is for, and drivers have
> the option of ignoring or not ignoring bits in this field. Whoever calls
> fb_cursor has the responsibility of setting any cursor state changes. 
> 
> Unlike fb_set_var(), cursor states change very frequently (ie, each
> blink or movement of the cursor are considered state changes), so just
> forego the memcmp() and call fb_cursor unconditionally.  Let the
> low-level method sort it out by checking bits in fb_cursor.set.

accel_cursor unconditionally sets FB_CUR_SETPOS. Can you write it
down to the TODO list to eliminate this? Cursor position lives 
in different registers than cursor enable/disable on my hardware...

And if we could rename FB_CUR_SETCUR to FB_CUR_SETVISIBILITY and
leave cursor->enable setting on accel_cursor's caller, it would
be even better.

And if we could change enable value to 0: disable; 1: enable;
2: disable due to blink (called from vbl), it would be even better,
as then fbdev which does hardware blinking could just completely
ignore changes which set only FB_CUR_SETVISIBILITY with enable == 2.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

