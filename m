Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266346AbTGJNav (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269265AbTGJNav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:30:51 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:48651 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S266346AbTGJNau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:30:50 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Date: Thu, 10 Jul 2003 13:45:30 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bejqlq$q83$1@news.cistron.nl>
References: <bejhrj$dgg$1@news.cistron.nl> <20030710112728.GX15452@holomorphy.com> <bejnl9$m9l$1@news.cistron.nl> <Pine.LNX.4.53.0307100918410.203@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1057844730 26883 62.216.29.200 (10 Jul 2003 13:45:30 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0307100918410.203@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>On Thu, 10 Jul 2003, Miquel van Smoorenburg wrote:
>
>> As I said I've got plenty memory free ... perhaps I need to tune
>> /proc/sys/vm because I've got so much streaming I/O ? Possibly,
>> there are too many dirty pages so cleaning them out faster might
>> help (and let pflushd do it instead of my single-threaded app)
>>

I did the tuning now, but it did not help much. Alas.

>The problem, as I see it, is that you can dirty pages 10-15 times
>faster than they can be written to disk. So, you will always
>have the possibility of an OOM situation as long as you are I/O
>bound. FYI, you can read/write RAM at 1,000+ megabytes/second, but
>you can only write to disk at 80 megabytes/second with the fastest
>SCSI around, 40 megabytes/second with ATA, 20 megabytes/second with
>IDE/DMA, 10 megabytes/second with PIOW, etc. There just aren't
>any disks around that will run at RAM speeds so buffered I/O will
>always result in full buffers if the I/O is sustained. To completely
>solve the OOM situation requires throttling the generation of data.

My disks are fast enough - under 2.5.74-vanilla, no problem.

>It is only when the data generation rate is less than or equal to
>the data storage rate that you can generate data forever.
>
>A possibility may be to not return control to the writing process
>(including swap), until the write completes if RAM gets low.

That's what can be tuned with /proc/sys/vm/dirty_ratio , right ?
If I understand Documentation/filesystems/proc.txt correctly.

Mike.

