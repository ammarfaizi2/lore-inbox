Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTDHQ1g (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 12:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbTDHQ1g (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 12:27:36 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:57350 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261373AbTDHQ1b (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 12:27:31 -0400
Date: Tue, 8 Apr 2003 20:38:24 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030408203824.A27019@jurassic.park.msu.ru>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Tue, Apr 08, 2003 at 12:44:11AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 12:44:11AM +0100, Matthew Wilcox wrote:
>  - Add segment to pci_bus.
>  - Change the sysfs name of each device to include a 16-bit segment ID.

First of all, the "segment" name is extremely misleading. PCI spec
assumes everywhere that "segment" is a group of devices sitting
on the same wires (ie primary and secondary buses of the PCI-to-PCI
bridge are *different* segments).
Let's call it "configuration space domain" instead.

Second, why not

-	strcpy(dev->dev.bus_id,dev->slot_name);
+	sprintf(dev->dev.bus_id, "%04x:%s", pci_controller_num(dev),
+		dev->slot_name);

?

Ivan.
