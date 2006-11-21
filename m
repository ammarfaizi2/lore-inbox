Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030709AbWKUECW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030709AbWKUECW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030710AbWKUECW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:02:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:46797 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030709AbWKUECW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:02:22 -0500
Subject: bus_id collisions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 21 Nov 2006 15:02:16 +1100
Message-Id: <1164081736.8207.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg !

It occurs to me (after some trouble I had with custom bus types) that
this comment is incorrect in device.h, in the definition of struct
device :

        char    bus_id[BUS_ID_SIZE];    /* position on parent bus */

As the bus_id needs to be unique for a given bus_type, not only under a
given parent, due to the symlinks in /sys/bus/<bus_type>/.

This has caused me some trouble with of_platform devices, which are
sort-of platform devices but linked to the Open Firmware device-tree, as
I generate their names based on the nodes in the tree which need not be
unique as long as they are unique under a given parent.

I've worked around it, but I though the comment might need to be
clarified.

Also, I don't suppose you have any plan to move away from the bus_id
being a fixed size array inside struct device ? I would very much like
to be able to have larger names ... Among others, in order to handle the
above problem, I tend to include the fully translated 64 bits address of
the device in the name :-) (Hopefully, it's generally smaller and I
don't have leading zero's but still, I have little room left for the
device name which is annoying).

Cheers,
Ben.




