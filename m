Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264162AbUDGTms (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264173AbUDGTms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:42:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57572 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264162AbUDGTmr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:42:47 -0400
Message-ID: <407459A2.4030009@pobox.com>
Date: Wed, 07 Apr 2004 15:42:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
CC: akpm@odsl.org, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss updates for 2.6.6xxx [1/2]
References: <D4CFB69C345C394284E4B78B876C1CF105BC2012@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF105BC2012@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miller, Mike (OS Dev) wrote:
> I like the idea of capping max commands based on the number of arrays. One problem is that we can add or remove a logical drive during runtime. How would Linux handle us reshuffling the max commands for each queue?


What is the maximum number of logical drives?

If you always assume the maximum number of logical drives are configured 
(let's say 32), then you can calculate based on that:
	1024 / 32 logical drives == 32 commands per logical drive

It certainly gets a bit more complex, if you truly want to handle 
something other than "hardcode max # of logical drives"...  I would 
suggest going to a round-robin anti-starvation approach at that point, 
like what I do in carmel.c.  The Carmel hardware has a single hardware 
queue for all of its 8 SATA ports, which is similar to cciss having 1024 
commands for all of its logical drives (if I understand things correctly).

	Jeff



