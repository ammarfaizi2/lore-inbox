Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTBJOk0>; Mon, 10 Feb 2003 09:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTBJOk0>; Mon, 10 Feb 2003 09:40:26 -0500
Received: from denise.shiny.it ([194.20.232.1]:56228 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id <S261426AbTBJOkZ>;
	Mon, 10 Feb 2003 09:40:25 -0500
Message-ID: <XFMail.20030210154959.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <20030210034808.7441d611.akpm@digeo.com>
Date: Mon, 10 Feb 2003 15:49:59 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: Andrew Morton <akpm@digeo.com>
Subject: Re: stochastic fair queueing in the elevator [Re: [BENCHMARK] 2.
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br,
       Andrea Arcangeli <andrea@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> You can wait 10 minutes and still such command can't grow.  This is why
>> claiming anticipatory scheduling can decrease the need for readahead
>> doesn't make much sense to me, there are important things you just can't
>> achieve by only waiting.
>> 
> 
> The anticipatory scheduler can easily permit 512k of reading before seeking
> away to another file.  In fact it can allow much more, without requiring that
> readhead be cranked up.

IMHO anticipatory scheduling and readahead address different problems. RA is
simpler and cheaper. Reading a few more KB comes almost for free and that
helps a lot sequential reads. AS is useful for random i/o (fs metadata,
executables, ...), but it wastes time if the timer expires, or if the new
request wants data which is far away the previous one. AS is useful for
sequential reads too, but only if the application reads large chunks of
data, otherwise RA is better. I we need both RA and AS to address the
largest variety of workloads.

Bye.
