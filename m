Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWBUAzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWBUAzp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 19:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161246AbWBUAzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 19:55:45 -0500
Received: from digitalimplant.org ([64.62.235.95]:6846 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S1161244AbWBUAzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 19:55:44 -0500
Date: Mon, 20 Feb 2006 16:55:34 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: greg@kroah.com, "" <akpm@osdl.org>, "" <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, "" <linux-pm@osdl.org>
Subject: [PATCH 0/4] Fix runtime device suspend/resumre interface
Message-ID: <Pine.LNX.4.50.0602201641380.21145-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

Here is an updated version of the patches to fix the sysfs interface for
runtime device power management by restoring the file to its originally
designed behavior - to place devices in the power state specified by the
user process writing to the file.

Recently, the interface was changed to filter out values to prevent a
BUG() that was introduced in the PCI power management code. While a valid
fix, it makes the driver core filter values that might otherwise be used
by the bus/device drivers. This behavior enforces a hard-coded,
non-configurable policy in the driver core, and prevents any other power
state besides "on" and "off" from being used.

These patches implement a solution to that problem by introducing a
"state" field to the pm_message_t structure, which is passed to the bus
drivers for each suspend request. The sysfs interface is modified to
forward the value written to the file in the .state field. The bus and
device drivers can use that field as guidance for which power state to
enter.

While not the only solution to the problem, this solution should restore
the desired functionality to the per-device "state" file with the least
amount of impact.

Thanks,


	Pat
