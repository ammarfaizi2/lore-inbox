Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTEESOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbTEESOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 14:14:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43403 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261196AbTEESOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 14:14:14 -0400
Date: Mon, 5 May 2003 11:26:48 -0700
From: Greg KH <greg@kroah.com>
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: CaT <cat@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk7: Where oh where have my sensors gone? (i2c)
Message-ID: <20030505182648.GA1826@kroah.com>
References: <20030427115644.GA492@zip.com.au> <20030428205522.GA26160@kroah.com> <20030505083458.GA621@zip.com.au> <20030505165848.GA1249@kroah.com> <3EB6AA01.30601@wmich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB6AA01.30601@wmich.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 05, 2003 at 02:14:25PM -0400, Ed Sweetman wrote:
> hey guys.  Notice a missing proc driver? hint: i2c.    That's why 
> sensors wont work even when you load the modules. At least that's what i 
> can tell from what the lm_sensors page mentions and what not.

Huh?
The i2c code now interacts to userspace through sysfs, not /proc
anymore.  CaT is properly looking for his sensors in sysfs.

Here's what happens when looking through sysfs on my box running 2.5.69:

# find /sys/ | grep -i i2c
/sys/bus/i2c
/sys/bus/i2c/drivers
/sys/bus/i2c/drivers/lm75
/sys/bus/i2c/drivers/lm75/0-0048
/sys/bus/i2c/devices
/sys/bus/i2c/devices/0-0048
/sys/devices/pci0/00:1f.3/i2c-0
/sys/devices/pci0/00:1f.3/i2c-0/0-0048
/sys/devices/pci0/00:1f.3/i2c-0/0-0048/temp_input
/sys/devices/pci0/00:1f.3/i2c-0/0-0048/temp_min
/sys/devices/pci0/00:1f.3/i2c-0/0-0048/temp_max
/sys/devices/pci0/00:1f.3/i2c-0/0-0048/power
/sys/devices/pci0/00:1f.3/i2c-0/0-0048/name
/sys/devices/pci0/00:1f.3/i2c-0/power
/sys/devices/pci0/00:1f.3/i2c-0/name

Which is what should be showing up on CaT's machine (of the lm75 device
is on his hardware.)

Hope this helps,

greg k-h
