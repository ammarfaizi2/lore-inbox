Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268095AbUHKQWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbUHKQWe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbUHKQWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:22:34 -0400
Received: from fmr06.intel.com ([134.134.136.7]:45967 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S268095AbUHKQWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:22:21 -0400
Message-ID: <411A478E.1080101@linux.intel.com>
Date: Wed, 11 Aug 2004 11:21:34 -0500
From: James Ketrenos <jketreno@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Pavel Machek <pavel@suse.cz>, Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Tomas Szepe <szepe@pinerecords.com>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com> <20040714115523.GC2269@elf.ucw.cz> <20040809201556.GB9677@louise.pinerecords.com> <Pine.LNX.4.61.0408101258130.1290@boston.corp.fedex.com> <20040810075558.A14154@infradead.org> <20040810101640.GF9034@atrey.karlin.mff.cuni.cz> <4119F203.1070009@linux.intel.com> <20040811114437.A27439@infradead.org>
In-Reply-To: <20040811114437.A27439@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Aug 11, 2004 at 05:16:35AM -0500, James Ketrenos wrote:
> 
>>We're currently working to clean up ipw2100 and ieee80211 code for submission to 
>>netdev for discussion and hopefully inclusion in the future.  The ieee80211 code 
>>is still being heavily developed, but its usable.  If anyone wants to help out, 
>>or if folks feel its ready as-is to get pulled into wireless-2.6, let me know.
> 
> Maybe we should switch to your ieee802.11 for a generic wireless stack then
> instead of the original hostap code.  At least it seems more actively
> maintained right now and supports two drivers already.

This would be ideal for those working on the projects using that stack.  If 
others agree I'll put together patches that introduce the ieee80211* module into 
wireless-2.6 once I get the next driver snapshots out for ipw2100 and ipw2200.

> Btw, I've looked at the ipw2100 and have to concerns regarding the firmware,
> 
>  a) yo'ure not using the proper firmware loader but some horrible
>     handcrafted code using sys_open/sys_read & co that's not namespace
>     safe at all

The driver supports (and defaults to) using firmware_class for loading the 
firmware.  The driver also supports a legacy loading approach for folks that 
have problems with using hotplug to load the firmware (which represents a fair 
number of users).

>  b) the firmware has an extremly complicated and hard to comply with license,
>     I'm not sure we want a driver that can't work without a so strangely
>     licensed blob in the kernel. Can you talk to intel lawyers and put it on
>     simple redristribution and binary modification for allowed for all purposes
>     license please?

The firmware license supports redistribution, and complying with the license 
shouldn't be too hard (I agree it may not be worded the most clearly, but few 
legal documents are).  If you have issues or questions about specific terms 
please email me offlist and I can try and address them.

Just to re-answer some others may be wondering regarding the firmware:

1) the firmware does not use nor is it dependent (at all) on the kernel.  no 
part of the firmware executes on the host CPU.
2) the firmware is loaded from disk vs. having to have non-volatile storage on 
the NIC and requiring a firmware flashing utility, etc.
3) the firmware, as per its license, can be redistributed by OSDs, ISVs, etc.

Thanks,
James
