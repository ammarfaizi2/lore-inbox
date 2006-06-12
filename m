Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWFLS03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWFLS03 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWFLS03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:26:29 -0400
Received: from mga03.intel.com ([143.182.124.21]:10128 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751220AbWFLS02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:26:28 -0400
X-IronPort-AV: i="4.05,229,1146466800"; 
   d="scan'208"; a="49830553:sNHT3348813314"
Subject: Re: acpi dock test-drive
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060610024540.GA7681@hermes.uziel.local>
References: <20060609144326.GA6093@hermes.uziel.local>
	 <1149871538.4542.7.camel@whizzy> <20060610024540.GA7681@hermes.uziel.local>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jun 2006 11:37:16 -0700
Message-Id: <1150137437.8064.4.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
X-OriginalArrivalTime: 12 Jun 2006 18:24:45.0361 (UTC) FILETIME=[7AFC2A10:01C68E4D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-06-10 at 04:45 +0200, Christian Trefzer wrote:
> Hi Kristen,
> 
> On Fri, Jun 09, 2006 at 09:45:38AM -0700, Kristen Accardi wrote:
> > What you are describing sounds like the bug I just fixed :).  Can you
> > please try 2.6.17-rc6-mm1 to see if this works any better?  I believe it
> > should resolve both the oops and the fact that your devices behind the
> > pci bridge are not found.  Thanks very much for continuing to test the
> > patches.
> 
> after adding acpi-dock-driver-acpi_get_device_fix.patch the Oops is
> truly gone, although the current behaviour seems dangerous to me. AFAIR
> the undock button causes the disk to spin down and the backlight to be
> turned off e.g. when the boot manager is displayed and power management
> controlled entirely by the bios. What I got now was an endless loop that
> caused everything including sysrq keys to be all but interactive, but
> what bothers me more is the rythmic noise from the hard disk. It sounds
> as if it was attempting a spin-down, barely audible, and only for a
> fraction of a second. This happens about 1.5 times per second, and if
> this is what I guess it is, it won't prolong the disk's life : /
> 

Can you tell me if this happens when you boot up outside your dock
station, and then dock/undock, or if it only happens when you boot
inside the dock station and then attempt to undock?

> Devices behind the PCI bridge are not yet discovered as well. Guess I'd
> have to build a debug kernel some time soon. Dmesg dumps will have to
> wait until "tomorrow", it's 4:45am and I feel like a dead piece of meat.

When you do get to this, please load acpiphp as a module with the
debug=1 option and send me the output.  Do the following:

1.  boot outside dock station
2.  load acpiphp
3.  attempt to dock - capture output of dmesg plus lspci -vv
4.  reboot inside dock station
5.  capture lspci -vv

Maybe we can focus on getting docking working right first, and then try
to figure out what's going on with undocking.

Thanks,
Kristen

> 
> Thanks for your work!
> 
> Chris
