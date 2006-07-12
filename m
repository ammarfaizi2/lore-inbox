Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWGLVdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWGLVdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbWGLVdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:33:52 -0400
Received: from xenotime.net ([66.160.160.81]:32450 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751439AbWGLVdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:33:51 -0400
Date: Wed, 12 Jul 2006 14:36:38 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Martin Bligh <mbligh@google.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: e1000 problems in 2.6.18-rc1-mm1
Message-Id: <20060712143638.3a1ea590.rdunlap@xenotime.net>
In-Reply-To: <44B52D3E.90206@google.com>
References: <44B52D3E.90206@google.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2006 10:11:26 -0700 Martin Bligh wrote:

> PPC64 lpar (power4)
> Works fine in -git4
> (http://test.kernel.org/abat/40893/debug/console.log)
> Finds the e1000
> 
> Intel(R) PRO/1000 Network Driver - version 7.1.9-k2
> Copyright (c) 1999-2006 Intel Corporation.
> e1000: 0002:21:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:02:55:d3:37:4a
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> 
> ....
> 
> Setting up network interfaces:
>      lo
>      lo        IP address: 127.0.0.1/8
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0      device: Intel Corp. 
> 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
>      eth0      configuration: eth-id-00:02:55:d3:37:4a
> e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
>      eth0      IP address: 9.47.92.101/24
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    tunl0
>      tunl0     No configuration found for tunl0
> 7[?25l[1A[80C[10D[1munused[m8[?25hSetting up service network  .  .  .  . 
>   .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;32mdone[m8[?25h
> 
> 
> -----------------------------------------------
> 
> In -mm1 it seems to not find the e1000:
> (http://test.kernel.org/abat/40934/debug/console.log)
> 
> Intel(R) PRO/1000 Network Driver - version 7.1.9-k2
> Copyright (c) 1999-2006 Intel Corporation.
> e1000: 0002:21:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:02:55:d3:37:4a
> e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
> 
> ...
> 
> Setting up network interfaces:
>      lo
>      lo        IP address: 127.0.0.1/8
> 7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
>      eth0      No configuration found for eth0
> 7[?25l[1A[80C[10D[1munused[m8[?25h    tunl0
>      tunl0     No configuration found for tunl0
> 7[?25l[1A[80C[10D[1munused[m8[?25hWaiting for mandatory devices: 
> eth-id-00:02:55:d3:37:4a
> 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
>      eth-id-00:02:55:d3:37:4a            No interface found
> 7[?25l[1A[80C[10D[1;31mfailed[m8[?25hSetting up service network  .  .  . 
>   .  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;31mfailed[m8[?25h
> -

lkml thread:
Subject: Re: 2.6.18-rc1-mm1:  /sys/class/net/ethN becoming symlink befuddled /sbin/ifup

akpm's answer:
I'd be suspecting
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc1/2.6.18-rc1-mm1/broken-out/gregkh-driver-network-class_device-to-device.patch.

already confirmed:
Yeah, that and gregkh-driver-class_device_rename-remove.patch brought it
back to reality.

---
~Randy
