Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbUAPXza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUAPXza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 18:55:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:51436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265942AbUAPXz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 18:55:27 -0500
Date: Fri, 16 Jan 2004 15:56:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravi Wijayaratne <ravi_wija@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux Page Cache performance
Message-Id: <20040116155645.732e1fda.akpm@osdl.org>
In-Reply-To: <20040116191102.98783.qmail@web40602.mail.yahoo.com>
References: <20040116191102.98783.qmail@web40602.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravi Wijayaratne <ravi_wija@yahoo.com> wrote:
>
> Hi All.
> 
> We are running dbench on a machine with Dual Xeon (Hyper threading 
> turned off), 1GB RAM
> and 4 Drive software RAID5. The kernel is 2.4.29-xfs 1.2. We are using 
> LVM. However
> similar test done using ext2 on a disk partiotion (no md or LVM) shows 
> 
> The throughput is find till the number of clients are Around 16. At 
> that point the throughput
> plummets about 40%. We are trying to avoid that and see how we could 
> have a consistent throughput
> perhaps sacrificing some peak performance.

Once the amount of dirty memory in the machine hits 40% of the total, the
VM starts to initiate writeout.  At 60% dirty the VM starts to deliberately
throttle the processes which are dirtying memory.

So you would expect to see extremely sudden transitions in overall
throughput at that point.  Note that if the test were to run for a longer
period of time, or if it were to leave the files behind rather than
suddenly removing them you would not notice this effect.


The probability that dbench's access patterns have any similarity to the
access patterns of the application which you care about is vanishingly
small.  The same can most probably be said of all the other off-the-shelf
benchmarks.  They're not very impressive.

You will need to analyse your application's access patterns and design a
benchmark which reasonably closely and repeatably models them.  Or, if
possible, use the live application itself.

