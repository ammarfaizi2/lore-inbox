Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265336AbUBFJ0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 04:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265338AbUBFJ0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 04:26:43 -0500
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:89 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S265336AbUBFJ0i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 04:26:38 -0500
Message-ID: <40235DCC.2060606@ntlworld.com>
Date: Fri, 06 Feb 2004 09:26:36 +0000
From: Matt <dirtbird@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.4-6 StumbleUpon/1.87
X-Accept-Language: en, en-gb, ja
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VFS locking: f_pos thread-safe ?
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org>
In-Reply-To: <20040206011630.42ed5de1.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Matt <dirtbird@ntlworld.com> wrote:
>  
>
>>>Werner Almesberger <wa@almesberger.net> wrote:
>>>      
>>>
>>>>"[...] read( ) [...] shall be atomic with respect to each other
>>>>  in the effects specified in IEEE Std. 1003.1-200x when they
>>>>  operate on regular files. If two threads each call one of these
>>>>  functions, each call shall either see all of the specified
>>>>  effects of the other call, or none of them."
>>>>        
>>>>
>>>Whichever thread finishes its read last gets to update f_pos.
>>>      
>>>
>>>I'm struggling a bit to understand what they're calling for there.  If
>>>thread A enters a read and then shortly afterwards thread B enters the
>>>read, does thread B see an f_pos which starts out at the beginning of A's
>>>read, or the end of it?
>>>      
>>>
>>>Similar questions apply as the threads exit their read()s.
>>>      
>>>
>>>Either way, there's no way in which we should serialise concurrent readers.
>>>That would really suck for sensible apps which are using pread64().
>>>      
>>>
>>Surely, we can just serialise read() (and related) calls that modify f_pos?
>>Since pread() doesn't modify f_pos we shouldn't need to serialise those calls
>>no? Also doesn't spec make the same claims about other calls that modify
>>f_pos such as write()?
>>    
>>
>
>We could do somethnig like that.
>
>But is there any application in which two threads simultaneously perform
>read() against the same fd which is not already buggy?
>
>
>  
>
touché :) but still we should do what we can.. want me to make a patch?

    Matt

