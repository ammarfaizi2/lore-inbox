Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265431AbUEZKiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265431AbUEZKiK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 06:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265470AbUEZKiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 06:38:10 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:23910 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265431AbUEZKhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 06:37:55 -0400
Message-ID: <40B4737E.3050709@yahoo.com.au>
Date: Wed, 26 May 2004 20:37:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Roger Luethi <rl@hellgate.ch>, Anthony DiSante <orders@nodivisions.com>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <40B43B5F.8070208@nodivisions.com> <20040526082712.GA32326@k3.hellgate.ch> <200405260923.i4Q9NWTk000670@81-2-122-30.bradfords.org.uk> <20040526093007.GA4324@k3.hellgate.ch> <200405261035.i4QAZrGo000803@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405261035.i4QAZrGo000803@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Quote from Roger Luethi <rl@hellgate.ch>:
> 
>>On Wed, 26 May 2004 10:23:32 +0100, John Bradford wrote:
>>
>>>A run-away process on a server with too much swap can cause it to grind to
>>>almost a complete halt, and become almost compltely unresponsive to remote
>>>connections.
>>>
>>>If the total amount of storage is just enough for the tasks the server is
>>>expected to deal with, then a run-away process will likely be terminated
>>>quickly stopping it from causing the machine to grind to a halt.
>>
>>I'm not sure your optimism about the correct (run-away) process being
>>terminated is justified. Granted, there are definitely scenarios
>>where swapless operation is preferable, but in most circumstances --
>>especially workstations as the original poster described -- I'd rather
>>minimize the risk of losing data.
> 
> 
> Well, I am basing this on experience.  I know an ISP who had their main
> customer webserver down for hours because of this kind of problem - the whole
> thing created a lot of work and wasted a lot of time.
> 
> In this particular scenario, I think the run-away process was probably using
> up almost two thirds of the total RAM, so I'm pretty confident the correct
> process would have been terminated.
> 

I think this is somewhat orthogonal to whether swap should be
used or not.

What we should be doing here is enforcing the RSS rlimit. I
have a patch from Rik to do this which needs to be merged.

Hopefully this would give you the best case situation of
having only the runaway process really slow down, without
killing anything until the admin arrives.
