Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274704AbRITX02>; Thu, 20 Sep 2001 19:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274696AbRITX0S>; Thu, 20 Sep 2001 19:26:18 -0400
Received: from hermes.toad.net ([162.33.130.251]:63905 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S274717AbRITX0E>;
	Thu, 20 Sep 2001 19:26:04 -0400
Message-ID: <3BAA7AFC.49CEFB5D@yahoo.co.uk>
Date: Thu, 20 Sep 2001 19:25:48 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Problem: PnP BIOS driver reports outdated information
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PnP BIOS interface driver builds a device list, including
resource information for each device, at init time.  Other
drivers search this list using pnpbios_find_device().

The problem is that the information in the device list may
be out of date if setpnp has been used.

Perhaps it will be said that setpnp is a "debugging tool" and
ordinarily one shouldn't change resource assignments, but
setpnp is useful for more than debugging.  E.g., with current
kernels it is necessary for me to run setpnp during the boot
sequence in order to set up certain devices properly.  
Sometimes, also, there aren't enough IRQs to go around, and
one may use setpnp to disable and enable different devices.

Thus I think that the PnP BIOS driver needs to be fixed so
that it will use and report the correct (current) resource
values.  Looking at the code, I see no reason why there
needs to be a device list at all.  Functions such as
pnpbios_find_device() could just as well scan through 
device info returned (fresh) by the PnP BIOS.  I don't 
think speed is a big issue here.  Are there other reasons
for maintaining a device list in the driver?

--
Thomas Hood
jdthood_AT_yahoo.co.uk
