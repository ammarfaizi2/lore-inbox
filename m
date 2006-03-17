Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWCQQtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWCQQtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCQQtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:49:53 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:29056 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751188AbWCQQtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:49:53 -0500
Message-ID: <441AE891.9060207@us.ibm.com>
Date: Fri, 17 Mar 2006 11:49:21 -0500
From: Janak Desai <janak@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linus Torvalds <torvalds@osdl.org>, Michael Kerrisk <mtk-manpages@gmx.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk,
       hch@lst.de, ak@muc.de, paulus@samba.org
Subject: Re: [PATCH] unshare: Cleanup up the sys_unshare interface before
 we are committed.
References: <Pine.LNX.4.64.0603161555210.3618@g5.osdl.org>	<29085.1142557915@www064.gmx.net>	<Pine.LNX.4.64.0603162140190.3618@g5.osdl.org> <m1y7z93vmu.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y7z93vmu.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>Linus Torvalds <torvalds@osdl.org> writes:
>
>  
>
>>On Fri, 17 Mar 2006, Michael Kerrisk wrote:
>>    
>>
>>>> - it's all the same issues that clone() has
>>>>        
>>>>
>>>At the moment, but possibly not in the future (if one day
>>>usnhare() needs a flag that has no analogue in clone()).
>>>      
>>>
>>I don't believe that.
>>
>>If we have something we might want to unshare, that implies by definition 
>>that it was something we wanted to conditionally share in the first place.
>>
>>IOW, it ends up being something that would be a clone() flag.
>>
>>So I really do believe that there is a fundamental 1:1 between the flags. 
>>They aren't just "similar". They are very fundamentally about the same 
>>thing, and giving two different names to the same thing is CONFUSING.
>>    
>>
>
>The scary thing is that with only 7 things we can share or not,
>and a 32bit field we have only 7 bits left that we can define.
>Last count I think I know of at least that many additional global
>namespaces in the kernel.
>
>
>
>On the confusing side.  Unshare largely because it doesn't default to
>unsharing all of the thread state.  Has the weird issue that unshare
>will automatically add bits you didn't ask for (so it can satisfy your
>request) and unsharing more than you requested.  Clone when presented
>with the same situation returns an error.
>  
>
We are probably digressing from the original discussion but just wanted to
point out that the situations presented to clone and unshare are a bit 
different.
Clone returns an error because in the same call you are trying to provide
illegal combination of flags. Like saying that you want a new namespace
but want to share the filesystem. There is no way for clone to know which
of the two flags to honor or ignore. Where as with unshare if you are
trying to unshare namespace but are currently sharing filesystem, then
it is possible to complete the request by unsharing filesystem as well .
You may remember that the earlier incarnation of the unshare patch did
return an error. However it was pointed out, and correctly so, that it is
better to unshare appropriate related contexts.

-Janak

>So even while the resources are the same the interaction of the
>bits really is quite different between the two calls.
>
>Eric
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

