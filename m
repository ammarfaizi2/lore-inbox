Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbULZRIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbULZRIq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 12:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbULZRIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 12:08:45 -0500
Received: from [62.206.217.67] ([62.206.217.67]:51131 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261711AbULZRH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 12:07:57 -0500
Message-ID: <41CEEFB5.1080904@trash.net>
Date: Sun, 26 Dec 2004 18:07:01 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Max Kellermann <max@duempel.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem with 2.6.10 + ipsec/tunnel + netfilter
References: <20041226164022.GA2631@roonstrasse.net>
In-Reply-To: <20041226164022.GA2631@roonstrasse.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Kellermann wrote:
> Hi,
> 
> I upgraded my router today to 2.6.10, from 2.6.9-rc3. It has three
> network adapters: ppp0(eth0) for Internet, eth2 is WLAN and eth0 is
> ethernet. My notebooks connected on eth2 use ipsec (tunnel mode,
> 172.28.1.x/32 - 0.0.0.0/32) to secure the wireless connection.
> 
> Since I upgraded to 2.6.10, the router won't route packets which come
> from the tunnel. It used to receive ESP packets, decrypted them, got
> the new destination IP address, and routed them like normal incoming
> packets. Downgrading to 2.6.9-rc3 makes the problem disappear.

Cut-n-paste from previous answer to the same problem:

Since Linux 2.6.10-rcX. packets from a tunnel-mode SA are dropped if
no policy exists. You most likely only have an input policy, but no
forward policy. If you use setkey to configure your policies,
duplicate the input policy and replace "-P in" with "-P fwd". If you
let racoon generate the policy you need to upgrade to the latest
version. pluto should already get it right.

Regards
Patrick
