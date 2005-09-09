Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030418AbVIIWCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbVIIWCr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030419AbVIIWCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:02:46 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:18831 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030420AbVIIWCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:02:45 -0400
Message-ID: <43220682.6030101@namesys.com>
Date: Fri, 09 Sep 2005 15:02:42 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Reiserfs-Dev@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: List of things requested by lkml for reiser4 inclusion (to review)
References: <200509091817.39726.zam@namesys.com>	<4321C806.60404@namesys.com> <20050909144142.0f96802f.akpm@osdl.org>
In-Reply-To: <20050909144142.0f96802f.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>
>  
>
>>1. pseudo files or "...." files
>>
>>    
>>
>
>  
>
>>  disabled.  It remains a point of (extraordinary) contention as to
>>whether it can be fixed, we want to keep the code around until we can
>>devote proper resources into proving it can be (or until we fail to prove
>>it can be and remove it).  We don't want to delay the rest of the code for
>>that proof, but we still think it can be done (by several different ways of
>>which we need to select one and make it work.) Let us postpone contention
>>on this until the existence of a patch that cannot crash makes contention
>>purposeful, shall we?
>>    
>>
>
>I'd prefer that unused code simply not be present in the tree, sorry.
>  
>
Ok, edward will remove.

>  
>
>>2. dependency on 4k stack turned off
>>
>>   removed as requested
>>    
>>
>
>So it all runs OK with 4k stacks now?
>  
>
vs will answer this.

>  
>
>>3. remove conditional variable code, use wait queues instead.
>>
>>not done.  There are times when reduced functionality aids debugging. 
>>kcond is (literally) textbook code.  We don't care enough to fight much for
>>it, but akpm, what is your opinion?  Will remove if akpm asks us to.
>>    
>>
>
>kcond is only used in a couple of places.  One looks like it could use
>complete() and the other is a standard wait-for-something-to-do kernel
>thread loop, which we open-code without any fuss in lots of places
>(kjournald, loop, pdflush, etc).  So yes, I'd be inclined to remove kcond
>please.
>  
>
ok, zam will do so.

>Also, it would be better to use the kthread API rather than open-coding
>kernel_thread() calls.  If you think that reiser4 needs additional ways of
>controlling kernel threads then feel free to enhance the kthread API.
>
>  
>
>>6.  remove type safe lists and type safe hash queues.
>>
>>not done, it is not clear that the person asking for this represents a
>>unified consensus of lkml.  Other persons instead asked that it just be
>>moved out of reiser4 code into the generic kernel code, which implies they
>>did not object to it.  There are many who like being type safe.  Akpm, what
>>do you yourself think?
>>    
>>
>
>The type-unsafety of existing list_heads gives me conniptions too.  Yes,
>it'd be nice to have a type-safe version available.
>
>That being said, I don't see why such a thing cannot be a wrapper around
>the existing list_head functions.  Yes, there will be some ghastly
>C-templates-via-CPP stuff, best avoided by not looking at the file ;)
>
>We should aim for a complete 1:1 relationship between list_heads and
>type-safe lists.  So people know what they're called, know how they work,
>etc.  We shouldn't go adding things called rx_event_list_pop_back() when
>everyone has learned the existing list API.
>
>Of course, it would have been better to do this work as a completely
>separate kernel feature rather than bundling it with a filesystem.  If this
>isn't a thing your team wants to take on now then yes, I'd be inclined to
>switch reiser4 to list_heads.
>  
>
Ok, Edward, this task is yours.  Edward, how big you make the task is up
to you so long as it is done by Monday.  If you run low on time, get
help with it.

