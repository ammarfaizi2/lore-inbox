Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262057AbUK3MXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262057AbUK3MXQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 07:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUK3MXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 07:23:15 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:31503 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262057AbUK3MWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 07:22:43 -0500
Message-ID: <41AC67B2.6010601@hist.no>
Date: Tue, 30 Nov 2004 13:29:38 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mitchell Blank Jr <mitch@sfgoth.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] relinquish_fs() syscall
References: <20041129114331.GA33900@gaz.sfgoth.com> <1101729087.20223.14.camel@localhost.localdomain> <20041129135559.GC33900@gaz.sfgoth.com>
In-Reply-To: <20041129135559.GC33900@gaz.sfgoth.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:

>Alan Cox wrote:
>  
>
>>A priviledged user can ioperm/iopl their way out.
>>    
>>
>
>OK, good point, at least on i386/x86_64.  So before jailing itself a task
>will have to take CAP_SYS_RAWIO out of its permitted set.  That shouldn't
>be too bad of a restriction for most programs to live with.
>
>  
>
>>On Llu, 2004-11-29 at 11:43, Mitchell Blank Jr wrote:
>>    
>>
>>>This has several benefits:
>>>
>>> * Considerably safer against root users in cage
>>>      
>>>
>>Pardon. Its equally ineffectual. It might take someone a week longer to
>>write the exploit but an hour after that its no different.
>>    
>>
>
>OK, could you please describe other attacks against it then?
>
>  
>
>>>   This is a big deal for privilege separation; currently it's hard to
>>>   implement except in a daemon that starts its life as root.  Now the
>>>   same techniques can be used by any process.
>>>      
>>>
>>That doesn't do name lookup, character set translation, or time (and a
>>few other things).
>>    
>>
>
>Alan - have you looked at privsep implementation in, say, opensshd.  The
>way privsep works is that you have two processes communicating over a
>UNIX domain socket.  One then jails itself and handles all the hairy
>untrusted data.  The unjailed process handles requests from inside as
>needed.  So if the program needs to do DNS lookups then your privsep
>protocol would include a primitive for doing that.
>  
>
So someone finds a way to break into the jailed process.
This is used to feed some hairy exploit to the unjailed
process that expects "clean" data from the jailed process.
Same as before, only now they need a two-stage exploit.

You can jail a process doing a "dangerous" job, but you can't
really jail a "hairy" data stream.  Not if data is expected to
emerge from the jail someday.

Helge Hafting
