Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWBRCDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWBRCDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 21:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750706AbWBRCDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 21:03:36 -0500
Received: from digitalimplant.org ([64.62.235.95]:59331 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1750701AbWBRCDf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 21:03:35 -0500
Date: Fri, 17 Feb 2006 18:03:26 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <torvalds@osdl.org>, "" <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 0/5] Fix device suspend/resume
Message-ID: <Pine.LNX.4.50.0602171745410.30811-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

Following is a small series of patches to fix up the changes recently made
to the runtime suspend/resume functionality.

The sysfs interface was changed so that it dropped the actual state that
the device was requested to enter. These patches add a state field to
pm_message_t, so that the bus and device drivers can the use value written
to the sysfs file to choose the proper state to enter.

pci_choose_state() is fixed up to check for a non-zero value when the
request is for a PM_EVENT_SUSPEND message and return the appropriate D
state. This allows D1 and D2 to be used once again (though there are few
drivers that currently support it). The BUG() is also converted to a more
friendly WARN_ON(1) when an invalid state is entered.

Finally, the device suspend/resume code is now liberated from an
unconditional deadlock when SMP is enabled.

Please apply. Thanks,


	Pat

