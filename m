Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267328AbUG1RDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267328AbUG1RDi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 13:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUG1RDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 13:03:38 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:15284 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267329AbUG1RDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 13:03:10 -0400
Message-ID: <4107DC4C.3040603@namesys.com>
Date: Wed, 28 Jul 2004 10:03:08 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Rutt <rutt.4+news@osu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: clearing filesystem cache for I/O benchmarks
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org> <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org> <4106013E.30408@namesys.com> <87vfg9nyqv.fsf@osu.edu> <410698FA.40400@namesys.com> <87k6wocnmk.fsf@osu.edu>
In-Reply-To: <87k6wocnmk.fsf@osu.edu>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Rutt wrote:

>Hans Reiser <reiser@namesys.com> writes:
>
>  
>
>>fsync performance gives you different performance.  Better to write
>>more stuff to flush the cache.
>>    
>>
>
>I'm trying to understand how that would work.  Let's take an example
>of a 64GB file that I'm writing out from scratch.  I start a timer
>before writing.  With my fsync() way of testing, I expect to stop the
>timer the moment last byte has been written and fsync() has been
>called.
>
>I gather you're saying that continuing writing past the 64GB mark,
>causing LRU expiration of the last bytes of the 64GB bytes from write
>buffers is a more fair way to test, versus just calling fsync() once
>at the end.  I'm happy to write my benchmarks this way too, except I
>need to know two configuration values now:
>
>1) when to stop the timer?
>2) how much more to write past 64GB?
>  
>
Probably the best you can do is write enough in the course of the test 
that fsync at the end (or data remaining in cache) is insignificant 
noise.  Benchmarks that make fsync or the cache significant 
unintentionally are common and bad.

>  
>
>>> Not including
>>>fsync() time would only test the ability of the various parts of the
>>>I/O systems to do write buffering.  It's easy to do lots of write
>>>buffering, if you buy enough memory.  Forcing the disks to write is
>>>the only fair way to compare writes between I/O systems.
>>> 
>>>
>>>      
>>>
>>It isn't fair.  fsync is a different code path, and may be less
>>efficient.  Or more, depending on the fs.  reiser4 is currently not
>>well optimized for fsync, maybe next year I will change that but not
>>this week....
>>    
>>
>
>I think we agree that forcing the disks to write all of the data
>before the timer stops is a fair way to compare between filesystems.
>Otherwise we're "almost" measuring disk throughput, except for what
>has been write-buffered...a real gray area.  But I think you're
>pointing out that the results could be different depending on whether
>the fsync() method or your "write past the intented amount" method for
>flushing is used.  I'd be happy to run these benchmarks both ways, as
>long as I knew how.  If you can help me answer my above questions,
>I'll run them both ways.
>
>Thanks,
>  
>

