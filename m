Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbUBWWP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 17:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUBWWP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 17:15:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:50383 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262004AbUBWWPW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 17:15:22 -0500
Message-ID: <403A79E0.6080609@us.ibm.com>
Date: Mon, 23 Feb 2004 14:08:32 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joe Thornber <thornber@redhat.com>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/6] dm: endio method
References: <20040220153145.GN27549@reti> <20040220153403.GO27549@reti> <40372BCE.7090708@us.ibm.com> <20040223100512.GB943@reti>
In-Reply-To: <20040223100512.GB943@reti>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Joe,

Joe Thornber wrote:

> Mike,
> 
> On Sat, Feb 21, 2004 at 01:58:38AM -0800, Mike Christie wrote:
> 
>>Saving and restoring bi_bdev is going to break multipath.
> 
> 
> Yes, we'll have to fall back to plan A and use the map_context pointer
> to hold the path being used (attached patch for illustration only).  I
> had been hoping we could keep the map_context unused so that we could
> allow the path selectors to use it.  I should have spotted this.
> 
> I'll also move the failed bio remap back to mpath_end_io(), so that
> the context can be reused there (it moved to the daemon when we were
> trying to do path testing in the kernel).
>

With this move if the path has to be activated first, will the daemon 
have to call some sort of ps_path_is_initialized() function before it 
calls generic_make_request?

It might be easier if mp's map_io call did not move so it or the ps 
could send commands and wait for the response before selecting a path. I 
guess this would mean you would have to add a access function for the 
tio's map_info so it could be set from the daemon, or mp may need to 
allocate its own io wrapper. It seems the latter may now be needed to 
give ps's a a map_info, becuase dm-mpath needs to store the path in the 
tio's map_info.

Mike
