Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVAWApr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVAWApr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 19:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVAWApr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 19:45:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:28837 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261169AbVAWApg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 19:45:36 -0500
Subject: Re: BUG: 2.6.11-rc2 and -rc1 hang during boot on PowerMacs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
References: <200501221723.j0MHN6eD000684@harpo.it.uu.se>
Content-Type: text/plain
Date: Sun, 23 Jan 2005 11:43:56 +1100
Message-Id: <1106441036.5387.41.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-01-22 at 18:23 +0100, Mikael Pettersson wrote:
> Kernels 2.6.11-rc2 and -rc1 hang during boot on my Beige PowerMac G3.
> The last kernel message on the console is:
> 
> adb: starting probe task...
> 
> At this point the kernel hangs and doesn't respond to any attempt
> to invoke SYSRQ or XMON. Normally the subsequent messages would be:
> 
> adb devices: [2]: 2 5 [3]: 3 1
> ADB keyboard at 2, handler set to 3
> Detected ADB keyboard, type ISO, swapping keys.
> input: ADB keyboard on adb2:2.05/input
> ADB HID on ID 3 not yet registered
> ADB mouse at 3, handler set to 2
> input: ADB mouse on adb3:3.01/input
> adb: finished probe task...
> 
> The 2.6.11-rc1 kernel also hung on an eMac (G4). On that machine it
> appears the hang occurred in radeonfb: the screen flickers off/on
> during radeonfb initialisation, but with 2.6.11-rc1 the screen just
> went black. Afterwards the eMac did not respond to any keyboard or
> network activity, so I have to assume it hung hard.
> 
> I've traced the cause of the hangs to a local_irq_disable() added to
> init/main.c:rest_init() in 2.6.10-bk12. Removing it eliminates the
> hangs on both the G3 and the eMac:

I know about this problem, I'm working on a proper fix. Thanks for your
report.

Ben.


