Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261561AbVC3F61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVC3F61 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 00:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVC3F61
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 00:58:27 -0500
Received: from digitalimplant.org ([64.62.235.95]:28311 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261561AbVC3F5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 00:57:55 -0500
Date: Tue, 29 Mar 2005 21:57:43 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Adam Belay <abelay@novell.com>
cc: Greg KH <greg@kroah.com>, "" <linux-kernel@vger.kernel.org>,
       "" <linux-pm@lists.osdl.org>
Subject: Re: [RFC] Driver States
In-Reply-To: <1111963367.3503.152.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
References: <1111963367.3503.152.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 27 Mar 2005, Adam Belay wrote:

> Dynamic power management may require devices and drivers to transition
> between various physical and logical states.  I would like to start a
> discussion on how these might be defined at the bus, driver, and class
> levels.

<snip>

> Bus Level
> =========
> At the bus level, there are two state attributes, power and
> enable/disable.  Enable/disable may mean different things on different
> buses, but they generally refer to resource decoding.  A device can only
> be enabled during a non-off power state.

<...>

> Driver Level
> ============
> At the driver level there are two areas of interest, physical and
> logical state.  There is an additional concern of transitioning between
> these states multiple times.  Because a driver acts as a bridge between
> physical and logical components, I think separating these steps seems
> natural.

<...>

> *attach - allocates data structures, creates sysfs entries, prepares driver
>        to handle the hardware.
>
> *start -  Sets up device resources and configures the hardware.  Loads
> firmware, etc.
> (physical)
>
> *open -   engages the hardware, and makes it usable by the class device.
> (logical and physical)
>
> *close -  disengages the hardware, and stops class level access
> (logical and physical)
>
> *stop -   physically disables the hardware
> (physical)
>
> *detach - tears down the driver and releases it from the "struct device"
>

You have a few things here that can easily conflict, and that will be
developed at different paces. I like the direction that it's going, but
how do you intend to do it gradually. I.e. what to do first?


	Pat

