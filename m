Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264592AbTKNFfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 00:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTKNFfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 00:35:51 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:51329
	"EHLO bastard") by vger.kernel.org with ESMTP id S264592AbTKNFfi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 00:35:38 -0500
Message-ID: <3FB469A0.6010502@tupshin.com>
Date: Thu, 13 Nov 2003 21:35:28 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: gigabit ethernet, nfsroot, jumbo packets, questions, and bugs (2.6.0-test9)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to set up a diskless testbed using gigabit ethernet, and I'm 
running into a few issues. First, the scenario:

One client, and one server each with an smc EZCard 1000.
Kernel 2.6.0-test9 with the sk98lin driver on both sides
Client has kernel compiled with sk98lin built in, and nfsroot and dhcp 
autoconfig built in.
Client is getting bootstrapped off a hard drive (for now, since 
etherboot doesn't support the driver yet) with grub loading the nfsroot 
kernel from disk, and then mounting nfsroot by adding root=/dev/nfs


What works:
Everything basic.

What doesn't:
Above scenario with Jumbo packets (MTU = 9000 or anything above 1500)

For performance reasons, I'm wanting to use large packets(the switch 
between the devices supports it, and jumbo packet communication works 
fine in the non-diskless scenario).

Questions:
1) Is there a good way to set the MTU of the client via dhcp or by 
passing a parameter to the kernel?

2) If server is set to 9000 MTU and client is set to 1500 MTU, should 
complete failure ensue(e.g. nfs times out indefinitely), or should some 
autonegotiation take place? If there should be autonegotiation, then it 
isn't working.

Definite Bug:
If the server is set to 9000 MTU, ifconfig down, and ifconfig up with 
default MTU doesn't work. Ifconfig then claims that the card is set to 
1500 MTU, but it is unable to communicate with the client until module 
is unloaded and reloaded, even though MTU is an ifconfig parameter and 
not a module parameter. I'm presuming that MTU has not actually been set 
back to 1500, but I don't know of an easy way to tell if that's the case 
when ifconfig appears to be lying to me.

-Thanks
-Tupshin

