Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVIIVVf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVIIVVf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030357AbVIIVVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:21:35 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:29585 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1030348AbVIIVVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:21:34 -0400
Message-ID: <4321FCDA.60305@namesys.com>
Date: Fri, 09 Sep 2005 14:21:30 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Edward Shishkin <edward@namesys.com>
Subject: Re: List of things requested by lkml for reiser4 inclusion (to review)
References: <200509091817.39726.zam@namesys.com> <4321C806.60404@namesys.com> <20050909185740.GA11923@infradead.org>
In-Reply-To: <20050909185740.GA11923@infradead.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> 6. remove type safe lists and type safe hash queues.
>
>>   not done, it is not clear that the person asking for this represents a unified consensus of lkml.  Other persons instead asked that it just be moved out of reiser4 code into the generic kernel code, which implies they did not object to it.  There are many who like being type safe.  Akpm, what do you yourself think?
>>    
>>
>
>I think quite a few people complained ;-)
>
I remember that you complained.

>  It's huge CPP abuse
>
can you define what that means? and how abuse differs from cleverness? 
This code was not my idea, but it seemed more cleverness than abuse to
me when I read it.

> which we
>generally don't want - at least for the hash case we already had something
>similar (linux/ghash.h and got rid of it).  That beeing said a generic hash
>abstraction without too much CPP abuse might be really useful, but the list
>code should certainly go.
>
>  
>
>>8.  Remove all assertions because they clutter the code and make it hard to read
>>
>>    We think this person was not an experienced security specialist,
>>    
>>
>
>please stop attacking people personally all the time. 
>
It is not an attack, fewer than 1% of programmers are security
specialists, and I go on to say that until I was educated by some such
specialists, I would have agreed with him, so I don't think you can view
it as an attack.  I hardly expect most people to hang out with the DoD.

> You're certainly not
>what I'd call an experienced security specialist either, but fortunately that
>doesn't matter for this case at all.
>
>Removing all assertations certainly doesn't make sense, we have them all
>over the tree.  Whether your own assert macros makes sense is a different
>question, but given that you use something similar in reiser3 and lots
>of other drivers have their own things built around BUG() I won't complain
>to loudly.
>
>What should go on the other hand are useless assertation, like one that
>asserts that something is non-NULL just before dereferencing it - the
>latter gives a backtrace just as nice.
>  
>
I'll be happy to accept point of code improvements.

>
>As additional requirements please give people time to actually audit the
>codebase.
>
9 months time given so far....

>  I've started but it's quite a pain with all the plugin
>indirections right now.
>  
>
Here I sympathize with you.  If anyone has ideas for how to comment it,
etc., to make it trivial to follow the indirections, I am all ears.   It
annoys me also.

>One major item I found is that you're using your own code for the
>read/write file operations,
>
As I remember, there were things that did not code right using the
generic code, and I told the guys to code it right.  I no longer
remember what those things were, quite honestly, but I remember they
affected performance.  The whole idea of vfs operations is that each
file system gets to do them its own way, and please remember that we
code for more than just use on Linux.

> which not only duplicates core code but
>also lacks features (vectored I/O, AIO, direct I/O) from the common code
>  
>
in time....

>and is totally buggy (it has no chance on working on architectures that
>have completely separate address spaces for user/kernel like s390, please
>check how they define PAGE_OFFSET).
>
zam, please look at that on Tuesday.

>  Depending on your requirements you
>might not use the complete generic code, but you should at least use
>the most important fragments, ala XFS or ocfs, and improve them where
>needed.
>  
>
Oh we do try to do that where it does what we need.  However, you should
keep in mind that reiser4 is not made just for Linux.  Our code needs to
be at least moderately self-contained.

>A very annoying small thing that comes to mind is the usage of
>reiser4_internal.  Please remove it, all but exported symbol are
>module-private.
>  
>
Here I mostly agree.   Edward, can you work on a patch to fix it?  Thanks.

>
>  
>
Christoph, thanks kindly for the donation of your time to improving our
work.
