Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267186AbUIJANm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbUIJANm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266870AbUIJANm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:13:42 -0400
Received: from vana.vc.cvut.cz ([147.32.240.58]:39808 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S268079AbUIJALi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:11:38 -0400
Date: Fri, 10 Sep 2004 02:11:13 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] fbdev: Add Tile Blitting support
Message-ID: <20040910001113.GA19132@vana.vc.cvut.cz>
References: <200409100534.56680.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409100534.56680.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 05:34:56AM +0800, Antonino A. Daplas wrote:
> 
> In my case at least, the cleanup did produce an unexpected but beneficial
> side effect, a little more speedup.  Not much, < 5%.
> 
> Petr, if you have comments, suggestions, or you think this is a bad idea,
> let me know.

It looks like good idea to me.  Though I still do not see benefits
2.6.x fbcon provides over 2.4.x.

BTW, there is still bad bug with software scrollback and multihead
(it is here since I remember): redraw_screen sets redraw to 0 when 
old_console == new_console, but fbcon uses con_switch() method for 
deciding whether software scrollback should be reinitialized or not.  
As software scrollback is per-system and not per-fbdev thing, this 
has rather nasty consequences - when both fbdevs have different xres, 
console user can crash system (con2fb /dev/fb1 /dev/tty11; set xres 
fb0 != xres fb1; chvt 11; chvt 10; chvt 11; hit alt-shift-pgup 
or force vt11 to scroll; crash, some kernel data structures were
overwritten with 0x0720...).
					Petr Vandrovec



