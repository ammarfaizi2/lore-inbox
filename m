Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTLSTuh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 14:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTLSTuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 14:50:37 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:44212 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S263568AbTLSTug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 14:50:36 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: nick black <dank@suburbanjihad.net>
Date: Fri, 19 Dec 2003 20:50:32 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6-test11 framebuffer Matrox
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2D06A661C4B@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Dec 03 at 16:29, nick black wrote:
> In article <3FE2BB05.1000107@convergence.de>, Michael Hunold wrote:
> > Hmm, I just tested with the 2.6.0 release and my both cards are working 
> > properly now. The only thing is a huge white box around the penguin logo.
> 
> As I said, this happens to me without Petr's patch, and goes away with
> it.  Can you check out my earlier post in this thread, and analyze your
> X+fbcon interaction with reagrds to fbdev vs. mga driver, and Petr's
> patch?

I think that it works due to pure luck. XFree's mga driver reprograms 
some accelerator registers (namely color depth and horizontal line length)
under some circumstances (like when gnome's clock applet in right upper
corner changes value - i.e. every second or every minute depending on
setting when DRI is enabled) even if XFree are not on foreground.  This
causes serious problems, as then you are running console at (say) 640x480/8bpp,
but accelerator gets set to 1280x1024/32bpp, painting 16x larger characters
to screen :-(

I know only three workarounds: either do not use DRI, or disable use of
accelerator on console (fbset -accel false), or use same vxres and depth
on console and in X (or fourth: fix XFree driver to not touch hardware
when they are not on foreground...).
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

