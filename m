Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUBYEEb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 23:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbUBYEEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 23:04:31 -0500
Received: from ns1.g-housing.de ([62.75.136.201]:11145 "EHLO mail.g-house.de")
	by vger.kernel.org with ESMTP id S262380AbUBYEE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 23:04:28 -0500
Message-ID: <403C1EC3.5070808@g-house.de>
Date: Wed, 25 Feb 2004 05:04:19 +0100
From: Christian <evil@g-house.de>
User-Agent: Mozilla Thunderbird 0.5+ (Windows/20040223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, marcelo.tosatti@cyclades.com
Subject: Re: 2.4.24 + cryptoloop: __alloc_pages: 5-order allocation failed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry, took me a while]
 > Christian, Daniel,
 >
 > Please do
 >
 > echo 1 > /proc/sys/vm/vm_gfp_debug

i did so, but it revealed not much (any?) more information:

Feb 25 03:05:17 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:05:17 sheep kernel: This architecture does not implement 
dump_stack()
Feb 25 03:05:27 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:05:27 sheep kernel: This architecture does not implement 
dump_stack()
Feb 25 03:05:27 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:05:27 sheep kernel: This architecture does not implement 
dump_stack()
Feb 25 03:05:27 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:05:27 sheep kernel: This architecture does not implement 
dump_stack()
Feb 25 03:06:17 sheep syslog-ng[324]: STATS: dropped 94
Feb 25 03:07:42 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:07:42 sheep kernel: This architecture does not implement 
dump_stack()
Feb 25 03:07:52 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:07:52 sheep kernel: This architecture does not implement 
dump_stack()
Feb 25 03:07:52 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:07:52 sheep kernel: This architecture does not implement 
dump_stack()
Feb 25 03:07:52 sheep kernel: __alloc_pages: 0-order allocation failed 
(gfp=0x30/0)
Feb 25 03:07:52 sheep kernel: This architecture does not implement 
dump_stack()

for the record:

root@sheep:~# cat /proc/sys/vm/vm_gfp_debug
1
root@sheep:~#

some thoughts of mine:
after setting vm_gfp_debug to 1 i run the benchmarks again, with a 200MB 
  testfile (within a 700MB fs, setup via cryptoloop). in the log the 
messages from above showed up, but this time the benchmark was able to 
finish, the system was *never unusable* during the test (like i was 
experienceing with former kernels too). but: i don't know if i had 
another memory consuming app running last time. even if i did, i did not 
get any OOM messages, but i could think of higher memory- / vm-pressure 
last time....

oh, and just in case i forgot last time, this is the machine:
http://nerdbynature.de/bits/sheep/2.4.24-benh/ver_linux

(maybe this is why syslog says: "
Feb 25 03:07:52 sheep kernel: This architecture does not implement 
dump_stack()"?)

Thank you,
Christian.
-- 
BOFH excuse #141:

disks spinning backwards - toggle the hemisphere jumper.

