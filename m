Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUKSVeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUKSVeb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 16:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbUKSVeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 16:34:31 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:13068 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261571AbUKSVe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 16:34:28 -0500
Message-ID: <419E66D1.8000304@techsource.com>
Date: Fri, 19 Nov 2004 16:34:09 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Blocking access to a PCI device for "a long time"?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some of you may have followed the earlier discussions on the open 
graphics card.  One problem is that we are trying to fit a lot of logic 
into a small area, so one thing we're considering is having multiple 
FPGA bitfiles in the PROM.  When changing modes (ie. from VGA to 3D), 
the driver would instruct the FPGA to reload itself from a different 
part of the bitfile PROM.

The issue here is that it's a complete reload of the FPGA which makes it 
completely lose all configuration state, which includes PCI config. 
Thus, the process for switching modes would go something like this:

- Make sure that nothing can get confused by the device "going away" on 
the PCI/AGP bus, using whatever kernel locks are necessary
- Save PCI config state of device
- Instruct the FPGA to reload itself
- Wait many, many, many, many milliseconds
- Reload PCI config state
- Unlock and continue

Other drivers accessing the bus for other devices is PROBABLY not a 
problem, but nothing can touch the GPU while it's reloading.

Are there any problems with this approach that would make it a really 
bad idea?
