Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262630AbTCIVSo>; Sun, 9 Mar 2003 16:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262632AbTCIVSn>; Sun, 9 Mar 2003 16:18:43 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:6281 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S262630AbTCIVSj>;
	Sun, 9 Mar 2003 16:18:39 -0500
Date: Sun, 9 Mar 2003 22:29:03 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: jsimmons@infradead.org
Cc: Antonino Daplas <adaplas@pol.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [Linux-fbdev-devel] Re: FBdev updates.
Message-ID: <20030309212903.GC16578@vana.vc.cvut.cz>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org> <20030220150201.GD13507@codemonkey.org.uk> <20030220182941.GK14445@vana.vc.cvut.cz> <1045787031.2051.9.camel@localhost.localdomain> <20030303203500.GA2916@vana.vc.cvut.cz> <20030304212906.GA1115@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030304212906.GA1115@middle.of.nowhere>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
  I tried to use fb_cursor and I have quite a lot problems with
it:
(1) it uses global variables for storing last cursor value -
    - but there is no global hardware, so after switching from
    one fbdev to another you can have cursor with wrong shape,
    wrong color and so on...
(2) callback from timer for cursor blinking may set almost any
    FB_CUR_* bits. But in this case fb_cursor callback may be
    called from interrupt context, while accelerator is busy
    and so on... Did I miss some synchronization? Best for me
    would be disabling blinking code in fbcon completely:
    in VGA mode cursor blinks automatically, and in graphics mode
    more lightweight only 'flash' callback is more appropriate
    for me. But then there is problem with
(3) cursor_undrawn... I have no idea how is this supposed to work
    if fbdev provides hardware cursor... And HZ/50 delay after
    putcs makes orientation on screen very complicated, as there
    is no cursor while new characters are appearing on screen.
    
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz
