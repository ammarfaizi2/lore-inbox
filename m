Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263731AbUC3QUb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 11:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263736AbUC3QUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 11:20:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263731AbUC3QU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 11:20:26 -0500
Message-ID: <40699E37.2020403@pobox.com>
Date: Tue, 30 Mar 2004 11:20:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Andrea Arcangeli <andrea@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       William Lee Irwin III <wli@holomorphy.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <200403282030.11743.bzolnier@elka.pw.edu.pl> <20040328183010.GQ24370@suse.de> <200403282045.07246.bzolnier@elka.pw.edu.pl> <406720A7.1050501@pobox.com> <20040329005502.GG3039@dualathlon.random> <40679FE3.3080007@pobox.com> <20040329130410.GH3039@dualathlon.random> <40687CF0.3040206@pobox.com> <20040330110928.GR24370@suse.de>
In-Reply-To: <20040330110928.GR24370@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> Here's a quickly done patch that attempts to adjust the value based on a
> previous range of completed requests. It changes ->max_sectors to be a
> hardware limit, adding ->optimal_sectors to be our max issued io target.
> It is split on READ and WRITE. The target is to keep request execution
> time under BLK_IORATE_TARGET, which is 50ms in this patch. read-ahead
> max window is kept within a single request in size.
> 
> So this is pretty half-assed, but it gets the point across. Things that
> should be looked at (meaning - should be done, but I didn't want to
> waste time on them now):
> 
> - I added the hook to see how many in-drive queued requests you have, so
>   there's the possibility to add tcq knowledge as well.
> 
> - The optimal_sectors calculation is just an average of previous maximum
>   with current maximum. The scheme has a number of break down points,
>   for instance writes starving reads will give you a bad read execution
>   time, further limiting ->optimal_sectors[READ]


Makes me pretty happy... :)

	Jeff



