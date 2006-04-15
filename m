Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030281AbWDOQBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030281AbWDOQBN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 12:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWDOQBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 12:01:13 -0400
Received: from stinky.trash.net ([213.144.137.162]:44785 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1030281AbWDOQBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 12:01:13 -0400
Message-ID: <44411828.5070501@trash.net>
Date: Sat, 15 Apr 2006 17:58:32 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Laurent CARON <lcaron@apartia.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: Openswan, iptables (fiaif) and 2.6.16 kernel
References: <443F9667.2070701@apartia.fr>
In-Reply-To: <443F9667.2070701@apartia.fr>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent CARON wrote:
> Hi,
> 
> I'm running an openswan gateway for quite a long time now.
> 
> I have used 2.4.X and 2.6.X kernels without any problem until i decided
> to upgrade to 2.6.16 kernel.
> 
> Summary of problem:
> 
> Under 2.6.15 everything is fine
> 
> Under 2.6.16 my tunnels establish well, but i can't even ping a single
> computer located on the other end of the tunnel when the firewall is up.
> Disabling the firewall solves the problem (but is not an option for me).
> 
> $ cat ip_conntrack | grep 192.168.10
> icmp     1 8 src=192.168.0.192 dst=192.168.10.1 type=8 code=0 id=793
> packets=4 bytes=116 [UNREPLIED] src=192.168.10.1 dst=XXX.XXX.XXX.XXX
> type=0 code=0 id=793 packets=0 bytes=0 mark=0 use=1
> 
> 192.168.0.0/24 is my lan subnet (natted so that lan computers can access
> the internet through the public ip address)
> 192.168.0.192 is a workstation on my lan
> 192.168.10.0/24 is the other subnet
> XXX.XXX.XXX.XXX is my public ip address
> 
> 
> If i disable the nat of 192.168.0.0/24, i can ping the other end.
> 
> Re-enabling the nat however disables the ability to ping the other end.
> 
> Seems iptables is trying to nat packets the wrong way :$, or that I
> missed a major change in 2.6.16.

2.6.16 does a second policy lookup after SNAT, you probably SNAT
the packets to an address that doesn't match the policy anymore.

