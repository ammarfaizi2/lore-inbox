Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVCIQQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVCIQQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbVCIQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:16:39 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:41490 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261639AbVCIQQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 11:16:27 -0500
Date: Wed, 9 Mar 2005 16:16:22 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Kilau, Scott" <Scott_Kilau@digi.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [ patch 4/7] drivers/serial/jsm: new serial device driver
Message-ID: <20050309161622.G25398@flint.arm.linux.org.uk>
Mail-Followup-To: "Kilau, Scott" <Scott_Kilau@digi.com>,
	linux-kernel@vger.kernel.org, greg@kroah.com,
	Wen Xiong <wenxiong@us.ibm.com>
References: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E2@minimail.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <71A17D6448EC0140B44BCEB8CD0DA36E04B9D9E2@minimail.digi.com>; from Scott_Kilau@digi.com on Tue, Mar 08, 2005 at 03:47:45PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2005 at 03:47:45PM -0600, Kilau, Scott wrote:
> For example, lets say a customer has a modem connected to a serial port.
> 
> If you were to open up the port with an "stty -a" to get the current 
> settings and signals, you would unintentionally raise RTS and DTR.

That isn't special to this driver though.  Maybe it should be fixed for
all serial drivers, since the situation you mention above is not limited
to just this driver.

As you say, you may have a modem connected, which may have been configured
to automatically dial a predetermined number when DTR is raised.

Maybe we need a solution which applies to all drivers?

> This is why we export the various signals/stats/signals to sysfs (used
> to be proc), so our management tools can get the information about the
> serial port without being intrusive by opening up the port.

Note that exporting statistics can be a security bug, especially if that
includes the number of bytes sent/received.  For an explaination of this,
please lookup the reason why the /proc/tty/driver directory was made
unreadable to userspace.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
