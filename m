Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUEEETh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUEEETh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 00:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbUEEETh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 00:19:37 -0400
Received: from digitalimplant.org ([64.62.235.95]:22943 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261914AbUEEETb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 00:19:31 -0400
Date: Tue, 4 May 2004 21:19:20 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Todd Poynor <tpoynor@mvista.com>
cc: linux-hotplug-devel@lists.sourceforge.net,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hotplug for device power state changes
In-Reply-To: <4097FED8.3020003@mvista.com>
Message-ID: <Pine.LNX.4.50.0405042110440.30304-100000@monsoon.he.net>
References: <20040429202654.GA9971@dhcp193.mvista.com>
 <Pine.LNX.4.50.0405040819490.3562-100000@monsoon.he.net> <4097FED8.3020003@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The ability to do this was originally requested in the context of a
> driver managing the power state of its devices (according to some
> unspecified logic); agreed that state changes requested via sysfs are a
> less compelling usage scenario.  Small battery-powered gadgets often
> implement drivers that are more actively involved in managing power
> state than the desktop/notebook/server norm, invoking LDM suspend
> routines when an opportunity to power down arises.  But it is also
> common in wall-plug-wired systems to have a few power state transitions
> that result from things under kernel control, such as blanking a display
> device after a timer expires.

It seems like it would best be done at the class level, rather than the
core driver level, if you wanted to do it all. For things like
communication devices going out of range, you would probably want to
easily support multiple drivers of the same type, so you might as well
abstract it to the class. And, I don't see a reason for it to be
synchronous, since any apps trying to communicate over it will soon
realize it's not available; and any policy in userspace shouldn't by
definition be that critical to the health of the system.

Display blanking is based on user input inactivity, and already works on
most systems.


	Pat
