Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265578AbUEZNAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265578AbUEZNAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265587AbUEZNAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:00:23 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28166 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265578AbUEZM7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:59:32 -0400
Message-ID: <40B4953B.8070401@aitel.hist.no>
Date: Wed, 26 May 2004 15:01:47 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Roger Luethi <rl@hellgate.ch>, Anthony DiSante <orders@nodivisions.com>,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
References: <40B43B5F.8070208@nodivisions.com> <20040526082712.GA32326@k3.hellgate.ch> <200405260923.i4Q9NWTk000670@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200405260923.i4Q9NWTk000670@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

>Quote from Roger Luethi <rl@hellgate.ch>:
>  
>
>>On Wed, 26 May 2004 02:38:23 -0400, Anthony DiSante wrote:
>>    
>>
>>>Now I buy another 256MB of ram, so I have 512MB of real memory.  Why not 
>>>just disable my swap completely now?  I won't have increased my memory's 
>>>size at all, but won't I have increased its performance lots?
>>>
>>>Or, to make it more appealing, say I initially had 512MB ram and now I have 
>>>1GB.  Wouldn't I much rather not use swap at all anymore, in this case, on 
>>>my desktop?
>>>      
>>>
>>Swap serves another (often underrated) purpose: Graceful degradation.
>>
>>If you have a reasonably amount of swap space mounted, you will know
>>you are running out of RAM because your system will become noticeably
>>slower. If you have no swap whatsoever, your first warning will quite
>>possibly be an application OOM killed or losing data due to a failed
>>memory allocation.
>>
>>Think of the slowness of swap as a _feature_.
>>    
>>
>
>There is a very negative side to this approach as well, especially if users
>allocate excessive swap space.
>
>A run-away process on a server with too much swap can cause it to grind to
>almost a complete halt, and become almost compltely unresponsive to remote
>connections.
>
>If the total amount of storage is just enough for the tasks the server is
>expected to deal with, then a run-away process will likely be terminated
>quickly stopping it from causing the machine to grind to a halt.
>  
>
No.  Something will be terminated, not necessarily the "evil"
process. A runaway process can have quite a few server processes
killed before it eventually dies.   An attacker will of course
use processes that forks, so some remain and can keep
spending memory and process time.

ulimit is the way of limiting how much memory a user can use,
preventing this scenario.  Not setting up swap isn't.

>If, on the other hand, there is excessive storage, it can continue running
>for a long time, often consuming a lot of CPU.
>
>When the excess storage is physical RAM, this might not be particularly
>disasterous, but if it's swap space, it's much more likely to cause a serious
>drop in performance.
>
>  
>
Well, the process (or processes) can consume lots of cpu time
without swap too.  It can cause server processes to get killed (or
not get memory they need) and it can cause slowdowns ny
evicting nearly all program code from memory.

>For a desktop system, it might not be a big deal, but when it's an ISP's server
>in a remote data centre, it can create a lot of unnecessary work.
>
>  
>
Definitely use ulimit on such a machine.

Helge Hafting
