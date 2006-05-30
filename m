Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWE3WfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWE3WfS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWE3WfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:35:18 -0400
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4]:8722 "EHLO
	smtp1.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S964775AbWE3WfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:35:16 -0400
X-Envelope-From: zajio1am@artax.karlin.mff.cuni.cz
Date: Wed, 31 May 2006 00:35:13 +0200
From: Ondrej Zajicek <santiago@mail.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060530223513.GA32267@localhost.localdomain>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>
X-Operating-System: Debian GNU/Linux 3.1 (Sarge)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2006 at 10:40:20AM -0700, David Lang wrote:
> as a long time linux user I tend to not to use the framebuffer, but 
> instead use the standard vga text drivers (with X and sometimes dri/drm).
> 
> in part this dates back to my early experiances with the framebuffer code 
> when it was first introduced, but I still find that the framebuffer is not 
> as nice to use as the simpler direct access for text modes. and when I 
> start X up it doesn't need a framebuffer, so why suffer with the 
> performance hit of the framebuffer?

Many users want to use text mode for console. But this request is not
in contradiction with fbdev and fbcon. It just requires to do some work:

1) To extend fbcon to be able to handle framebuffer in text mode.
2) To modify appropriate fbdev drivers to not do mode change at startup.
   Fill fb_*_screeninfo with appropriate values for text mode instead.
3) (optional) To modify appropriate fbdev drivers to be able to switch
   back from graphics mode to text mode.
   
Step 2) could be done easily - just disable mode switch and examine structure
of fb. Step 3) could be hacked using store and restore of vga registers
if better way is not available.

If someone do that, then there should be no difference in user experience
with vgacon and fbcon/vga16fb (or specific fb driver), which can result to
better acceptance of fb drivers between users.

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."
