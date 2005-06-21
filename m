Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVFUTV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVFUTV7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 15:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbVFUTV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 15:21:59 -0400
Received: from host191.ipowerweb.com ([66.235.202.101]:11274 "HELO
	host191.ipowerweb.com") by vger.kernel.org with SMTP
	id S261156AbVFUTVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 15:21:50 -0400
Message-ID: <42B868CC.1010008@hivemynd.net>
Date: Tue, 21 Jun 2005 14:21:48 -0500
From: Stephen Jones <hivemynd@hivemynd.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
CC: "J.A. Magallon" <jamagallon@able.es>, Andrew Morton <akpm@osdl.org>,
       netdev@vger.kernel.org,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       linux-kernel@vger.kernel.org
Subject: Re: iptables bug
References: <20050619233029.45dd66b8.akpm@osdl.org>	<1119305756l.1344l.0l@werewolf.able.es>	<20050620153445.5daaed4e.akpm@osdl.org> <42B753A8.5050808@trash.net>
In-Reply-To: <42B753A8.5050808@trash.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> Andrew Morton wrote:
> 
>>"J.A. Magallon" <jamagallon@able.es> wrote:
>>
>>
>>>Are there any known problems with iptables ?
> 
> 
> No known problems.
> 
> 
>>>I see strange things.
>>>When I use bittorrent (azureus or bittorrent-gui), at the same time as
>>>iptables (for nat and internet access for my ibook), when I stop a download
>>>or exit from one of this apps my external network goes down. 
>>>I have tried the same without iptables loaded and it works fine.

I have observed this behavior on multiple machines, but I don't think it 
is specifically an iptables "bug" or kernel "bug".  Most of my 
experience is with 2.4.x kernels, so I can't remark about the 2.6.x series.

The original poster didn't give enough info for me to correlate anything 
with conviction, but, consulting the tea leaves :D I would venture to 
guess that the machine that has the network "go down" has less than 128 
MB of RAM and is probably running lower end NICs (i.e. 8139too).

There appears to be two or three issues interacting with one another in 
these scenarios:

a.) The various Bit Torrent clients and their ilk can generate a 
staggering number of conncurrent connections.  This can quickly fill the 
conntracks on machines with little RAM and cause problems.

b.) The lower end nics (either the hardware itself, or the drivers, I 
don't know enough about how to isolate the two) do not appear to be able 
to handle the massive number of interrupts that are generated in this 
scenario.

c.) The problem is more likely to manifest on  "fat pipe" connections (6 
MB +)

I would also wager the problem goes away if the torrent clients are shut 
down.

I would look there, if I hade the skills requried to tease out anything 
useful :D

Various linux based firewall forums have posts describing the same 
behavior as the OP of this thread.

Here is one relatively recent example:

http://community.smoothwall.org/forum/viewtopic.php?p=43812#43812

I hope that helps in some way!

> 
> 
> What exactly do you mean with "network goes down"? Can you find out
> where the packets disappear? Do they silently disappear, or do you get
> an error code from sendmsg? What about received packets?
> 
> Regards
> Patrick
> 
> 
> 

