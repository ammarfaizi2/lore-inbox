Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316243AbSFEU1r>; Wed, 5 Jun 2002 16:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316408AbSFEU1r>; Wed, 5 Jun 2002 16:27:47 -0400
Received: from www.microgate.com ([216.30.46.105]:30733 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S316243AbSFEU1p>; Wed, 5 Jun 2002 16:27:45 -0400
Subject: Problem with new driver model?
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 05 Jun 2002 15:25:08 -0500
Message-Id: <1023308709.791.8.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When testing the drivers I maintain on 2.5.20, I hit the
BUG_ON in include/linux/devices.txt:115.

This is in get_driver() which is called in a chain from:
driver_for_each_dev()
driver_unbind()
do_driver_unbind()
free_module()
sys_delete_module()

This occurs when unloading the modules (rmmod).
This was not the case on 2.5.14 (the last kernel I tested).

The machine is an SMP dual PentiumII-400.

A reading of Documentation/driver-model.txt indicates that
changes were made to the global driver model that should not require
changes to individual device specific drivers.

Is the documentation correct and this is a bug with the
new driver model code, or are there changes required for
all the device specific drivers.

Thanks,

Paul Fulghum
paulkf@microgate.com






