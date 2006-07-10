Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965285AbWGJW2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbWGJW2X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWGJW2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:28:22 -0400
Received: from mail.tmr.com ([64.65.253.246]:12724 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S965282AbWGJW2U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:28:20 -0400
Message-ID: <44B2D6AA.3090707@tmr.com>
Date: Mon, 10 Jul 2006 18:37:30 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: "J. Bruce Fields" <bfields@fieldses.org>, Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>	 <20060705125956.GA529@fieldses.org>	 <1152128033.22345.17.camel@lade.trondhjem.org>  <44AC2D9A.7020401@tmr.com>	 <1152135740.22345.42.camel@lade.trondhjem.org>  <44B01DEF.9070607@tmr.com> <1152562135.6220.7.camel@lade.trondhjem.org>
In-Reply-To: <1152562135.6220.7.camel@lade.trondhjem.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:

>On Sat, 2006-07-08 at 17:04 -0400, Bill Davidsen wrote:
>  
>
>>No, I didn't quite mean a manual touch, but a system call to "close and 
>>set time to high resolution" for files where time uniformity is 
>>important. Consider that in most cases the inodes times are set by the 
>>host machine clock, which I close the change reflects the fileserving 
>>host idea of time. If there were a call to close a file and set the 
>>times like touch, then that could be used, for both local and network files.
>>    
>>
>
>Close should never update the time since that would be a violation of
>POSIX rules. Normally, an NFS client will never need to update the time:
>RPC calls like WRITE, READ and SETATTR will automatically do it for us
>whenever necessary.
>  
>

Let me restate this a third time in another way. What I suggest is a 
system call, NOT NAMED CLOSE, which does a close and touch. This was all 
blue sky discussion, new system calls are as valid as nanosecond 
resolution and syncronization between servers. Since this is a new call 
it is not specified by POSIX.

And Linus has already suggested that he would accept something similar, 
when I proposed something like "noatime" mounts, which only updated 
atime and mtime on open and close, to keep metadata relevant but not 
have the overhead of constant updates.

Actually, now that I have more free time I may revisit that idea.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

