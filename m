Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSGTCEY>; Fri, 19 Jul 2002 22:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317316AbSGTCEY>; Fri, 19 Jul 2002 22:04:24 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:42665 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317312AbSGTCEX>; Fri, 19 Jul 2002 22:04:23 -0400
Message-ID: <3D38C31F.6030804@namesys.com>
Date: Sat, 20 Jul 2002 05:55:43 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Andreas Dilger <adilger@clusterfs.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
References: <Pine.LNX.4.44L.0207192207060.12241-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sat, 20 Jul 2002, Hans Reiser wrote:
>
>  
>
>>What I was advocating was a schedule of:
>>1) feature submission deadline
>>2) period of working through feature backlog
>>3) feature acceptance ending date
>>    
>>
>
>So, what feature are you trying to smuggle into the kernel
>but are afraid isn't ready on time and why do you think it
>couldn't be backported into 2.6 later, when 2.6 is stable ?
>
Ouch.  He sees right though me.;)

The core Reiser4 code should be in time.  Reiser4 will have its core 
code stable in a month I hope, and by core code I mean code that does 
what V3 does but on top of a plugin infrastructure and faster than V3 in 
at least some measures.  

What I am worried about schedule-wise are:

* the API for exporting transactions to user space (the in kernel buffer 
management code to support it is completed but the API is not yet done). 
 Uses the new system call we are adding.

* The traditional file API is designed for efficiency of repeated 
operations to the same file.  As part of our effort to make files able 
to do everything that extended attributes can do, but more flexibly, we 
are creating a new system call.  This new system call can perform 
multiple operations on files in one system call, and is very convenient 
for a bunch of small IOs to different files.

* file inheritance

Some other reiser4 things won't make it, but they seem like they should 
be easier to get in later because they are plugins:

* encryption plugin

* ACL plugin

* audit plugin

In our development we started from the bottom layer and worked upwards, 
which means the new system call is close to last.

So, I am assuming a new system call must go in before feature freeze. 
 One can reasonably argue that because it only affects one experimental 
filesystem named reiser4 (until other FS authors see how nice it is and 
start to use it;-) ) and does not complicate VFS,  it is not core code, 
and should not be subject to the freeze.  I'll make that argument if we 
don't have it ready in time....;-)

>
>I can't really think of anything that couldn't be backported
>later on, by the time people start actually using 2.6, but
>maybe you've got something so fundamental it just has to be
>merged before the feature freeze ... ;)
>
>regards,
>
>Rik
>  
>


-- 
Hans



