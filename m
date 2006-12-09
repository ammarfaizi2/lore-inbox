Return-Path: <linux-kernel-owner+w=401wt.eu-S1758361AbWLIMA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361AbWLIMA0 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 07:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760731AbWLIMA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 07:00:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:50203 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758361AbWLIMAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 07:00:25 -0500
Date: Sat, 9 Dec 2006 12:59:58 +0100
From: Holger Macht <hmacht@suse.de>
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Message-ID: <20061209115957.GA5254@homac2>
Mail-Followup-To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
	len.brown@intel.com, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>
References: <20061204224037.713257809@localhost.localdomain> <20061204144958.207e58e2.kristen.c.accardi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204144958.207e58e2.kristen.c.accardi@intel.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04. Dec - 14:49:58, Kristen Carlson Accardi wrote:
> From: brandon@ifup.org
> 
> Add 2 sysfs files for user interface.
> 1) docked - 1/0 (read only) - indicates whether the software believes the 
> laptop is docked in a docking station.
> 2) undock - (write only) - writing to this file causes the software to
> initiate an undock request to the firmware. 

Thanks for doin this!

However, the function dock_event(...) still contains this comment:

	/*
	 * we don't do events until someone tells me that
	 * they would like to have them.
	 */

Well, I like to have them ;-)

The sysfs exports are more or less useless without events. When the dock
driver is loaded, you get a platform device below /sys. But you never know
if there will ever be a docking station connected to your
system. Userspace caring about this will have to poll the 'docked' file,
which is obviously bad.

Thanks,
	Holger
