Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271211AbTGWStL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271214AbTGWStK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:49:10 -0400
Received: from pop.gmx.de ([213.165.64.20]:61145 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271211AbTGWStC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:49:02 -0400
Date: Thu, 24 Jul 2003 00:33:42 +0530
From: Apurva Mehta <apurva@gmx.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030723190342.GA1288@home.woodlands>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
References: <20030722013443.GA18184@netnation.com> <20030722172858.GB2880@home.woodlands> <1058899713.733.6.camel@teapot.felipe-alfaro.com> <20030722203716.GA1321@home.woodlands> <20030722213326.GB1176@matchmail.com> <20030723081811.GA1324@home.woodlands> <20030723164140.GG1176@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723164140.GG1176@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Mike Fedyk <mfedyk@matchmail.com> [2003-07-23 22:41]:
> On Wed, Jul 23, 2003 at 01:48:11PM +0530, Apurva Mehta wrote:
> > The problems do not end there. Once I start X, I experience
> > random freezes of the system. In one session I could play some music
> > and write some email. It froze just after dialing into the
> > internet. In another session it froze while trying to start xmms.
> 
> please post the output of lspci here.  Also, what version of Xfree86 are you
> running, and read the documentation for the nmi oopser in the kernel
> documentation tree, and turn it on for your system.
> 
> Then we might be able to get a useful message out of your system.

Here is the output of lspci:

------

00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C596 ISA [Mobile South] (rev 23)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 10)
00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 11)
00:04.3 Host bridge: VIA Technologies, Inc. VT82C596 Power Management (rev 30)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV5 [RIVA TNT2/TNT2 Pro] (rev 15)

------

I enabled the nmi watchdog by appending nmi_watchdog=1 to my kernel
boot parameters. I verified that it was enabled by doing a `cat
/proc/interrupts`. The NMI value was 30.

Still, there are no special messages in /var/log/messages or in any
XFree86 log nor in any boot log.. 

May be the nmi watchdog is not working because it is not a normal
'freeze' per se. What happens is that my mouse still moves around the
screen, I can also type (*only* type) commands into an xterm. But
those commands cannot be executed. When I try to execute a command,
nothing happens, I do not even get the prompt back. If I try to login
to a virtual console, I can type my login name, but then the password
prompt does not come up. When I try to switch back to X, I cannot do
so and I get stuck at that blank screen. Then I am force to do a cold
reboot.

Sometime during the subsequent boot process, I get that error
message while trying to load a random startup program. Last time, it
was while trying to load xfs.

Also, I have found that there is no pattern to the sequence of
operations that lead up to these freezes. I mentioned that if I
executed some programs on a virtual console before starting X, then X
would load fine, otherwise it would not. This is not true all the
time.

	- Apurva
