Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbVA1QkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbVA1QkW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 11:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVA1QkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 11:40:22 -0500
Received: from mailhub.lss.emc.com ([168.159.2.31]:4250 "EHLO
	mailhub.lss.emc.com") by vger.kernel.org with ESMTP id S261475AbVA1QkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 11:40:11 -0500
Message-ID: <41FA6ADE.4010209@emc.com>
Date: Fri, 28 Jan 2005 11:39:58 -0500
From: Ric Wheeler <ric@emc.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jakob Oestergaard <jakob@unthought.net>
CC: Kiniger <karl.kiniger@med.ge.com>, Lars Marowsky-Bree <lmb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: raid 1 - automatic 'repair' possible?
References: <20050118211801.GA28400@wszip-kinigka.euro.med.ge.com> <20050118214605.GY22648@marowsky-bree.de> <20050119104852.GB3087@wszip-kinigka.euro.med.ge.com> <20050119115519.GY347@unthought.net>
In-Reply-To: <20050119115519.GY347@unthought.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.6.1.107272, Antispam-Engine: 2.0.2.0, Antispam-Data: 2005.1.28.2
X-PerlMx-Spam: Gauge=, SPAM=7%, Reasons='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having looked at a lot of disks, I think that it is definitely worth 
forcing a write to try and invoke the remap.  With large drives, you 
usually several bad sectors in the normal case (drive vendors allocate 
up to a couple thousand spare sectors just for remapping).

Depending on the type of drive error, the act of writing is likely to 
clean the questionable sector and leave you with a perfectly fine disk.

Ric

Jakob Oestergaard wrote:

>On Wed, Jan 19, 2005 at 11:48:52AM +0100, Kiniger wrote:
>...
>  
>
>>some random thoughts:
>>
>>nowadays hardware sector sizes are much bigger than 512 bytes
>>    
>>
>
>No :)
>
>  
>
>>and
>>the read error may affect some sectors +- the sector which actually
>>returned the error.
>>    
>>
>
>That's right
>
>  
>
>>to keep the handling in userspace as much as possible: 
>>
>>the real problem is the long resync time. therefore it would
>>be sufficient to have a concept of "defective areas" per partition
>>and drive (a few of them, perhaps four or so , would be enough) 
>>which will be excluded from reads/writes and some means to
>>re-synchronize these "defective areas" from the good counterparts
>>of the other disk. This would avoid having the whole partition being
>>marked as defective.
>>    
>>
>
>I wonder if it's really worth it.
>
>The original idea has some merit I think - but what you're suggesting
>here is almost "bad block remapping" with transparent recovery and user
>space policy agents etc. etc.
>
>If a drive has problems reading the platter, it can usually be corrected
>by overwriting the given sector (either the drive can actually overwrite
>the sector in place, or it will re-allocate it with severe read
>performance penalties following). But there's a reason why that sector
>went bad, and you realy want to get the disk replaced.
>
>I think the current policy of marking the disk as failed when it has
>failed is sensible.
>
>Just my 0.02 Euro
>
>  
>
