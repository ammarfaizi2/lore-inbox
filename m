Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271714AbRIUHuP>; Fri, 21 Sep 2001 03:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271769AbRIUHt4>; Fri, 21 Sep 2001 03:49:56 -0400
Received: from mail1.svr.pol.co.uk ([195.92.193.18]:42506 "EHLO
	mail1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S271714AbRIUHtt>; Fri, 21 Sep 2001 03:49:49 -0400
Message-ID: <3BAAF129.1090104@humboldt.co.uk>
Date: Fri, 21 Sep 2001 08:50:01 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4+) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Thomas Sailer <sailer@scs.ch>, linux-kernel@vger.kernel.org
Subject: Re: via82cxxx_audio locking problems
In-Reply-To: <Pine.LNX.3.96.1010920112905.26319I-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> On Thu, 20 Sep 2001, Thomas Sailer wrote:
>>   Dropping and reacquiring syscall_sem around interruptible_sleep_on
>>   in via_dsp_do_read, via_dsp_do_write and via_dsp_drain_playback
>>   should solve the problem. Does anyone see a problem with this?


> Is there a possibility of do_read being re-entered during that window?
> I agree its a problem but the solution sounds racy?

What's probably needed is one semaphore to lock read/write and ioctls 
that look at the playback engine, and another semaphore to lock accesses 
to the AC97 codec. That may be simpler to implement than dropping and 
releasing the syscall_sem.

-- 
Adrian Cox   http://www.humboldt.co.uk/

