Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264762AbUD2VHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264762AbUD2VHy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 17:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264738AbUD2UrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 16:47:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:1744 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264978AbUD2UlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 16:41:21 -0400
Date: Thu, 29 Apr 2004 13:42:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Isaacson <adi@hexapodia.org>
Cc: elf@buici.com, riel@redhat.com, brettspamacct@fastclick.com,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040429134222.291f83d4.akpm@osdl.org>
In-Reply-To: <20040429165116.GA24033@hexapodia.org>
References: <20040428180038.73a38683.akpm@osdl.org>
	<Pine.LNX.4.44.0404282143360.19633-100000@chimarrao.boston.redhat.com>
	<20040428185720.07a3da4d.akpm@osdl.org>
	<20040429022944.GA24000@buici.com>
	<20040428193541.1e2cf489.akpm@osdl.org>
	<20040429031059.GA26060@buici.com>
	<20040428201924.719dfb68.akpm@osdl.org>
	<20040429165116.GA24033@hexapodia.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Isaacson <adi@hexapodia.org> wrote:
>
> What I want is for purely sequential workloads which far exceed cache
> size (dd, updatedb, tar czf /backup/home.nightly.tar.gz /home) to avoid
> thrashing my entire desktop out of memory.  I DON'T CARE if the tar
> completed in 45 minutes rather than 80.  (It wouldn't, anyways, because
> it only needs about 5 MB of cache to get every bit of the speedup it was
> going to get.)  But the additional latency when I un-xlock in the
> morning is annoying, and there is no benefit.

What kernel version are you using?  If 2.6, what value of
/proc/sys/vm/swappiness?

> For a more useful example, ideally I *should not be able to tell* that
> "dd if=/hde1 of=/hdf1" is running.

I just did a 4GB `dd if=/dev/sda of=/x bs=1M' on a 1GB 2.6.6-rc2-mm2
swappiness=85 machine here and there was no swapout at all.

Probably your machine has less memory.  But without real, hard details
nothing can be done.

> There is *no* benefit to cacheing
> more than about 2 pages, under this workload.

Sure, we could do better things with the large streaming files, although
the risk of accidentally screwing up particular workloads is high.

But the use-once logic which we have in there at present does handle these
cases quite well.

>  But with current kernels,
> IME, that workload results in a gargantuan buffer cache and lots of
> swapout of apps I was using 3 minutes ago.  I've taken to walking away
> for some coffee, coming back when it's done, and "sudo swapoff
> /dev/hda3; sudo swapon -a" to avoid the latency that is so annoying when
> trying to use bloaty apps.

What kernel, what system specs, what swappiness setting?
