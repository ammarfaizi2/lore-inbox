Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUEDP0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUEDP0c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 11:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264442AbUEDP0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 11:26:32 -0400
Received: from digitalimplant.org ([64.62.235.95]:41093 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S264441AbUEDP02
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 11:26:28 -0400
Date: Tue, 4 May 2004 08:26:21 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Todd Poynor <tpoynor@mvista.com>
cc: linux-hotplug-devel@lists.sourceforge.net,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hotplug for device power state changes
In-Reply-To: <20040429202654.GA9971@dhcp193.mvista.com>
Message-ID: <Pine.LNX.4.50.0405040819490.3562-100000@monsoon.he.net>
References: <20040429202654.GA9971@dhcp193.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> A patch to call a hotplug device-power agent when the power state of a
> device is modified at runtime (that is, individually via sysfs or by a
> driver call, not as part of a system suspend/resume).  Allows a power
> management application to be informed of changes in device power needs.
> This can be useful on platforms with dependencies between system
> clock/voltage settings and operation of certain devices (such as
> PXA27x), or, for example, on a cell phone where voiceband or network
> devices going inactive signals an opportunity to lower platform power
> levels to conserve battery life.

Why? If the device is powered down at runtime via sysfs, then the app that
did that already exists in userspace, like the ones you're trying to
notify via /sbin/hotplug. It would be much simpler for the first app to
generate e.g. a d-bus message to notify other apps, rather than creating
this conduit through the kernel.

Besides, if one process has a device open, then the driver should refuse
any requests to power it down.

And, for the case where a communication device loses signal, you should
treat it similarly to a network device, which notifies userspace of a lost
link, which then has the option of powering down the device and notifying
other processes.


	Pat
