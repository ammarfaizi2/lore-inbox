Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261395AbVCNRGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261395AbVCNRGY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVCNRGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:06:24 -0500
Received: from c7ns3.center7.com ([216.250.142.14]:4761 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S261395AbVCNRGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:06:02 -0500
Message-ID: <4235C251.7000801@utah-nac.org>
Date: Mon, 14 Mar 2005 09:56:49 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@shaw.ca>
Cc: Dan Stromberg <strombrg@dcs.nac.uci.edu>, linux-kernel@vger.kernel.org
Subject: Re: huge filesystems
References: <pan.2005.03.09.18.53.47.428199@dcs.nac.uci.edu> <20050314164137.GC1451@schnapps.adilger.int>
In-Reply-To: <20050314164137.GC1451@schnapps.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running the DSFS file system as a 7 TB file system on 2.6.9. There 
are a host
of problems with the current VFS, ad I have gotten around most of them 
by **NOT** using the linux page cache interface. The VFS I am using 
creates a virtual represeation of the files and it's own cache. You need 
a lot of memory - 2GB roughly. The only way to do it at present is to 
use the address patch that reserves 1GB for user address space and 
leaves 3GB of space
in kernel in order to create the caches.

You also need to ignore the broken fdisk partitioning tools. Just create 
one partition if you
create disks larger than 2 TB with 3Ware, and ignore the values in the 
table. I check for a single partition on these devices and rely on the 
capacity parameter reported from the
bdev handle and just use the extra space.

Linux proper has a long way to go on this topic, but it is possible I am 
doing this today
on 2.6.9.

Jeff


