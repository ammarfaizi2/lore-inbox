Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbULFS6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbULFS6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 13:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbULFS5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 13:57:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33936 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261611AbULFSz0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 13:55:26 -0500
Date: Mon, 6 Dec 2004 10:57:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Per Jessen <per@computer.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 - kswapd excessive cpu usage under heavy IO
Message-ID: <20041206125715.GA2393@dmt.cyclades>
References: <200412061214.48754.per@computer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200412061214.48754.per@computer.org>
User-Agent: Mutt/1.4i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

On Mon, Dec 06, 2004 at 12:14:48PM +0100, Per Jessen wrote:
> (apologies if this is sent more than once)
> I've found similar incidences in the archives, but none that indicates that a
> solution was found. 
> I'm seeing excessive cpu usage by kswapd on a 4way 500MHZ Xeon with 2GB RAM.

What is your workload? Except the massive amount of inode's/dentries in your 
system do you have anonymous memory hungry applications running? 

If you do have a significant amount of anonymous pages on your system you might
want to try 2.4.29-pre1 which contains a VM change which should decrease their 
impact on the VM page freeing efforts (including kswapd CPU usage).

Since you have massive amount of inodes/dentries you might want to tweak
/proc/sys/vm/vm_vfs_scan_ratio (increase from 6 to 10 and so on...)

>  A find in a directory containing perhaps 6-700,000 files makes the box almost
> grind to a halt.  In 12days uptime, kswap has used 590:43.82, and during the
> find-exercise usually runs with 90-100% util.

Can you boot with profile=2 and use readprofile tool to read the functions which 
are using most CPU time with

readprofile | sort -nr +2 | head -20

Do that on a 2.4.28 and 2.4.29-pre1 kernels.

> The file-system is 150GB with JFS117 on a software-RAID5 - not exactly optimal,
> I agree, but reasonably workable.
> 
> I've read that 2.6 has significant improvements in this area, but upgrading is
> not currently an option.  

Yes, v2.6 VM design is way better than v2.4's in many aspects.

