Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269590AbUISEqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269590AbUISEqr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 00:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269596AbUISEqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 00:46:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:33719 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269590AbUISEqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 00:46:24 -0400
Subject: Re: Design for setting video modes, ownership of sysfs attributes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091811431fb44254@mail.gmail.com>
References: <9e47339104091811431fb44254@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1095569137.6580.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 19 Sep 2004 14:45:37 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-19 at 04:43, Jon Smirl wrote:
> Original proposal.....
> At OLS we talked about a system like this for setting video modes:
> 
> 1) user owns graphics devices
> 2) user sets mode with string (or similar) format using ioctl common to
> all drivers.
> 3) driver is locked to prevent multiple mode sets
> 4) common code takes this string and does a hotplug event with it.
> 5) hotplug event runs root context in user space 
> 6) mode is decoded and verified, this may involve a little process that
> maintains the DDC database and reads a file of legal modes. Other
> schemes are possible.
> 7a) mode is set using VBIOS and vm86, signal driver mode is set
> 7b) the register values needed to set the mode are passed into a root
> priv ioctl.
> 8) driver is unlocked.

One issue here... When we discussed all of this with Keith, we wanted
a mecanism where the user can set the mode without "owning" the device.

Typically, with X: We don't want X itself to have to be the one setting
the mode, but rather set the mode and have X be notified properly before
and after it happens so it can "catch up".

This also involves dealing with all pending DRI clients too, that is they
have to be notified that the fb/vmem layout is changing, the pending
commands have to be completed, no more accepted, etc... until every DRI
"client" acked the change... That sort of thing.

Ben.


