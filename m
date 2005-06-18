Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262125AbVFROie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262125AbVFROie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 10:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVFROie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 10:38:34 -0400
Received: from mailhub.hp.com ([192.151.27.10]:44702 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S262125AbVFROic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 10:38:32 -0400
Message-ID: <42B43226.20703@hp.com>
Date: Sat, 18 Jun 2005 10:39:34 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: recursive call to platform_device_register deadlocks
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We wrote soc_device to handle ASICs that were structured as a number of 
subcomponents, some of which are reused from ASIC to ASIC.  This enables 
the drivers for the subcomponents to be in separate files, loaded as 
modules, and enhances code reuse.  We submitted soc_device, but it was 
pointed out that platform_device probably does what we want.

We've started working on replacing uses of soc_device in handhelds 
drivers by platform_device.   One of the things we ran into is that the 
platform_device driver for an ASIC was calling soc_device_register 
inside its probe function.  If this is converted to 
platform_device_register, then the process deadlocks because 
bus_add_device locks platform_bus_type.

We could restructure the toplevel driver so that it does not call 
platform_device inside its probe function.  An alternative would be to 
add a pointer to a vector of subdevices to platform_device and have it 
register the subdevices after it has probed the toplevel device.  Do you 
have any recommendations?

Thanks,
Jamey Hicks

