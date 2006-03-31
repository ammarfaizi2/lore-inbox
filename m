Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWCaMpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWCaMpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 07:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCaMpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 07:45:20 -0500
Received: from unthought.net ([212.97.129.88]:25356 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S1751309AbWCaMpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 07:45:20 -0500
Date: Fri, 31 Mar 2006 14:45:19 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS client (10x) performance regression 2.6.14.7 -> 2.6.15
Message-ID: <20060331124518.GH9811@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20060331094850.GF9811@unthought.net> <1143807770.8096.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143807770.8096.4.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 07:22:50AM -0500, Trond Myklebust wrote:
...
> 
> Some nfsstat output comparing the good and bad cases would help.

Clean boot on 2.6.15 and 2.6.14.7, one run of nfsbench with
LEADING_EMPTY_SPACE=1.  I've skipped the NFS v2 stats because they're
all 0.

--- Run on bad kernel ---

[puffin:joe] $ uname -a
Linux puffin 2.6.15 #1 SMP Fri Mar 31 11:10:28 CEST 2006 i686 GNU/Linux
[puffin:joe] $ nfsstat 
Client rpc stats:
calls      retrans    authrefrsh
63         0          0       

<snip v2 stats>

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 11     18% 0       0% 26     42% 14     22% 0       0% 
read       write      create     mkdir      symlink    mknod      
4       6% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 4       6% 
fsstat     fsinfo     pathconf   commit     
0       0% 2       3% 0       0% 0       0% 
[puffin:joe] $ time ./nfsbench 

real    0m29.242s
user    0m0.000s
sys     0m0.160s
[puffin:joe] $ nfsstat 
Client rpc stats:
calls      retrans    authrefrsh
13240      0          0       

<snip v2 stats>

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 2583   19% 0       0% 30      0% 24      0% 0       0% 
read       write      create     mkdir      symlink    mknod      
7045   53% 3200   24% 1       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 34      0% 
fsstat     fsinfo     pathconf   commit     
0       0% 2       0% 0       0% 319     2% 

[puffin:joe] $

--- Run on good kernel ---

[puffin:joe] $ uname -a
Linux puffin 2.6.14.7 #1 SMP Fri Mar 31 10:41:59 CEST 2006 i686
GNU/Linux
[puffin:joe] $ nfsstat 
Client rpc stats:
calls      retrans    authrefrsh
52         0          0       

<snip v2 stats>

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 7      14% 0       0% 24     48% 13     26% 0       0% 
read       write      create     mkdir      symlink    mknod      
4       8% 0       0% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 2       4% 0       0% 0       0% 

[puffin:joe] $ time ./nfsbench 

real    0m0.224s
user    0m0.000s
sys     0m0.072s
[puffin:joe] $ nfsstat 
Client rpc stats:
calls      retrans    authrefrsh
384        0          0       

<snip v2 stats>

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 10      2% 1       0% 26      6% 15      3% 0       0% 
read       write      create     mkdir      symlink    mknod      
6       1% 321    84% 0       0% 0       0% 0       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
fsstat     fsinfo     pathconf   commit     
0       0% 2       0% 0       0% 1       0% 

[puffin:joe] $


-- 

 / jakob

