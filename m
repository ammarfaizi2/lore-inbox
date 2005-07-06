Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVGGAXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVGGAXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVGFUCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:02:46 -0400
Received: from alog0364.analogic.com ([208.224.222.140]:37571 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262390AbVGFR24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:28:56 -0400
Date: Wed, 6 Jul 2005 13:27:16 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: sent an invalid ICMP type 11, code 0 error to a broadcast:
 0.0.0.0 on lo?
In-Reply-To: <42CBCEDD.2020401@tls.msk.ru>
Message-ID: <Pine.LNX.4.61.0507061319440.5241@chaos.analogic.com>
References: <42CBCEDD.2020401@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Michael Tokarev wrote:

> On our gateway machine, wich is running 2.6 kernel, I'm seeing quite
> several messages like this:
>
> kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
> last message repeated 3 times
> kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
> last message repeated 3 times
>
> kernel: 81.13.90.174 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
> gate last message repeated 10 times
>
> kernel: 81.13.90.174 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
> last message repeated 9 times
>
> All the IP addresses mentioned are local to this box.  It's always
> like this, type11 code0 to 0.0.0.0 on lo.
>
> The box is a gateway, which have "external" interface, several "LAN"
> ifaces, DMZ, dialin modem pool and accepts vtund connections.  And
> it has iptables-based firewall and NAT enabled.  Here's a lis of
> network-related modules:
>
> ppp_deflate             4736  0
> zlib_deflate           21528  1 ppp_deflate
> zlib_inflate           16640  1 ppp_deflate
> ppp_async               8576  0
> crc_ccitt               1920  1 ppp_async
> ppp_generic            19860  2 ppp_deflate,ppp_async
> slhc                    6144  1 ppp_generic
> tun                     8320  13
> crc32                   3968  1 tun
> ipt_ECN                 2944  163
> iptable_mangle          2304  1
> ipt_REJECT              4096  1
> ipt_LOG                 6272  3
> ipt_state               1664  3
> ipt_comment             1536  22
> iptable_filter          2432  1
> iptable_nat            19420  1
> ipt_NOTRACK             1920  3
> iptable_raw             1792  1
> ip_tables              18304  10 ipt_ECN,iptable_mangle,ipt_REJECT,ipt_LOG,ipt_state,ipt_comment,iptable_filter,iptable_nat,ipt_NOTRACK,iptable_raw
> md5                     3840  1
> ipv6                  218688  12
> ip_conntrack           37560  3 ipt_state,iptable_nat,ipt_NOTRACK
> aes_i586               38656  1
> airo                   63520  0
> 3c509                  11476  0
>
> I've seen several posts about problems *like* this, but
> they're all not from the same box (usually it's some problem
> with *another* device on the network which is sending bogus
> packets, or with hubs/switches or cables).  In this case,
> it looks like it is this same box who's generating those
> bad packets.
>
> So far, I wasn't able to relate this message with any particular
> network activity.  It happens "randomly".
>
> What it can be?
>
> Thanks.
>

Are you sure `lo` is configured properly, i.e.

ifconfig lo 127.0.0.1 netmask 255.0.0.0
route add -net 127.0.0.0 netmask 255.0.0.0 dev lo

There should be no LAN routes going through lo.
It looks as though there are:
> kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error
> to a broadcast: 0.0.0.0 on lo
                              |________ 192.168.4.2 pinged lo

Only the 127.0.0.0 network should be routed through the loop-back
device.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
