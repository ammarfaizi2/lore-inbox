Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272289AbRHXSXR>; Fri, 24 Aug 2001 14:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272290AbRHXSXH>; Fri, 24 Aug 2001 14:23:07 -0400
Received: from [128.55.19.230] ([128.55.19.230]:34457 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S272289AbRHXSWr>; Fri, 24 Aug 2001 14:22:47 -0400
Message-ID: <3B869A46.B1EF708A@lbl.gov>
Date: Fri, 24 Aug 2001 11:17:42 -0700
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Andi Kleen <ak@suse.de>, Bernhard Busch <bbusch@biochem.mpg.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel> <oupg0ahmv2a.fsf@pigdrop.muc.suse.de> <3B867096.3A1D7DE@candelatech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Couldn't the bonding code be made to distribute pkts to one interface or
> another based on a hash of the sending IP port or something?  Seems like that
> would fix the reordering problem for IP packets....  It wouldn't help for
> a single stream, but I'm guessing the real world problem involves many streams,
> which on average should hash such that the load is balanced...
> 

Cisco etherchannel does this, by XOR'ing the dest address with the
source address, AND'ing with # of interfaces (limiting you to a power of
2), and then using the number to determine what channel to use.

Now, you end up in a 4 way Etherchannel, all the traffic going down one
channel, and the none going down the other three.  Does that sound like
a balanced solution?

Most bonding problems are either the card driver is busted, the card is
busted (el-cheapo NE2000 PCI clones are really bad..) or the switch
can't handle it.  Most cheap, dumb switches break big time when using
Bonding with them.


-- 
------------------------+--------------------------------------------------
Thomas Davis		| ASG Cluster guy
tadavis@lbl.gov		| 
(510) 486-4524		| "80 nodes and chugging Captain!"
