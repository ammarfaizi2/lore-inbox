Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTEZXqN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 19:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTEZXqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 19:46:13 -0400
Received: from dyn-ctb-210-9-245-13.webone.com.au ([210.9.245.13]:12804 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S262371AbTEZXqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 19:46:11 -0400
Message-ID: <3ED2AA37.4000304@cyberone.com.au>
Date: Tue, 27 May 2003 09:58:47 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jens Axboe <axboe@suse.de>, James Bottomley <James.Bottomley@SteelEye.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
References: <Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0305261429550.13489-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus Torvalds wrote:

>On Mon, 26 May 2003, Jens Axboe wrote:
>
>>>Think of all the fairness issues we've had in the elevator code, and 
>>>realize that the low-level disk probably implements _none_ of those 
>>>fairness algorithms.
>>>
>>I think it does, to some extent at least.
>>
>
>I doubt they do a very good job of it. I know of bad cases, even with 
>"high-end" hardware. Sure, we can hope that it's getting better, but do we 
>want to bet on it.
>
>
>>>Hmm.. Where does it keep track of request latency for requests that have 
>>>been removed from the queue?
>>>
>>Well, it doesn't...
>>
>
>Yeah. Which means that right now _really_ long starvation will show up as
>timeouts, while other cases will just show up as bad latency.
>
There is an elevator notifier which is called on request
completion in Andrew's tree (needed for AS io scheduler). This
can be used to do what you want.

