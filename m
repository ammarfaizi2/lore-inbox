Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965137AbWGFCYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965137AbWGFCYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 22:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbWGFCYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 22:24:41 -0400
Received: from mail.tmr.com ([64.65.253.246]:43690 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S965137AbWGFCYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 22:24:41 -0400
Message-ID: <44AC7647.2080005@tmr.com>
Date: Wed, 05 Jul 2006 22:32:39 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Bruce Fields" <bfields@fieldses.org>
CC: Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com> <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com> <20060705214133.GA28487@fieldses.org>
In-Reply-To: <20060705214133.GA28487@fieldses.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:

>On Wed, Jul 05, 2006 at 05:12:54PM -0400, Bill Davidsen wrote:
>  
>
>>J. Bruce Fields wrote:
>>    
>>
>>>Or we could add an entirely separate attribute that's guaranteed to
>>>increase whenever the ctime is updated, and that doesn't necessarily
>>>have any connection with time--call it a version number or something.
>>>
>>>      
>>>
>>There are versions in both VMS and the ISO filesystem. I have a sneaking 
>>suspicion that those of us who ever use them are few and far between. 
>>The other issue is that unless the field is time, programs like make 
>>can't really use it, at least without becoming Linux specific.
>>    
>>
>
>Sure.
>
>  
>
>>I'm not sure exactly how a "version" value would be used other than 
>>detecting the fact that the file had been changed in some way.
>>    
>>
>
>I agree.  But "detecting the fact that the file has been changed" is a
>really important use!  I think the challenge would be to come up with
>applications that really depend on timestamps and that use them for
>anything *other* than detecting when a file has changed.
>  
>
But with timestamps I need remember only one number, the time of my last 
backup. Skipping over the question of "who's idea of time" inherent in 
network filesystems. I compare all ctimes with the time of the last 
backup and do incremental on the newer ones. If we use versioning I have 
to remember the version for each file! In practice I really question if 
the benefit justified keeping all that metadata between backups. And if 
I delete a file and create another by the same name, what is it's version?

I'll say it again, I think ms resolution is readily achieved today, even 
over network files, I think greater resolution or versions are going to 
be more trouble than they are worth.

>(OK, so make is a special case--it cares not only about whether a file
>has changed, but also about whether it has changed more recently than
>some other file.  But I'd think a simple version would useful to any
>network filesystem, or more generally to anything that caches a view of
>the filesystem either on another machine or in userspace.)
>
>  
>
>>Feel free to show me, I seem to come up empty on using this value.
>>    
>>
>
>Betraying my own interests--the NFSv4 protocol (unlike v2 or v3) uses a
>specialized "change" attribute to maintain cache consistency instead of
>depending on mtime/ctime.  So nfsd would be one immediate in-kernel
>user.  Currently we're using ctime, which causes obvious problems.
>
>But an improved ctime--one that actually increased whenever the file
>changed--would also do the job.
>

No comment, I would have to see a state table to be sure I saw the races 
or that there were none. With a single writer and a sinple dirty bit 
there is no issue, it behaves like an elevator, more or less. With 
multiple writers I bet changes are written in the order submitted rather 
than the order done, but multiple writers without locks are a train 
wreck waiting to happen anyway.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

