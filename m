Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbVBDDTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbVBDDTV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 22:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263760AbVBDDTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 22:19:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17810 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261673AbVBDDGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 22:06:17 -0500
Message-ID: <4202E693.90808@pobox.com>
Date: Thu, 03 Feb 2005 22:05:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: schwidefsky@de.ibm.com, akpm@osdl.org, Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] s390: qeth network driver
References: <200502040211.j142BI35023854@hera.kernel.org>
In-Reply-To: <200502040211.j142BI35023854@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.2072, 2005/02/03 17:04:37-08:00, schwidefsky@de.ibm.com
> 
> 	[PATCH] s390: qeth network driver
> 	
> 	From: Steffen Thoss <thoss@de.ibm.com>
> 	From: Frank Pavlic <pavlic@de.ibm.com>
> 	
> 	qeth network driver changes:
> 	 - Improve performance by omitting svs.
> 	 - Use function callback mechanism to set layer 2 parameters when getting
> 	   a reply for a Layer 2 command.
> 	 - dev->hard_header must not be NULL when fake_ll is no set since
> 	   IPv6 and Layer2 needs the default function set by network stack.
> 	 - ping6 works now when running in layer 2 mode.
> 	 - Save original dev->hard_header to restore it when the user doesn't
> 	   want to use fake_ll anymore.
> 	 - Fake ethernet header in outgoing packets. This currently works
> 	   only if qeth is compiled without ipv6 support.
> 	 - Add more debug information in case of failures in qeth_set_offline.
> 	 - Using fake_ll with HiperSockets devices results in misaligned
> 	   ip packets and thus no traffic over HiperSockets.
> 	 - Start qeth_remove_device only after the qeth recovery completed.
> 	
> 	Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 	Signed-off-by: Andrew Morton <akpm@osdl.org>
> 	Signed-off-by: Linus Torvalds <torvalds@osdl.org>


It would be nice if this stuff was CC'd to the network, and network 
driver maintainers.

Two immediate concerns I have are,

* saving and restoring dev->hard_header is more than a little bit of a hack

* overall, I'm not so sure IPv6 support should be conditionalized on 
anything but CONFIG_IPV6.  Though S/390 and qeth are certainly unusual 
cases, none of the other net drivers in the kernel require a special 
config option to enable IPv6 support.

	Jeff


