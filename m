Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265110AbSJRO55>; Fri, 18 Oct 2002 10:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265113AbSJRO55>; Fri, 18 Oct 2002 10:57:57 -0400
Received: from cmailm3.svr.pol.co.uk ([195.92.193.19]:25872 "EHLO
	cmailm3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S265110AbSJRO54>; Fri, 18 Oct 2002 10:57:56 -0400
Date: Fri, 18 Oct 2002 16:03:37 +0100
To: christophe.varoqui@free.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: block allocators and LVMs
Message-ID: <20021018150337.GA3195@fib011235813.fsnet.co.uk>
References: <3DA24B4A0064C333@mel-rta8.wanadoo.fr> <20021018112617.GA1942@fib011235813.fsnet.co.uk> <1034946264.3db006d87c82c@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034946264.3db006d87c82c@imp.free.fr>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 03:04:24PM +0200, christophe.varoqui@free.fr wrote:
> I realize I didn't pick the right words (from my poor English 
> dictionnary) : I meant an extend remapper rather than a block remapper. 

extent remapper.

> As far as I can see, this task can be done entirely from userland : 
>  
> o per-extend IO counters exported from kernel-space can be turned into 
>   a list of extends sorted by activity 
>  
> o lvdisplay-like tool gives the mapping extend<->physical blocks 
>  
> o a scheduled job in user-space should be able to massage this info to 
>   decide where to move low-access-rate-extends to the border of the 
>   platter and pack high-access-rate-extends together ... all in one run 
>   that can be scheduled at low activity period (cron defrag way) 
>  
> The algorithm could be something along the line of : 
>  
> while top_user_queue_not_empty 
> do 
>   extend = dequeue_lowest_user_extend 
>   if extend_in_good_spot 
>   then 
>     move_extend_to_corner_destination 
>     find_highest_user_extend_in_bad_spot 
>     move_this_extend_to_freed_good_spot 
>   fi 
> done 

What you describe could be very beneficial, especially if you start
striping the high bandwidth areas.  However in no way could this be
described as 'online FS defragmentation'.

- Joe
