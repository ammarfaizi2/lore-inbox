Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263043AbVCDU4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263043AbVCDU4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 15:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVCDUwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 15:52:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:36339 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263043AbVCDUvR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:51:17 -0500
Message-ID: <4228CA2F.2030508@mvista.com>
Date: Fri, 04 Mar 2005 12:50:55 -0800
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com
CC: David Brownell <david-b@pacbell.net>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>, linux-pm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] Custom power states for non-ACPI systems
References: <20050302020306.GA5724@slurryseal.ddns.mvista.com>	 <20050302085619.GA1364@elf.ucw.cz> <200503031817.06993.david-b@pacbell.net> <1109911788.3772.228.camel@desktop.cunningham.myip.net.au>
In-Reply-To: <1109911788.3772.228.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:
...
> Two way communication between a userspace policy manager and kernel
> drivers is implemented via DBus.
> 
> In this scheme, 'kernel drivers' doesn't just refer to the drivers for
> hardware. It refers to anything remotely power management related,
> including code to implement suspend-to-RAM, to disk or the like, ACPI
> drivers or code to implement system power states.
> 
> The policy manager can enumerate devices and inter-relationships,
> capabilities, settings and status information, set and query policies
> and implementation results. The drivers can notify events. This
> communication doesn't use complicated structures or type definitions.
> Rather, all the nous regarding interpretation of the messages that are
> sent is in the policy manager and the drivers. One driver might say it's
> capable of states called "D0, D1 and D3", another (system) states called
> "Deep Sleep" and "Big Sleep". Nothing but the driver itself and
> userspace manager need to how to interpret & use these states.
> 
> Inter-relationships between drivers are _not_ included in this
> information. The policy manager sets policy, the drivers deal with the
> specifics of implementing it.

This all sounds exactly like the way we're headed as well, so I'm 
definitely interested in anything I can do to help.  Was thinking that 
can start defining kobject_uevent power events and attributes (with 
enough detail that acpid could use it instead of /proc if the ACPI 
drivers were to convert to it).

Capturing the relationships between drivers is difficult.  If nobody's 
already looking into this then I'll take this up soon.

> The userspace manager can in turn [en|dis]able capabilites and send a
> list of run-time states that the driver can move between according to
> its own logic (eg lack of active children) without notifying the
> userspace manager. This would fit in with your power modes above, even
> to the level of "cpu idle".

At dynamicpower.sf.net we do something similar for cpufreq-style scaling 
of platform clocks and voltages, setting up desired policy for various 
platform clocks/voltages according to changes in low-level system state 
(primarily scheduler state) from userspace and then letting the state 
machine run without interaction.  Similar policy objects for devices 
sounds intriguing, although the device-specific nature of event triggers 
probably makes this quite difficult.

Mac OS X support for some of these concepts is documented at 
developer.apple.com, looking for ideas to steal...  Thanks,


-- 
Todd
