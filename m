Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268430AbUHLGnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268430AbUHLGnj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 02:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268425AbUHLGnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 02:43:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53730 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268430AbUHLGng
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 02:43:36 -0400
Message-ID: <411B118B.4040802@pobox.com>
Date: Thu, 12 Aug 2004 02:43:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Clem Taylor <clemtaylor@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Any news on a higher performance sata_sil SIL_QUIRK_MOD15WRITE
 workaround?
References: <411AFD2C.5060701@comcast.net>
In-Reply-To: <411AFD2C.5060701@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clem Taylor wrote:
> I've been really disappointed by the performance of the Silicon Image 
> 3114 on my new x86_box. I spent a bunch of time looking into the 
> problem, thinking it was a software RAID5 or xfs issue causing 4K IOs.
> I don't know why I didn't notice the 'applying Seagate errata fix' in 
> dmesg until after I did a bunch of performance testing and realized that 
> it was a sata_sil issue.
> 
> So, I was wondering what I can do about this problem? I am not currently 

Get a different controller + disk combination.


> getting enough disk performance to justify the amount spent on the 
> system or enough to satisfy the application I'm working on. Before I go 
> out and purchase a 3ware controller and re-install the machine (ouch), 
> is there any chance of a better work around in the near future? I'd be 
> more than willing to test out a patch.
> 
> Is the problem with really with nblocks % 15 == 1? Or is the problem 
> with nblocks % 15 == 0? If it is the later and I'm using xfs with 4K 
> blocks, couldn't I just turn off the workaround or will the RAID5 driver 
> potentially break up larger requests?

The problem is that the Silicon Image controller sends unusual -- but 
legal -- block sizes to the SATA device.

Older Seagates cannot cope with this unique, but spec-correct behavior.

This issue cannot even be worked around with "nblocks % 15 == 1", as was 
previously thought.  Using that formula just makes the problem harder to 
reproduce.

Further, I don't have any plans to address the performance issue, since 
the set of affected drives is finite.


> It would seem that the root of the problem is a Seagate issue. Does 
> anyone know if Seagate fixed the problem with a firmware update? 

You could find out for us, and let us know :)

	Jeff


