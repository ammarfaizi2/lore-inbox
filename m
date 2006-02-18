Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbWBRMrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbWBRMrx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbWBRMrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:47:53 -0500
Received: from 216.255.188.82-custblock.intercage.com ([216.255.188.82]:42710
	"EHLO main.astronetworks.net") by vger.kernel.org with ESMTP
	id S1751210AbWBRMrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:47:52 -0500
From: =?iso-8859-1?q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
Reply-To: edwin@gurde.com
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2.6.15.4 1/1][RFC] ipt_owner: inode match supporting both incoming and outgoing packets
Date: Sat, 18 Feb 2006 14:47:31 +0200
User-Agent: KMail/1.9.1
Cc: netfilter-devel@lists.netfilter.org, fireflier-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, martinmaurer@gmx.at
References: <200602181410.59757.edwin.torok@level7.ro> <200602181432.14483.edwin@gurde.com> <20060218123720.GA1811@infradead.org>
In-Reply-To: <20060218123720.GA1811@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602181447.31592.edwin@gurde.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - main.astronetworks.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - gurde.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 February 2006 14:37, Christoph Hellwig wrote:
> On Sat, Feb 18, 2006 at 02:32:14PM +0200, T?r?k Edwin wrote:
> > Is there an alternative for locking the tasklist, and iterating through
> > all the threads to: find out the struct task*  given a struct
> > fown_struct*. Or is there any other way to find out the inode, and
> > mountpoint of that process?
>
> no, and a driver shouldn't do that. 
Ok, can a kernel function that is not part of a driver do that? Something 
like: get_task_from_fown(..), or get_inode_of_process_fown(..)?
> This might sound harsh, but I'd say 
> what you're trying to do is fundamentally doomed ;-)
Since Luke's patch didn't got accepted, I wasn't expecting mine to be.
But I am not giving up this easily. There has to be a way to solve this 
problem. As a last resort, I'll try to maintain this as separate patch to be 
applied to the kernel, but that is something I'd really try to avoid, 
because:
- it would need updating with every kernel version => each kernel version a 
new patch
- fixing bugs would take N times longer (N=kernel version - initial kernel 
version)
- I am no kernel hacker, so I am not the appropiate person to maintain such a 
patch
....

Even if all of it can't be done inside the kernel, I'd like to do as much as I 
can of it, and maybe leave the rest to userspace. (By exporting needed stuff 
via /proc, or /sys, such as socket/inode mappings, socket/process mappings). 
But I believe the proper place to do this is inside the kernel.

Patrick McHardy ([1]) said that SELinux should do this, and it will be ready 
soon. How would SELinux accomplish this?

[1] https://bugzilla.netfilter.org/bugzilla/show_bug.cgi?id=449
