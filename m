Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbTBDHkr>; Tue, 4 Feb 2003 02:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267143AbTBDHkr>; Tue, 4 Feb 2003 02:40:47 -0500
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:5546 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S267142AbTBDHkq>;
	Tue, 4 Feb 2003 02:40:46 -0500
Message-ID: <3E3F70AD.7060901@candelatech.com>
Date: Mon, 03 Feb 2003 23:50:05 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: john@grabjohn.com, cfriesen@nortelnetworks.com, ahu@ds9a.nl,
       linux-kernel@vger.kernel.org
Subject: Re: problems achieving decent throughput with latency.
References: <200302031611.h13GBl9D019119@darkstar.example.net>	<3E3EAF04.9010308@candelatech.com> <20030203.211933.27826107.davem@redhat.com>
In-Reply-To: <20030203.211933.27826107.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Ben Greear <greearb@candelatech.com>
>    Date: Mon, 03 Feb 2003 10:03:48 -0800
>    
>    Also, if it's as simple as allocating a few more buffers for tcp, maybe we
>    should consider defaulting to higher in the normal kernel?  (I'm not suggesting
>    **my** numbers..)
> 
> The current values are the only "safe" defaults.  Here "safe" means
> that if you have thousands of web connections, clients cannot force
> the serve to queue large amounts of traffic per socket.
> 
> The attack goes something like: Open N thousand connections to
> server, ask for large static object, do not ACK any of the data
> packets.  Server must thus hold onto N thousnad * maximum socket
> write buffer bytes amount of memory.

Why would it use the maximum socket for a connection with low to
no acks, ie low to no throughput?  Seems like the connection would
have to scale up to full speed/sliding-window, which would require the DoS guy
to have large receive bandwidth, and also enough precision to stop acking
as soon as the window gets big (but before the object download has
completed.)  This does not seem like a great DoS to me.

On my system, the default memory seems to be about 80k (docs say it
is based on how much memory I have (128MB)).  How big can N get?
If N is 10k I can be DOS'd for only 800k?

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


