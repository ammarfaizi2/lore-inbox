Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265032AbUD3AOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265032AbUD3AOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 20:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265033AbUD3AOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 20:14:15 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:41101 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S265032AbUD3AON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 20:14:13 -0400
Message-Id: <5.1.0.14.2.20040430101224.04275210@171.71.163.14>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 30 Apr 2004 10:14:09 +1000
To: Andy Isaacson <adi@hexapodia.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Cc: Andrew Morton <akpm@osdl.org>, Marc Singer <elf@buici.com>,
       riel@redhat.com, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040429165116.GA24033@hexapodia.org>
References: <20040428201924.719dfb68.akpm@osdl.org>
 <20040428180038.73a38683.akpm@osdl.org>
 <Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
 <20040428185720.07a3da4d.akpm@osdl.org>
 <20040429022944.GA24000@buici.com>
 <20040428193541.1e2cf489.akpm@osdl.org>
 <20040429031059.GA26060@buici.com>
 <20040428201924.719dfb68.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:51 AM 30/04/2004, Andy Isaacson wrote:
>What I want is for purely sequential workloads which far exceed cache
>size (dd, updatedb, tar czf /backup/home.nightly.tar.gz /home) to avoid
>thrashing my entire desktop out of memory.  I DON'T CARE if the tar
>completed in 45 minutes rather than 80.  (It wouldn't, anyways, because
>it only needs about 5 MB of cache to get every bit of the speedup it was
>going to get.)  But the additional latency when I un-xlock in the
>morning is annoying, and there is no benefit.
>
>For a more useful example, ideally I *should not be able to tell* that
>"dd if=/hde1 of=/hdf1" is running. [1]  There is *no* benefit to cacheing
>more than about 2 pages, under this workload.  But with current kernels,
>IME, that workload results in a gargantuan buffer cache and lots of
>swapout of apps I was using 3 minutes ago.  I've taken to walking away
>for some coffee, coming back when it's done, and "sudo swapoff
>/dev/hda3; sudo swapon -a" to avoid the latency that is so annoying when
>trying to use bloaty apps.

the mechanism already exists; teach tar/dd and any other app that you don't 
want to pollute the page-cache with data with to use O_DIRECT.

i suspect updatedb is a different case as its probably filling the system 
with dcache/inode entries.


cheers,

lincoln.

