Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVBFO3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVBFO3S (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 09:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVBFO3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 09:29:18 -0500
Received: from metis.pengutronix.de ([213.252.143.165]:50610 "EHLO
	metis.pengutronix.de") by vger.kernel.org with ESMTP
	id S261157AbVBFO3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 09:29:15 -0500
Date: Sun, 6 Feb 2005 15:29:12 +0100
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@digitalimplant.org>,
       Marc Kleine-Budde <mkl@pengutronix.de>
Subject: recursively unregistering platform devices
Message-ID: <20050206142912.GE13303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I have a locking problem with platform devices in a little bit unusual
scenario; we have an FPGA which has a device information memory block
for the several "parts" in the FPGA. So we have written a base driver
which registers the device information block with the driver model, then
looks what is in the FPGA, registers the according "devices" with the
driver model and issues hotplug events to load the related drivers. 

The registration works fine, although we call platform_add_devices()
from the base driver for all the "sub devices"; but when we try to
unload the drivers there is a deadlock. On driver exit we call
platform_device_unregister() for the base driver which seems to be run
under a lock which is also being aquired when unregistering the devices
"inside" the FPGA. 

Before I investigate deeper - did anyone see this behaviour before? 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
