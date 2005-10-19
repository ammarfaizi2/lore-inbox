Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbVJSUZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbVJSUZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbVJSUZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:25:11 -0400
Received: from p54B0599B.dip.t-dialin.net ([84.176.89.155]:2789 "EHLO
	ccc-offenbach.org") by vger.kernel.org with ESMTP id S1751301AbVJSUZJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:25:09 -0400
Date: Wed, 19 Oct 2005 22:24:58 +0200
From: Rudolf Polzer <debian-ne@durchnull.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for local root compromise
Message-ID: <20051019202458.GA51688%atfield-dt@durchnull.de>
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au> <m37jcakhsm.fsf@defiant.localdomain> <20051018171645.GA59028%atfield-dt@durchnull.de> <m3fyqyhdm8.fsf@defiant.localdomain> <20051018204919.GA21286%atfield-dt@durchnull.de> <m3oe5l21rr.fsf@defiant.localdomain> <20051019132326.GA31526%atfield-dt@durchnull.de> <m3y84pjo9m.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <m3y84pjo9m.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsis, quam aut quem »Krzysztof Halasa« appellare soleo:
> Rudolf Polzer <debian-ne@durchnull.de> writes:
> 
> >> Ok. So they are exposed to known attacks with quite high probability.
> >
> > Which others? Are there other places that assume only trusted users can
> > access
> > the console?
> 
> Probably: BIOS booting,

Locked. And these boards don't even have the wide-spread "boot from USB even if
system boot up sequence states otherwise" bug. Probably just because they do
not support booting from USB, though.

> messing with computer cases (are the computers in locked room and only
> kbds/monitors/mouses are accessible?),

Not locked, but that would be an option - others would notice it if you did
anything weird, however.

> sniffing keyboard cables (all other passwords if not root's),

That's the only thing that might actually work - an inductive device wrapped
around the keyboard cable. But I've never seen those available ready to buy.

> physical damage to the computer hardware (some kind of DoS).

Not interesting. Well, once someone stole a mouse. A dirty old PS/2 mouse with
a ball. Who would steal such a mouse?

> Still, may be adequate for student room.

Right, especially since people would not mess with the hardware. If there are
20 students in a room, would you really do something strange? For example,
nobody even tries to watch porn in these rooms.

> >> I assume that one can notice that Ctrl-Alt-Backspace doesn't work,
> >> and stop there.
> >
> > Not if a malicious X program does "chvt 1; chvt 7" when Ctrl-Alt-Backspace is
> > pressed.
> 
> With correct timing, possibly. Depends on how the graphics driver starts
> and switches from text mode. There might be noticeable differences.

There might be a difference, yes - but there's also a difference in timing if
the system has background load. So nothing to rely upon. Plus we have CRTs that
just get black for some time with some clicking noise - and these CRTs need
quite a long time to start showing a picture after changing the video mode.

> > It would require a video driver that can actually reset the video mode.
> > Framebuffer drivers usually can do that. For the standard VGA text mode, at
> > least savetextmode/restoretextmode from svgalib don't work on the graphics
> > cards I have.
> 
> I think Xserver could terminate gracefully. But it would require changes
> to kernel SAK handling I think - not sure if it's worth it, given other
> threats.
> 
> Another idea: if the machines are ACPI-enabled and have "soft-power"
> buttons, one can make use of acpid.

Yes, good idea, but we already are using it for soft reboot. If people start
using the idea of remapping backspace so others can't kill their screen saver
(and then keep logged on idle for days - a quite typical "DoS" here), the power
button will most probably be remapped from "shutdown -r now" to
"/etc/init.d/kdm restart". We usually don't want to kill some professor's pine
(ugh, they want us to install it) in that case, but rebooting would do that
too.
