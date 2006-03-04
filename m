Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWCDOSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWCDOSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 09:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751540AbWCDOSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 09:18:31 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:43669 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751534AbWCDOSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 09:18:30 -0500
Date: Sat, 4 Mar 2006 19:47:17 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
Message-ID: <20060304141717.GA456@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060304.022546.85833873.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060304.022546.85833873.davem@davemloft.net>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 02:25:46AM -0800, David S. Miller wrote:
> 
> I just wanted to report that I am hitting the "VFS: file-max limit xxx
> reached" problem quite easily on my 32-cpu Niagara machine with 16GB
> of ram with current 2.6.x GIT.
> 
> It seems far too easy to get a box into this state due to SLAB
> fragmentation and RCU.  And once you get a machine into this state it
> is totally unusable.
> 
> Our test case is usually a "make -j8192" kernel build along with a
> parallel bootstrap of gcc.  That puts about 256 processes on each
> cpu's runqueue, I doubt ksoftirqd can run much at all.

Dave, there is a set of patches in -mm that may handle this
better -

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/rcu-batch-tuning.patch
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/fix-file-counting.patch
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/broken-out/fix-file-counting-fixes.patch

Could you please try this in your setup ?

The rcu-batch tuning patch provides automatic switching to
process as many RCUs as possible if too many of them are queued.
The file counting fixes count the file structures correctly.

Thanks
Dipankar
