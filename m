Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268019AbUHKKRj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268019AbUHKKRj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 06:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268017AbUHKKRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 06:17:39 -0400
Received: from fmr05.intel.com ([134.134.136.6]:50157 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268019AbUHKKRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 06:17:23 -0400
Message-ID: <4119F203.1070009@linux.intel.com>
Date: Wed, 11 Aug 2004 05:16:35 -0500
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Christoph Hellwig <hch@infradead.org>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com> <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040810101640.GF9034@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>>>ipw2100 0.51 from ipw2100.sf.net builds using gcc-2.95.3 "out of the box."
>>>
>>>Well, this is really good news!
>>>
>>>I just downloaded 0.51 compiled with gcc-2.95.3 and got it working on my 
>>>IBM X31 with WEP. Even better, 0.51 doesn't need hostap-driver.
>>
>>Btw, any vounteer for merging the hostap-based generic ieee80211_* files
>>from the ipw2100 driver with the hostap driver in the wireless-2.6 tree?
> 
> I know very little about wireless-2.6 tree (where to get it without
> bitkeeper?), but...
> 
> task is to take ipw2100 driver, drop ieee80211_* files from it, and
> make it work with ieee80211* files from wireless-2.6?

The ieee80211_* files in the ipw2100 were partially based on the hostap source, 
with any HW specific code pulled out.  It handles Tx and Rx right now for BSS, 
IBSS, and MONITOR mode, supporting wep, etc. It doesn't have all the hooks 
needed for the host based AP mode that Host AP currently has, nor does it 
support wpa yet.

We're also using the stack for the ipw2200 project (which we hope to get another 
snapshot release out soon)  We've been talking about pulling ieee80211 into its 
own project as others have expressed an interest in using it in their drivers as 
well.

The general goal for the ieee80211 stack has been to be able to take an skb from 
the xmit handler, fragment and encrypt that skb, and provide that list of those 
802.11 fragments to the driver for transmission.  On the Rx side, the ieee80211 
stack expects a standard 802.11 data frame which it then performs any decrypt / 
defrag and then passes up to the kernel.

Additional frame code is slowly being added to ieee80211 to support handling of 
probe response / beacons to manage scan results, etc. and provide default WE 
handlers for exposing that information.

ieee80211_wx provides some generic implementation for the WE handlers that every 
driver has to implement the same way.

We're currently working to clean up ipw2100 and ieee80211 code for submission to 
netdev for discussion and hopefully inclusion in the future.  The ieee80211 code 
is still being heavily developed, but its usable.  If anyone wants to help out, 
or if folks feel its ready as-is to get pulled into wireless-2.6, let me know.

Thanks,
James


