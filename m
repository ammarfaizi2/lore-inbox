Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265599AbUFDEdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265599AbUFDEdV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUFDEdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:33:21 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:23614 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265588AbUFDEdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:33:05 -0400
Date: Fri, 4 Jun 2004 15:29:54 +1000
From: Nathan Scott <nathans@sgi.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
Subject: Re: xfs corruption or not
Message-ID: <20040604052953.GE13756@frodo>
References: <40BFDB13.7000901@cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BFDB13.7000901@cornell.edu>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 08:14:43PM -0600, Ivan Gyurdiev wrote:
> ...
> errors. I also did an xfs_repair on the system, which corrected problems..
> 
> However, thunderbird still generates the following oops, and then it 
> becomes unkillable. Do you think this is most likely due to:
> - memory is still defective
> - there's corruption on-disk which isn't fixed
> or
> - this is an actual bug in xfs
> 
> Note that there's no input/output errors after the oops, and only 
> thunderbird causes this (so far).

Do you know if the kernel was low on memory at the time?  (any
signs of allocation failures in your system log?)

This looks like a memory allocation failure which hasn't been
gracefully handled (or approriately retried) in XFS - there's
a few patches being worked on to improve this, but they aren't
ready to be merged in just yet.

> EFLAGS: 00010206   (2.6.6-1.406)
> EIP is at xfs_bmbt_set_all+0x2f/0x5c [xfs]
> Process thunderbird-bin (pid: 3799, threadinfo=04b32000 task=041aadf0)

> [<0a8c48f7>] xfs_bmap_insert_exlist+0x97/0xae [xfs]
> [<0a8c1cc7>] xfs_bmap_add_extent_hole_delay+0x42f/0x485 [xfs]

cheers.

-- 
Nathan
