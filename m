Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262252AbVGFQuS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbVGFQuS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVGFQuS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:50:18 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:21857 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S262252AbVGFMaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:30:25 -0400
Message-ID: <42CBCEDD.2020401@tls.msk.ru>
Date: Wed, 06 Jul 2005 16:30:21 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0
 on lo?
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On our gateway machine, wich is running 2.6 kernel, I'm seeing quite
several messages like this:

kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
last message repeated 3 times
kernel: 192.168.4.2 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
last message repeated 3 times

kernel: 81.13.90.174 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
gate last message repeated 10 times

kernel: 81.13.90.174 sent an invalid ICMP type 11, code 0 error to a broadcast: 0.0.0.0 on lo
last message repeated 9 times

All the IP addresses mentioned are local to this box.  It's always
like this, type11 code0 to 0.0.0.0 on lo.

The box is a gateway, which have "external" interface, several "LAN"
ifaces, DMZ, dialin modem pool and accepts vtund connections.  And
it has iptables-based firewall and NAT enabled.  Here's a lis of
network-related modules:

ppp_deflate             4736  0
zlib_deflate           21528  1 ppp_deflate
zlib_inflate           16640  1 ppp_deflate
ppp_async               8576  0
crc_ccitt               1920  1 ppp_async
ppp_generic            19860  2 ppp_deflate,ppp_async
slhc                    6144  1 ppp_generic
tun                     8320  13
crc32                   3968  1 tun
ipt_ECN                 2944  163
iptable_mangle          2304  1
ipt_REJECT              4096  1
ipt_LOG                 6272  3
ipt_state               1664  3
ipt_comment             1536  22
iptable_filter          2432  1
iptable_nat            19420  1
ipt_NOTRACK             1920  3
iptable_raw             1792  1
ip_tables              18304  10 ipt_ECN,iptable_mangle,ipt_REJECT,ipt_LOG,ipt_state,ipt_comment,iptable_filter,iptable_nat,ipt_NOTRACK,iptable_raw
md5                     3840  1
ipv6                  218688  12
ip_conntrack           37560  3 ipt_state,iptable_nat,ipt_NOTRACK
aes_i586               38656  1
airo                   63520  0
3c509                  11476  0

I've seen several posts about problems *like* this, but
they're all not from the same box (usually it's some problem
with *another* device on the network which is sending bogus
packets, or with hubs/switches or cables).  In this case,
it looks like it is this same box who's generating those
bad packets.

So far, I wasn't able to relate this message with any particular
network activity.  It happens "randomly".

What it can be?

Thanks.

/mjt
