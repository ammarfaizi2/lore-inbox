Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUC3RwG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbUC3Rv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:51:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42184 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263779AbUC3RvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:51:01 -0500
Message-ID: <4069B376.9010104@pobox.com>
Date: Tue, 30 Mar 2004 12:50:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Jens Axboe <axboe@suse.de>, Andrea Arcangeli <andrea@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de> <4069B6F8.1020506@techsource.com>
In-Reply-To: <4069B6F8.1020506@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Jens Axboe wrote:
> 
>> - The optimal_sectors calculation is just an average of previous maximum
>>   with current maximum. The scheme has a number of break down points,
>>   for instance writes starving reads will give you a bad read execution
>>   time, further limiting ->optimal_sectors[READ]
> 
> 
> 
> I did look through your code a bit, but one thing to be concerned with 
> is that going only on max throughput might be fooled by cache hits on 
> the drive.


If you are taking your samples over time, that shouldn't matter...  if 
the system workload is such that you are hitting the drive cache the 
majority of the time, you're not being "fooled" by cache hits, the patch 
would be taking those cache hits into account.

If the system isn't hitting the drive cache the majority of the time, 
statistical sampling will automatically notice that too...

	Jeff



