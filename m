Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTLUBBP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 20:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTLUBBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 20:01:14 -0500
Received: from 12-211-67-128.client.attbi.com ([12.211.67.128]:411 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S261929AbTLUBBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 20:01:09 -0500
Message-ID: <3FE4F0D3.2020904@comcast.net>
Date: Sat, 20 Dec 2003 17:01:07 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicklas Bondesson <nikomail@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error mounting root fs on 72:01 using Promise FastTrak TX2000
 (PDC20271)
References: <BAY8-DAV26Mb5CIs4vP0000f52f@hotmail.com>
In-Reply-To: <BAY8-DAV26Mb5CIs4vP0000f52f@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicklas Bondesson wrote:
> Hi,
> 
> Oh I forgot to say that i'm running RAID1 and it detects both drives
> perfectly (I'm passing the IDE addresses to the kernel at boot time from the
> lilo conf, see previous post). The system was reinstalled yesterday with two
> brand new 80GB Western Digital disks (WD800JB-00DUA3). The thing is, I have
> succesfully installed the TX2000 card with the native ATARAID drivers before
> using two 30GB Maxtor (something) disks and kernel 2.4-20 - 2.4.23. I wonder
> why I can't get it up and running now. It will only work with the pre
> compiled kernel shipped with Debian 3.0 (2.4.18-bf2.4). I have tried all
> sorts of kernel settings. Since I have got it to work before I think should
> be able to do it again.
> 
> Please advise.  
> 
> /Nicke

Hmmm. I'm pretty sure that the partitions are enumerated the same way in 2.4.23
vs. 2.4.18.  There was a change in the way IDE geometry was returned from the
kernel that caused a hiccup in the pdcraid driver around 2.4.22 I think?  My
patch just tells the pdcraid to use an alternate method of finding the RAID
superblock on each drive. Not sure what else might be the problem. Do you see
the ataraid driver fire up (looking something like this):

ataraid/d0: ataraid/d0p1
Drive 0 is 239372 Mb (33 / 0)
Drive 1 is 239372 Mb (34 / 0)
Raid1 array consists of 2 drives.
Promise Fasttrak(tm) Softwareraid driver for linux version 0.03beta

The only problem I've recently come upon with pdcraid, is when it detects just
one of the drives and fails. I didn't think that should happen with raid1 though.


