Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVAaO5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVAaO5d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 09:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVAaO5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 09:57:33 -0500
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:6676 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S261226AbVAaO53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 09:57:29 -0500
X-SBRSScore: None
X-IronPort-AV: i="3.88,167,1102287600"; 
   d="scan'208"; a="3863770:sNHT100830492"
Message-ID: <41FE4745.4020003@fujitsu-siemens.com>
Date: Mon, 31 Jan 2005 15:57:09 +0100
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: SIOCGIFMAP silently broken?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we are using a server management software that uses the irq information
returned by the SIOCGIFMAP ioctl to correlate network interfaces with
LAN hardware.

The code for SIOCGIFMAP if net/core/dev.c simply returns netdev->irq 
which isn't set by most actual LAN drivers any more, and it seems to
be common opinion that setting netdev->irq is either optional or even 
wrong (http://www.ussg.iu.edu/hypermail/linux/kernel/0407.3/1292.html).

Consequently, the SIOCGIFMAP ioctl reports bogus IRQ values for most 
hardware; it is therefore unreliable.

Would it be possible to fix the ioctl such that it returns the correct 
irq value, e.g. be using the irq field of the associated struct pci_dev?

If not, I'd consider it better to deprecate netdev->irq officially and 
always return bogus so that people stop using it.

In both cases, the netdev->irq field isn't used anymore; perhaps it 
should be officially deprecated and/or removed?

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy

