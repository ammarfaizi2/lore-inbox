Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUCDDLW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 22:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUCDDLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 22:11:22 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:63178 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S261409AbUCDDLT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 22:11:19 -0500
Message-ID: <40469E50.6090401@matchmail.com>
Date: Wed, 03 Mar 2004 19:11:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: VM patches in 2.6.4-rc1-mm2
References: <20040302201536.52c4e467.akpm@osdl.org>
In-Reply-To: <20040302201536.52c4e467.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4-rc1/2.6.4-rc1-mm2/
> 
> - More VM tweaks and tuneups

Running 2.6.3-lofft-snsus-264rc1mm2vm (nfsd loff_t, sunrpc locking & -mm 
VM patches).  Seems to be working well.

Both servers started running this kernel on Wednesday morning, or at the 
end of week9 in the graphs.

On a 1G fileserver:
http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-memory.html

Swapping has gone down to zero in this kernel also:
http://www.matchmail.com/stats/lrrd/matchmail.com/fileserver.matchmail.com-swap.html

Top users of slab:
buffer_head        71822  74382     48   77    1 : tunables  120   60
pte_chain          19557  21180    128   30    1 : tunables  120   60
dentry_cache       17771  27840    256   15    1 : tunables  120   60
radix_tree_node    13666  13680    260   15    1 : tunables   54   27
nfs_inode_cache     7870   7872    640    6    1 : tunables   54   27
ext3_inode_cache    5402   7028    512    7    1 : tunables   54   27
vm_area_struct      5385   6728     64   58    1 : tunables  120   60
size-128            2184   2310    128   30    1 : tunables  120   60
filp                2144   2670    256   15    1 : tunables  120   60
inode_cache         1117   1130    384   10    1 : tunables   54   27
size-64              896    928     64   58    1 : tunables  120   60
size-32              836    896     32  112    1 : tunables  120   60


And a 1.5G file/kde over VNC terminal server:
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-memory.html

Swapping has gone down to zero on this server also:
http://www.matchmail.com/stats/lrrd/matchmail.com/srv-lnx2600.matchmail.com-swap.html

One thing for this server.  Most of the desktops are not in use right 
now, so I'd expect the swap usage to grow, but shouldn't be swapping in 
and out a lot in this workload.

Top users of slab:
pte_chain         112097 113550    128   30    1 : tunables  120   60
buffer_head        85089 103334     48   77    1 : tunables  120   60
dentry_cache       81260 112875    256   15    1 : tunables  120   60
ext3_inode_cache   72637  84805    512    7    1 : tunables   54   27
vm_area_struct     40689  41876     64   58    1 : tunables  120   60
radix_tree_node    15603  19140    260   15    1 : tunables   54   27
filp               14536  14955    256   15    1 : tunables  120   60
size-32             3420   3472     32  112    1 : tunables  120   60
size-128            3420   3720    128   30    1 : tunables  120   60
size-64             2768   2958     64   58    1 : tunables  120   60
dnotify_cache       2364   2490     20  166    1 : tunables  120   60
sock_inode_cache    1867   1918    512    7    1 : tunables   54   27
proc_inode_cache    1650   2040    384   10    1 : tunables   54   27
unix_sock           1635   1645    512    7    1 : tunables   54   27
inode_cache         1620   1620    384   10    1 : tunables   54   27
task_struct          578    595   1584    5    2 : tunables   24   12
size-8192            574    574   8192    1    2 : tunables    8    4

Most of the previous 2.6 kernels I was running on these servers would be 
lightly hitting swap by now.  This definitely looks better to me.

I want to continue running these patches until at least Tuesday of next 
week to see how they perform over a longer period.

P.S. I've changed the color scheme in the graphs, let me know what you 
think of them.  They seem better, but there are a couple colors that 
aren't easily seen when they overlap... :-/

Mike
