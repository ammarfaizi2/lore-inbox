Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVARO4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVARO4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVARO4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:56:54 -0500
Received: from ns.suse.de ([195.135.220.2]:17307 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261317AbVARO4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:56:37 -0500
Message-ID: <41ED23A3.5020404@suse.de>
Date: Tue, 18 Jan 2005 15:56:35 +0100
From: Hannes Reinecke <hare@suse.de>
Organization: SuSE Linux AG
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Vojtech Pawlik <vojtech@suse.cz>
Subject: [PATCH 0/2] Remove input_call_hotplug
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the input subsystem is using call_usermodehelper directly, which breaks 
all sorts of assertions especially when using udev.
And it's definitely going to fail once someone is trying to use netlink 
messages for hotplug event delivery.

To remedy this I've implemented a new sysfs class 'input_device' which 
is a representation of 'struct input_dev'. So each device listed in 
'/proc/bus/input/devices' gets a class device associated with it.
And we'll get proper hotplug events for each input_device which can be 
handled by udev accordingly.

Drawback is that a new event type (the said 'input_device') is added, so 
that hotplug scripts and udev might need to be adapted to handle it 
properly. And each device driver needs to be touched to write something 
meaningful as the class_id. A fallback is provided, but by neccessity is 
not very informative.

Patch 1/2 implements the core changes to drivers/input/input.c
Patch 2/2 provides proper device names for input drivers.

Patches are relative to bk://kernel.bkbits.net/vojtech/input

Comments are welcome.
Please CC me directly as I'm not on this list.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke			hare@suse.de
SuSE Linux AG				S390 & zSeries
Maxfeldstraße 5				+49 911 74053 688
90409 Nürnberg				http://www.suse.de
