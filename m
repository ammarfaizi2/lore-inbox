Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUC2TqW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 14:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263120AbUC2TqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 14:46:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24204 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263107AbUC2TqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 14:46:10 -0500
Message-ID: <40687CF0.3040206@pobox.com>
Date: Mon, 29 Mar 2004 14:45:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random>
In-Reply-To: <20040329130410.GH3039@dualathlon.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Once you change the API too, then you can set the hardwre limit in your
> driver and relay on the highlevel blkdev code to find the optimal runtime
> dma size for bulk I/O, but today it's your driver that is enforcing a
> runtime bulk dma size, not the maximim limit of the controller, and so
> you should code your patch accordingly.

This magic 512k or 1M limit has nothing to do with SATA.  It's a magic 
number whose definition is "we don't want PATA or SATA or SCSI disks 
doing larger requests than this for latency, VM, and similar reasons."

That definition belongs outside the low-level SATA driver.

This 512k/1M value is sure to change over time, which involves 
needlessly plugging the same value into multiple places.  And when such 
changes occurs, you must be careful not to exceed hardware- and 
errata-based limits -- of which there is no distinction in the code.

I think the length of this discussion alone clearly implies that the 
low-level driver should not be responsible for selecting this value, if 
nothing else ;-)

	Jeff



