Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbTIPRPt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 13:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbTIPRO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 13:14:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:40933 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262004AbTIPROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 13:14:17 -0400
Date: Sun, 14 Sep 2003 12:08:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nicolae Mihalache <mache@abcpages.com>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@osdl.org>
Subject: Re: 2.6-test4 problems: suspend and touchpad
Message-ID: <20030914100828.GB7357@openzaurus.ucw.cz>
References: <Pine.LNX.4.33.0309121519420.984-100000@localhost.localdomain> <3F637245.9070009@abcpages.com> <3F638E18.9080406@abcpages.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F638E18.9080406@abcpages.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>> 2. suspend/resume. With version 2.6test2+acpi patch both swsusp 
> and
> >>> "echo 3 >/proc/acpi/sleep" worked, being able to somehow
> >>> successfully resume. In version 2.6test4 there is no
> >>> /proc/acpi/sleep and swsusp hangs somwhere during an IDE call (I 
> can
> >>> hand-copy the trace if needed).
> >>>
> >>
> >>
> >> Would you please try the latest -mm patch (2.6.0-test5-mm1, I
> >> believe) and report your findings?
> >>
> >
> > Well, the 2.6.0-test5-mm1 does not compile on my system (SuSE 8.2, 
> gcc
> > version 3.3 20030226 (prerelease) ):
> 
> Ok, I solved the compilation problems and with this kernel swsusp 
> does not hang anymore.
> The resume works however the network adapter (Broadcom 4400) does not 
> even when restarting the network.
> ifconfig eth0 shows very big counters:
> eth0      Link encap:Ethernet  HWaddr 00:C0:9F:26:C7:15
>          UP BROADCAST NOTRAILERS RUNNING MULTICAST  MTU:1500  Metric:1
>          RX packets:819 errors:4294966560 dropped:0 overruns:0 
> frame:4294966836
>          TX packets:865 errors:4294966836 dropped:0 overruns:0 
> carrier:4294967118
>          collisions:4294967204 txqueuelen:100
>          RX bytes:956732 (934.3 Kb)  TX bytes:89228 (87.1 Kb)
>          Interrupt:5
> 
> 
> Any ideas? Maybe the driver for this network card does not 
> (correctly) implement suspend/resume ?

Pretty probable. Look at the driver sources, and if there's no _suspend method, write one.
If you ifconfig down before suspend, does it help?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

