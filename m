Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264980AbUD2VnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264980AbUD2VnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264874AbUD2VnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 17:43:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54539 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264980AbUD2Vms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 17:42:48 -0400
Date: Thu, 29 Apr 2004 22:42:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Todd Poynor <tpoynor@mvista.com>
Cc: mochel@digitalimplant.org, linux-hotplug-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hotplug for device power state changes
Message-ID: <20040429224243.L16407@flint.arm.linux.org.uk>
Mail-Followup-To: Todd Poynor <tpoynor@mvista.com>,
	mochel@digitalimplant.org,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20040429202654.GA9971@dhcp193.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040429202654.GA9971@dhcp193.mvista.com>; from tpoynor@mvista.com on Thu, Apr 29, 2004 at 01:26:54PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:26:54PM -0700, Todd Poynor wrote:
> A patch to call a hotplug device-power agent when the power state of a
> device is modified at runtime (that is, individually via sysfs or by a
> driver call, not as part of a system suspend/resume).  Allows a power
> management application to be informed of changes in device power needs.
> This can be useful on platforms with dependencies between system
> clock/voltage settings and operation of certain devices (such as
> PXA27x), or, for example, on a cell phone where voiceband or network
> devices going inactive signals an opportunity to lower platform power
> levels to conserve battery life.

Note that we should run this synchronously with userspace - ie, wait
for the userspace hotplug script to finish executing before moving
on to the next device.  Why?

Think of the case where we're suspending the complete system.  If you
go round and asynchonously try to run userspace scripts, chances are
you'll have the CPU asleep before _any_ of the scripts have run, which
means (eg) your DHCP client couldn't tell the server that its released
its allocation.

Also, should we be telling userspace about suspend before we actually
suspend the device?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
