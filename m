Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTJQVWM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 17:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbTJQVWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 17:22:12 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:37333 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S263528AbTJQVWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 17:22:07 -0400
Message-ID: <3F905D7D.9030602@wmich.edu>
Date: Fri, 17 Oct 2003 17:22:05 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <alex@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EXT3 extents against 2.6.0-test7
References: <20031013222747.37f5ee7b.alex@clusterfs.com>	<3F8B1BA1.4020800@wmich.edu>	<20031014212359.42243025.alex@clusterfs.com>	<3F9043E7.3070606@wmich.edu>	<20031018001001.25e85002.alex@clusterfs.com>	<3F904D7F.50403@wmich.edu> <20031018004152.6aa9e9c3.alex@clusterfs.com>
In-Reply-To: <20031018004152.6aa9e9c3.alex@clusterfs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
> On Fri, 17 Oct 2003 16:13:51 -0400
> Ed Sweetman <ed.sweetman@wmich.edu> wrote:
> 
> 
>>How am i supposed to know which directory in the fs this corruption 
>>takes place in?   I can tell you the size of the partitions that have 
>>extents enabled, From that error message i dont even know which 
>>partition it was.  And judging by the dmesg last modified time, this 
>>happened 2 days ago
> 
> 
> OK. the question wasn't clear.
> 
> 1) could you _estimate_ max directory size or number of entries in single
>    directory on your filesystems, please? had you large directories?
>    100, 300, 500 or more entries?

none of my directories have more than 60 or so entries.  I keep 
everything very organized on my hdds.  The largest directories would be 
the ones holding the largest files but that maxes out at around 60 file 
entries.  i formatted those partitions with a 4KB inode size.


outside of the two partitions with extents enabled though....  I'm not 
sure if i have any seriously large directories in my other partitions. 
And their inode size varies from 1KB to 4Kb depending on what type of 
content they're expected to have .

> 2) did you use 2.6.0-test7+extents or some another patches?

The only other patches i have are related to fbdev and directfb. 
Otherwise it's a vanilla 2.6.0-test7 + extents patch that you posted for it.


> 3) could you describe workload. knowing it I'd try to reproduce this


Workload on those partitions at the time?  It cant be anything more than 
mplayer reading a movie or writing a movie to disk.  And the writes 
would be at about 20MB/sec avg (ext3 to ext3 both with extents) from one 
drive (the partitions happen to be on separate drives) to the other. The 
transferrate spikes at 30MB/sec at start and stays at around 20MB/sec 
for upwards up 1GB for a file.

Nothing else is done on those partitions.  System wise though, what 
caused the crash to occur was updatedb, which does a find on every 
filesystem off of /.  This is what was running when the error occured, 
and it didn't happen this morning when it happened again, the error i 
mean.  I have dma enabled so updatedb doesn't cause significant 
schedular issues due to cpu usage. That's all that was going on at the 
time.


> 
> 
>>Isn't it possible though that this happened in one of the non-extents 
>>enabled partitions though?  Since they still have the ability to read 
>>extents in files, they have to try and look them up every time for 
>>everything dont they?  Anyways, the two partitions above are the only 
>>ones i actually enable extents on.
>>
> 
> 
> extents take place only if flag in inode->i_flags is set. that flag can
> be set only during inode creation on extents-enabled filesystem.
> 
> with best wishes, Alex
> 


