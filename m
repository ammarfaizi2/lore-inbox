Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVCWOky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVCWOky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVCWOky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:40:54 -0500
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:7434 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S261593AbVCWOkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:40:46 -0500
Message-ID: <42417FE3.2090506@hp.com>
Date: Wed, 23 Mar 2005 09:40:35 -0500
From: Mark Seger <Mark.Seger@hp.com>
Organization: Consulting and Architecture
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, sebastien.godard@wanadoo.fr
Subject: Re: Patch for inconsistent recording of block device statistics
References: <42409313.1010308@hp.com> <20050323091916.GO24105@suse.de>
In-Reply-To: <20050323091916.GO24105@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I don't like this patch, it adds 4 * sizeof(unsigned long) to struct
>request when it can be solved without adding anything. The idea is
>sound, though, the current way the stats are done isn't very
>interesting.
>  
>
Actually I wasn't all that excited about using the extra variable 
myself.  However, I wasn't entirely sure what was going on and this at 
least allowed me to test the concept without doing anything harmful. 

>How about accounting merges the way we currently do it, since that piece
>of the stats _is_ interesting at queueing time. And then account
>completion in __end_that_request_first(). Untested patch attached.
>  
>
I also agree with your suggestion about keeping the merged counts where 
they are and am copying the author of iostat to suggest the man page be 
updated to reflect the fact that merges are counts for requests queued 
rather than 'issued to the device' as it currently states.

re: your patch - I did try it on both an Operton and Xeon box.  It 
worked find on the Opeteron and reported 0 for all the sectors on the 
Xeon.  If nothing immediately jumps to your mind could it have been 
something I did wrong?  I'll try another build after I send this along, 
but I don't see how that will help as I did the first one from a brand 
new source kit.

The one thing that still jumps out at me about this patch is that the 
sectors are being counted in one routine and the number of I/Os in 
another.  If the best place to update the sector counts is indeed where 
you suggest doing it, is there any reason not to move the update code 
for all the disk stats from end_that_request_last() to that same place 
as well for consistency and for better assurances that they are updated 
as close to the same point in time as possible?

-mark

