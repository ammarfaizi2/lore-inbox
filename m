Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbVBUNVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbVBUNVz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 08:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVBUNVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 08:21:55 -0500
Received: from psyche.piasta.pl ([83.175.144.5]:46567 "EHLO psyche.piasta.pl")
	by vger.kernel.org with ESMTP id S261966AbVBUNVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 08:21:53 -0500
Message-ID: <4219E06E.6030700@koba.pl>
Date: Mon, 21 Feb 2005 14:21:50 +0100
From: Piotr Kowalczyk <poe@koba.pl>
Reply-To: poe@koba.pl
Organization: KoBa ISP
User-Agent: Mozilla Thunderbird 1.0 (X11/20041208)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: dst cache overflow, again
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm suffering from destination cache overflow on router running kernel 
2.6.10. This wouldn't be anything special if not different numbers 
reported by slabinfo and the real state. It's worth to mention that 
there was no problems with old 2.4.x here.

user@somemachine:~$ cat /proc/slabinfo | grep ip_dst_cache; \
 > cat /proc/net/rt_cache | wc -l; \
 > /sbin/ip ro sh cache | grep cache | wc -l;
ip_dst_cache      153870 154530    256   15    1 : tunables  120   60 
  8 : slabdata  10302  10302      0
2159
2247

I'm increasing /proc/sys/net/ipv4/route/max_size, but the value reported 
by slabinfo also slowly but steady is going up.
There is similar issue here (maybe even more), 
http://www.uwsg.iu.edu/hypermail/linux/net/0312.3/0000.html, but 
unfortunatelly stayed without answer.
Please give some hints about that, or if I'm wrong (meaning that is not 
a bug), tell me what to do - I don't want to reboot this router every 
week and CC: me (I'm not subscribed to the list).
I'm also wondering if tuning of rhash_entries= boot parameter could help?
Thank you,
Piotr Kowalczyk


ps.
Output of rtstat, in case it would help:

user@somemachine:~$ ./rtstat
  size   IN: hit     tot    mc no_rt bcast madst masrc  OUT: hit     tot 
     mc GC: tot ignored goal_miss ovrf HASH: in_search out_search
152294      5094    5563     0    98     0     0     0       153      26 
      0    5687    5685         2    0            3199         27
152377      4902    5851     0   108     0     0     0       153      20 
      0    5980    5978         2    0            3284         39
152416      4932    5526     0    76     0     0     0       128      26 
      0    5629    5627         2    0            3080         22
