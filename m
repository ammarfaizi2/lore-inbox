Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTJRAHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTJRAHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:07:53 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:40877 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263666AbTJRAHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:07:47 -0400
Message-ID: <3F908452.3090502@wmich.edu>
Date: Fri, 17 Oct 2003 20:07:46 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EXT3 extents against 2.6.0-test7
References: <20031013222747.37f5ee7b.alex@clusterfs.com>	<3F8B1BA1.4020800@wmich.edu>	<20031014212359.42243025.alex@clusterfs.com>	<3F9043E7.3070606@wmich.edu>	<20031018001001.25e85002.alex@clusterfs.com>	<3F904D7F.50403@wmich.edu>	<20031018004152.6aa9e9c3.alex@clusterfs.com>	<3F905D7D.9030602@wmich.edu> <20031018030508.4c168433.alex@clusterfs.com>
In-Reply-To: <20031018030508.4c168433.alex@clusterfs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> On Fri, 17 Oct 2003 17:22:05 -0400
> Ed Sweetman <ed.sweetman@wmich.edu> wrote:
> 
> 
>>none of my directories have more than 60 or so entries.  I keep 
>>everything very organized on my hdds.  The largest directories would be 
>>the ones holding the largest files but that maxes out at around 60 file 
>>entries.  i formatted those partitions with a 4KB inode size.
> 
> 
> oh. this seems very confusing for me. extents crashed during readdir() syscall.
> 4k block may contain upto 60 entries with 60chars length. even if your dir was
> larger I don't think it was >16k. so, I really do believe all the extents were
> placed in inode body (zero tree depth). also, directory grows in linear manner
> only. so, this code patch is very very simple and quite good tested. thus it 
> really seems like a corruption, not an error in logic. let me cook a patch that
> will show more info.  
> 
> also, it's very interesting how is it difficult to reproduce on your box?
> 
> thanks!
> 
> --
> with best regards, Alex
> -

I've been getting dma errors and rtc irq's being missed since moving to 
test7.  I'm really not impressed with it at all.  Whatever happened 
between it and andrew morton's 4th patch to test4 really sucked things 
up with the kernel.  I'm getting zombie processes now that access the 
filesystem (non-extent partitions).  I'm inclined to believe that there 
is corruption, but i really have no idea where it's coming from.  Too 
many things have been patched at the same time to get a feel for which 
one could be causing the problem.  Andrew Morton's branch has been nicer 
to me than linus's for a while so i'm gonna go and patch to that one. 
Even if i wanted to stop using extents,  It would be really hard to 
since i've already started using it and the process is not 
reversable....or is it?


Would i reverse the effect of using extents by copying a file that was 
written when extents were enabled to another location and then back 
again with all partitions mounted with extents not enabled but supported 
by the patch?  Would i be able to fsck the partition without fear of 
fsck completely destroying the partition? and my other ones too for that 
matter.

has there been an ata commit or something?


And it's not so much that it's hard to replicate it's that the processes 
that cause it zombify and dont usually allow the program to be run a 
second time due to it still holding locks.

