Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272228AbTG3TlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272234AbTG3TlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:41:14 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:54858 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S272228AbTG3TlI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:41:08 -0400
Date: Wed, 30 Jul 2003 22:40:52 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watchdog documentation
Message-ID: <20030730194052.GS83336@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Mikael Pettersson <mikpe@csd.uu.se>, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <200307301920.h6UJKXwC020610@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307301920.h6UJKXwC020610@harpo.it.uu.se>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 30, 2003 at 09:20:33PM +0200, you [Mikael Pettersson] wrote:
> On Tue, 29 Jul 2003 20:53:19 +0300, Ville Herva wrote:
> >On Tue, Jul 29, 2003 at 06:06:30PM +0200, you [Andi Kleen] wrote:
> >> > Andi, you have the numbers mixed up. mode 1 is I/O-APIC, mode 2 is local APIC,
> >> > and x86-64 defaults nmi_watchdog to I/O-APIC mode.
> >> > Now, is it the I/O-APIC or local APIC watchdog that doesn't work in x86-64?
> >> 
> >> Right, 1 and 2 need to be exchanged. Anyways local apic mode does not seem
> >> to work, the kernel always reportss "NMI stuck" at bootup.
> >> IO APIC mode for is default.
> ...
> >+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
> >+always enabled with perfctr mode. Currently, mode=1 does not work on x86-64.
> 
> Didn't Andi just say it's the other way around? nmi_watchdog=1 (I/O-APIC)
> by default since nmi_watchdog=2 (local APIC) doesn't work.

Ok, you got me confused (thankfully I didn't submit anything for inclusion
yet. :)

Initially, Andi said:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105941508314399&w=2
> x86-64 is the same, except APIC is always compiled in and the nmi watchdog
> is always enabled with perfctr mode. mode=2 seems to also not work
> correctly currently.
>
> However one caveat (even for i386): when you use perfctr mode 1 you lose
> the first performance register which you may need for other things.

To which I replied:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105942026020567&w=2
> So, is something like the following ok by you
>
> +For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
> +always enabled with perfctr mode. Currently, mode=2 does not work on x86-64.
> +
> +Using NMI watchdog (in mode=1) needs the first performance register, so you
> +can't use it for other purposes (such as high precision performance
> +profiling.)

But you pointed out it was the other way around:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105947532631384&w=2
> Andi, you have the numbers mixed up. mode 1 is I/O-APIC, mode 2 is local
> APIC, and x86-64 defaults nmi_watchdog to I/O-APIC mode. Now, is it the
> I/O-APIC or local APIC watchdog that doesn't work in x86-64?

And Andi agreed:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105949540722325&w=2
> Right, 1 and 2 need to be exchanged. Anyways local apic mode does not seem
> to work, the kernel always reportss "NMI stuck" at bootup. IO APIC mode
> for is default.

So I proposed (blindly exchanging the numbers):
http://marc.theaimsgroup.com/?l=linux-kernel&m=105950174531125&w=2
> +For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
> +always enabled with perfctr mode. Currently, mode=1 does not work on x86-64.
> +
> +Using NMI watchdog (in mode=2) needs the first performance register, so you
> +can't use it for other purposes (such as high precision performance
> +profiling.)

So... Should it be something like:

+For x86-64, the needed APIC is always compiled in, and the NMI watchdog is
+always enabled with perctr mode. Currently, mode=2 (local APIC) does not
+work on x86-64. IO APIC mode (mode=1) is the default. Using NMI watchdog
+(mode=1) needs the first performance register, so you can't use it for
+other purposes (such as high precision performance profiling.)

(Is the last sentence only valid for x86-64?)


-- v --

v@iki.fi
