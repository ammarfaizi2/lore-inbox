Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWGLRLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWGLRLh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWGLRLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 13:11:37 -0400
Received: from smtp-out.google.com ([216.239.33.17]:53424 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751465AbWGLRLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 13:11:36 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
	b=avyJzs1iPkeKU3ejSzGCIoGD9FcbJ3f/w/mLAFHA9AKB8Ji7D230D2bXxvnx4+ft2
	wG9oOIWj8ZWMMmvkwedJQ==
Message-ID: <44B52D3E.90206@google.com>
Date: Wed, 12 Jul 2006 10:11:26 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: e1000 problems in 2.6.18-rc1-mm1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PPC64 lpar (power4)
Works fine in -git4
(http://test.kernel.org/abat/40893/debug/console.log)
Finds the e1000

Intel(R) PRO/1000 Network Driver - version 7.1.9-k2
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0002:21:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:02:55:d3:37:4a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection

....

Setting up network interfaces:
     lo
     lo        IP address: 127.0.0.1/8
7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0      device: Intel Corp. 
82545EM Gigabit Ethernet Controller (Copper) (rev 01)
     eth0      configuration: eth-id-00:02:55:d3:37:4a
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
     eth0      IP address: 9.47.92.101/24
7[?25l[1A[80C[10D[1;32mdone[m8[?25h    tunl0
     tunl0     No configuration found for tunl0
7[?25l[1A[80C[10D[1munused[m8[?25hSetting up service network  .  .  .  . 
  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;32mdone[m8[?25h


-----------------------------------------------

In -mm1 it seems to not find the e1000:
(http://test.kernel.org/abat/40934/debug/console.log)

Intel(R) PRO/1000 Network Driver - version 7.1.9-k2
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0002:21:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:02:55:d3:37:4a
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection

...

Setting up network interfaces:
     lo
     lo        IP address: 127.0.0.1/8
7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
     eth0      No configuration found for eth0
7[?25l[1A[80C[10D[1munused[m8[?25h    tunl0
     tunl0     No configuration found for tunl0
7[?25l[1A[80C[10D[1munused[m8[?25hWaiting for mandatory devices: 
eth-id-00:02:55:d3:37:4a
19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
     eth-id-00:02:55:d3:37:4a            No interface found
7[?25l[1A[80C[10D[1;31mfailed[m8[?25hSetting up service network  .  .  . 
  .  .  .  .  .  .  .  .  .  .  .  .  .7[?25l[80C[10D[1;31mfailed[m8[?25h
