Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263273AbVBDJcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbVBDJcW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 04:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbVBDJcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 04:32:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:431 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263251AbVBDJcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 04:32:08 -0500
Date: Fri, 4 Feb 2005 01:32:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Godin <Ian.Godin@lowrydigital.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Drive performance bottleneck
Message-Id: <20050204013204.378cbbee.akpm@osdl.org>
In-Reply-To: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Godin <Ian.Godin@lowrydigital.com> wrote:
>
> 
>    I am trying to get very fast disk drive performance and I am seeing 
> some interesting bottlenecks.  We are trying to get 800 MB/sec or more 
> (yes, that is megabytes per second).  We are currently using 
> PCI-Express with a 16 drive raid card (SATA drives).  We have achieved 
> that speed, but only through the SG (SCSI generic) driver.  This is 
> running the stock 2.6.10 kernel.  And the device is not mounted as a 
> file system.  I also set the read ahead size on the device to 16KB 
> (which speeds things up a lot):
> ...
> samples  %        symbol name
> 848185    8.3510  __copy_to_user_ll
> 772172    7.6026  do_anonymous_page
> 701579    6.9076  _spin_lock_irq
> 579024    5.7009  __copy_user_intel
> 361634    3.5606  _spin_lock
> 343018    3.3773  _spin_lock_irqsave
> 307462    3.0272  kmap_atomic
> 193327    1.9035  page_fault

Something funny is happening here - it looks like there's plenty of CPU
capacity left over.

It's odd that you're getting a lot of pagefaults in this test but not with
the sg_dd test, too.  I wonder why dd is getting so many pagefaults?  (I
recall that sg_dd did something cheaty, but I forget what it was).

Could you monitor the CPU load during the various tests?  If the `dd'
workload isn't pegging the CPU then it could be that there's something
wrong with the I/O submission patterns.
