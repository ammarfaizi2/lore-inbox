Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268866AbUHUGYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268866AbUHUGYX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 02:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268867AbUHUGYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 02:24:23 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:57243 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S268866AbUHUGYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 02:24:15 -0400
Message-ID: <4126EA8F.6050807@namesys.com>
Date: Fri, 20 Aug 2004 23:24:15 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Anton Blanchard <anton@samba.org>, riel@redhat.com,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Vladimir Demidov <demidov@namesys.com>
Subject: Re: 2.6.8.1-mm2 - reiser4
References: <Pine.LNX.4.44.0408201753250.4192-100000@chimarrao.boston.redhat.com>	<Pine.LNX.4.44.0408201852140.4192-100000@chimarrao.boston.redhat.com>	<20040820232050.GI1945@krispykreme> <20040820163426.2c6d4cb8.akpm@osdl.org>
In-Reply-To: <20040820163426.2c6d4cb8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Anton Blanchard <anton@samba.org> wrote:
>  
>
>>    
>>
>>
>
>It's my understanding that sys_reiser4() is basically defunct
>
I would say unfinished and in need of a code review by me before anyone 
starts using it, instead of defunct.  There is no good reason for it to 
be sent to Andrew as a patch file, and the guy responsible is on 
vacation.  What it should be in as is an experimental do not touch 
config option turned off by default.

sys_reiser4 is needed for these purposes:

* to eliminate the (otherwise valid) argument that it is more 
performance efficient for attributes to be accessed via an API that is 
different from files, by allowing multiple files to be accessed in one 
system call

* to bundle multiple filesystem operations into one atomic write

* to prepare the groundwork for the semantic enhancements described in 
www.namesys.com/whitepaper.html

* to define a standard interface that users will find uniform across all 
apps for this functionality

* to allow VFS to remain undisturbed in the eyes of legacy apps while 
semantic enhancements go into the filesystem namespace in a form that is 
less crippled by compatibility issues.

Now that the core reiser4 functionality is stable, the lead programmers 
and I can spare some time to review sys_reiser4 and the compression 
plugin (also not yet ready for prime time).  This will take us 6-12 
weeks I would guess, as Digeo is keeping us 50% busy with work that 
earns our paychecks at the moment, darpa is also keeping me busy with 
www.namesys.com/blackbox.html, and I expect there will be a few bugs 
found in the core code over the next few months also.

> at this point.
>
>It will probably be revived at some time in the future but we'd be best
>off crossing that bridge when we arrive at it, and ignoring the syscall
>part of the code at this time.
>
>For review purposes it would be better if the syscall code and all the
>namesys debug support code simply weren't present in the patch.  But one
>can sympathise with the need to keep it there for the time being.  Please
>just read around it.
>
>
>  
>

