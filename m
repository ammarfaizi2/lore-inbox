Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272387AbTGYXiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 19:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272388AbTGYXiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 19:38:17 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:52381 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S272387AbTGYXiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 19:38:15 -0400
Date: Sat, 26 Jul 2003 01:53:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Vojtech Pavlik <vojtech@suse.cz>, schierlm@gmx.de,
       linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: touchpad doesn't work under 2.6.0-test1-ac2
Message-ID: <20030725235318.GA1102@ucw.cz>
References: <82F70261D3A@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82F70261D3A@vcnet.vc.cvut.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 25, 2003 at 02:16:25AM +0200, Petr Vandrovec wrote:

> > For proper Synaptics support an XFree86 driver is available (get it at
> > http://w1.894.telia.com/~u89404340/touchpad/index.html). This will allow
> > for full support, including gesture recongition. Passthrough support for
> 
> I do not use XFree. I'm using 1600x1200 radeonfb consoles.

gpm support is on the way. Until it's available, you can use
'psmouse_noext=1' on the kernel or module command line to bring the
synaptics touchpad to standard PS/2 mouse mode. Then it'll work with gpm
without any changes. Don't expect advanced
multitap/scrolling/palmdetection, then, though.

> > Support for touchpads is nonexistent in mousedev.c, it only supports
> > mice, digitizers and touchscreens. Just adding an entry to the device
> > table is futile, you'd need much much more than that.
> 
> What's difference between touchscreen and touchpad? Both use absolute
> directions, and rest are just buttons... As I need working gpm, without 
> mousedev support Synaptics mode is of no use for me.

Touchscreen is overlaid over a screen. The cursor follows the finger
position exactly. This is the sale for digitizers, except a cursor is
replaced by a pen. Touchpads are completely different - the finger
motion is relativized and then summed up again, so instead of the cursor
following the finger position, it moves in the direction the finger
moves.

As an example, imagine touching the touchscreen in the lower left corner and
moving it to the upper right. You end up with the cursor in the upper
right corner. Now tap the lower left corner again, and the cursor moves
there immediately. This is the behavior mousedev supports.

While with a touchpad, you'll first see the cursor moving towards the
upper right corner, but not reaching it. Now after tapping the lower
left corner again, the cursor stays in position and can be moved further
...

See the difference?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
