Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbTLLVoV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 16:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTLLVoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 16:44:21 -0500
Received: from ppp-RAS1-2-115.dialup.eol.ca ([64.56.225.115]:3457 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262328AbTLLVoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 16:44:04 -0500
Date: Fri, 12 Dec 2003 16:43:10 -0500
From: William Park <opengeometry@yahoo.ca>
To: Boszormenyi Zoltan <zboszor@freemail.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Multiple keyboard/monitor vs linux-2.6?
Message-ID: <20031212214310.GA744@node1.opengeometry.net>
Mail-Followup-To: Boszormenyi Zoltan <zboszor@freemail.hu>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <fa.da53dsa.dho216@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.da53dsa.dho216@ifi.uio.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 12, 2003 at 09:13:28AM +0000, Boszormenyi Zoltan wrote:
> Hi,
> 
> is there a way to assign different keyboards to different vcs?
> I would like to set up a machine that has 2 keyboards, 2 mice and
> 2 videocards and run XFree-4.x on both heads. The videocard/monitor and
> mouse settings are easy to set up but I cannot find a device setting
> for the keyboard in man XF86Config. How can I do it with mainline kerne=
> ls?
> 
> After some googleing I found something called "backstreet ruby"
> http://startx.times.lv/eng-faq.html
> This gave me this info (howto in a nutshell):
> 
> 1. Boot with kernel option "dumbcon=N" to activate N dummy console.
> 2. cat /proc/bus/input/devices gives the input devices, search for keyb=
> oard
>    entries.
> 3. To assign a keyboard to a VT, feed the keyboard Phys= entry into
>    a VT, e.g. echo "isa0060/serio0/input0" > /proc/bus/console/00/keyb=
> oard
> 4. Start the X server on the proper VT.
> 
> The functionality can be found at linuxconsole.sourceforge.net.
> Will this be included into mainline near term? Say 2.6.[12]?
> The ruby-2.6 is against 2.6.0-test9 so it's almost uptodate.

Does it work?

I have 2 keyboard/mouse/video setup as well, but I followed 
    http://cambuca.ldhs.cetuc.puc-rio.br/multiuser/
by Miguel Freitas with 2.4.23 kernel, because you have to unload
'keybdev' USB module.  Kernel-2.6.0 doesn't seem to give me that choice.
In my XF86Config, I had to use
    Section "InputDevice" 
	Identifier	"USB Keyboard"
	Driver	"keyboard"
	Option	"Protocol"	"usbev"
	Option	"Device"	"/dev/input/event2"
	Option	"XkbRules"	"xfree86"
	Option	"XkbModel"	"pc104"
	Option	"XkbLayout"	"us"
    EndSection
for the USB keyboard.  Note the /dev/input/event2 and "Xkb*" lines --
they were necessary.

Both are mentioned in XFree-Local-multi-user-HOWTO.  Even though the
HOWTO is more for Backstreet Ruby, I couldn't make head or tail of it.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
Linux solution for data management and processing. 
