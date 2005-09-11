Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbVIKWdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVIKWdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 18:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbVIKWdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 18:33:21 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:60623 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750987AbVIKWdV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 18:33:21 -0400
Date: Mon, 12 Sep 2005 00:34:14 +0200
To: Zoltan Szecsei <zoltans@geograph.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: multiple independent keyboard kernel support
Message-ID: <20050911223414.GA19403@aitel.hist.no>
References: <4316E5D9.8050107@geograph.co.za>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4316E5D9.8050107@geograph.co.za>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2005 at 01:28:25PM +0200, Zoltan Szecsei wrote:
> Hi All,
> The archives & FAQs on this subject stop at December 2003. Google not 
> much help either (prob. due to my keyword choices)
> 
> I gather the only way to do this is via the ruby patch.
> 
> (When) Will there ever be native kernel (and maybe XFree) support for 
> multiple independent keyboards?
> 

xorg from debian testing or from ubuntu already support multiple
independent keyboards.  I'm using that right now for my
two-user single-pc setup.

Each independent xserver have a section like this in the xorg.conf:
Section "InputDevice"
        Identifier      "Generic Keyboard"
        Driver          "kbd"
        Option          "Protocol"      "evdev"
        Option          "Dev Phys"      "isa0060/serio0/input0"
        Option          "CoreKeyboard"
        Option          "XkbRules"      "xfree86"
        Option          "XkbModel"      "pc102"
        Option          "XkbLayout"     "no"
EndSection

In the serverlayout section, use the IsolateDevice option so
the independent xservers don't stomp on each other's cards.

In the screen section, set the "InitPrimary" option for cards that
doesn't get initialized by the bios at bootup.

In the device section, use the BusID option to be safe.

Start your xserver with the -sharevts option.


I have only one _console_, but multiple xservers with
separate keyboards works with plain 2.6.13.

Multiple consoles are also doable, if someone writes a "getty"
that uses the evdev interface for input (instead of tty's)
and the framebuffer interfaces for output (instead of tty's).

> The ruby patch seems to also only have discussions older than 18 months.
> 
> Has there really been no progress in the last 18 months?
> 
Looks  like much of the interest in ruby work disappeared as the evdev
option for X became widespread.  X is what most people use for desktops,
and that works well enough without ruby now.

> I would prefer to see "official and permanent" support for this as then 
> when HW & drivers & kernels develop in the future, this capability will 
> always be (immediately) available - and not have to wait for patches.
> 

"evdev" in the kernel already separates out independent keyboards.
Isolatedevice lets several xservers run indepenmdently.  There isn't
much missing, although there are minor troubles where starting one
xserver might mess up the video timing for another.  (Solution:
start xserver in an appropriate order, to be found by experimentation)
Another minor problem - it won't work with every combination of video cards,
only some.
Still - when it works you even get to run accelerated 3D on
the independent heads.  Nice for game parties.

> Can someone please refer me to recent archives on this subject, or 
> update me on this issue if possible.
> 
I hope this helps.

Helge Hafting
