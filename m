Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752024AbWG1QCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbWG1QCu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWG1QCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:02:49 -0400
Received: from palrel13.hp.com ([156.153.255.238]:1676 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1752024AbWG1QCt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:02:49 -0400
Message-ID: <44CA3523.9020000@hp.com>
Date: Fri, 28 Jul 2006 12:02:43 -0400
From: Mark Seger <Mark.Seger@hp.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: Accuracy of disk statistics IO counter
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Awhile back I had suggested moving the place in the block driver logic 
where stats get updated to more accurately reflect what was happening at 
the time they were actually sent to the drivers and I believe they were 
indeed made in the 2.6.15 timeframe.  I've recently started taking 
closer look at the numbers and while the sector counts look correct I'm 
not sure I'd agree with the number of I/Os being reported and believe 
they can be off by maybe 15% or more.

Specifically, I wrote a 1GB file with a blocksize of 1MB, which would 
result in 1000 writes at the application level.  What I believe then 
happens is that each write turns into 8 128KB requests to the driver, 
which should result in 8000 actual writes.  Toss in metadata operations 
and who knows what else and the actual number should be a little 
higher.  What I've see after repeating the tests a number of times on 
2.6.16-27 is numbers ranging from 6800-7000 writes which feels like a 
big enough difference to at least point out.

-mark


