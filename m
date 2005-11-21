Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVKUUry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVKUUry (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVKUUrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:47:53 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:53658 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S932349AbVKUUrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:47:53 -0500
Date: Mon, 21 Nov 2005 15:47:52 -0500
To: Lars Roland <lroland@gmail.com>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Poor Software RAID-0 performance with 2.6.14.2
Message-ID: <20051121204752.GK9488@csclub.uwaterloo.ca>
References: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad99e050511211231o97d5d7fw59b44527dc25dcea@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 09:31:14PM +0100, Lars Roland wrote:
> I have created a stripe across two 500Gb disks located on separate IDE
> channels using:
> 
> mdadm -Cv /dev/md0 -c32 -n2 -l0 /dev/hdb /dev/hdd

Does -l0 equal stripe or linear?  The mdadm man page doesn't seem clear
o that to me.

If it defaults to linear, then you shouldn't expect any performance gain
since that would just stick one drive after the other (no striping).
Try explicitly statping -l stripe instead of -l 0.

> the performance is awful on both kernel 2.6.12.5 and 2.6.14.2 (even
> with hdparm and blockdev tuning), both bonnie++ and hdparm (included
> below) shows a single disk operating faster than the stripe:
> 
> ----
> dkstorage01:~# hdparm -t /dev/md0
> /dev/md0:
>  Timing buffered disk reads:  182 MB in  3.01 seconds =  60.47 MB/sec
> 
> dkstorage02:~# hdparm -t /dev/hdc1
> /dev/hdc1:
> Timing buffered disk reads:  184 MB in  3.02 seconds =  60.93 MB/sec

How about at least testing one of the drives involved in the raid,
although I assume they are identical in your case given the numbers.

Did you test this with other kernel versions (older ones) to see if it
was better in the past?

Any idea where the ide controller is connected?  If it is PCI the whole
bus only has 133MB/s to give on many systems (some have more of course),
so maybe 60M/s is quite good.

Len Sorensen
