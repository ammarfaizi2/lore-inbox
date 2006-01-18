Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWARRxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWARRxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWARRxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:53:36 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:58001 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932423AbWARRxg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:53:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fsu2YVJI8PX6Y9NijcOzz/0l7Bg1M/pZlE8/76lZXYpc1XqSJAqa+nD0EDWstrNbHACvajkDF3FmY0l3xW4jxfzk3DwDM/MTbYedtMkPMmZOdqiPi2EsBbWLh4UgFejcaK7VQ6zc4V67WRKvwF4s78JvM7/8gKH9Rbn5e7XfBBM=
Message-ID: <9e4733910601180953i11963df9n232cd8980c4bf7f2@mail.gmail.com>
Date: Wed, 18 Jan 2006 12:53:35 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] e1000 C style badness
Cc: jeffrey.t.kirsher@intel.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060118083721.GA4222@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060118080738.GD3945@suse.de> <20060118083721.GA4222@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/06, Jens Axboe <axboe@suse.de> wrote:
> Hi,
>
> Seems e1000 has even bigger problems than just C style badness in the
> newest -git after the e1000 updates. diff of kernel boot messages from
> e1000:
>
> -Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
> +Intel(R) PRO/1000 Network Driver - version 6.3.9-k2
>  Copyright (c) 1999-2005 Intel Corporation.
>  ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
>  PCI: Setting latency timer of device 0000:02:00.0 to 64
> +e1000: 0000:02:00.0: e1000_probe: (PCI Express:2.5Gb/s:Width x1)
> 00:0c:f1:ff:92:b8
>  e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
>
> It sends/receives 5 packages, but the dhcp request never succeeds. If I
> down the interface, it oopses (nvidia module is loaded, however it bombs
> in the same way without it). If I revert just the e1000 updates, my
> system work fine (typing this message from it).

e1000 is failing the same way for me too. Chip is on the motherboard:
Intel Corporation 82540EM Gigabit Ethernet Controller (rev 02)

Jan 18 10:08:26 jonsmirl kernel: ADDRCONF(NETDEV_UP): eth0: link is not ready
Jan 18 10:08:26 jonsmirl kernel: e1000: eth0: e1000_watchdog_task: NIC
Link is Up 100 Mbps Half Duplex
Jan 18 10:08:26 jonsmirl kernel: ADDRCONF(NETDEV_CHANGE): eth0: link
becomes ready
Jan 18 10:08:26 jonsmirl dhclient: DHCPREQUEST on eth0 to
255.255.255.255 port 67
Jan 18 10:08:31 jonsmirl dhclient: DHCPREQUEST on eth0 to
255.255.255.255 port 67
Jan 18 10:08:38 jonsmirl dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 8
Jan 18 10:08:46 jonsmirl dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 10
Jan 18 10:08:56 jonsmirl dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 11
Jan 18 10:09:07 jonsmirl dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 20
Jan 18 10:09:27 jonsmirl dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 9
Jan 18 10:09:36 jonsmirl dhclient: DHCPDISCOVER on eth0 to
255.255.255.255 port 67 interval 3
Jan 18 10:09:39 jonsmirl dhclient: No DHCPOFFERS received.

I am using an old switch so I normally get a half duplex connection:
Jan 18 10:14:25 jonsmirl kernel: e1000: eth0: e1000_watchdog_task: NIC
Link is Up 100 Mbps Half Duplex
I don't normally get the NETDEV up and changed notifications.

--
Jon Smirl
jonsmirl@gmail.com
