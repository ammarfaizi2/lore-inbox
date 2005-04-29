Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVD2Usk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVD2Usk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVD2Use
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:48:34 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:45533 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262966AbVD2Urf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:47:35 -0400
Message-ID: <42729D51.5050203@austin.rr.com>
Date: Fri, 29 Apr 2005 15:47:13 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: which ioctls matter across filesystems
References: <42728964.8000501@austin.rr.com> <1114804426.12692.49.camel@lade.trondhjem.org> <1114805033.6682.150.camel@betsy>
In-Reply-To: <1114805033.6682.150.camel@betsy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>>What about inotify makes it insufficient for your needs?
>>
>>    
>>
I am not sure - but it is obviously required that inotify can pass over 
CIFS (and probably NFS) since change notification is hardest for the 
user to figure out when they are on a network.   I am not sure how the 
filesystem can detect that a new watch is added to one of its inodes - 
it looks like you added an ioctl to a device but I am still reading 
through your latest patch.   I was looking for something like an inode 
operation that cifs could hook so the fs could be told when a new watch 
was added or one was changed.   In any case I need to construct 
functions somewhat similar to what is in fs/cifs/fcntl.c and need to 
finish/modify CIFSSMBNotify in fs/cifs/cifssmb.c to map the inotify 
flags to the flags available in the CIFS network protocol specifications.
The existing network protocol support for ChangeNotify is more 
straightforward than you might think and the filter flags & actions that 
I have at my disposal for implementing notify across the network are in 
fs/cifs/cifspdu.h already (search for FILE_ACTION_   and FILE_NOTIFY_ if 
you are curious) but obviously they are similar to what the other Samba 
team guys have already told you.

>>What kind of real-world applications exist out there that need inotify
>>functionality, and what sort of requirements do they have (in particular
>>w.r.t. the notification mechanism)?
>>    
>>
>
>A few worksets:
>
>	- Current users, such as FAM and Samba, that need simple file
>	  change notification
>	- Random applications that want to watch a file or two
>	- The Linux desktop
>	- Real-time live-updating indexing systems, such as Beagle,
>	  that compete with f.e. Apple's Spotlight.
>
>Best,
>
>	Robert Love
>
strongly agree, very strongly agree.

The one example we left out - distributed backup applications (those 
guys query me from time to time asking for improvements) - they want to 
know when a server file changes so they can do backup across CIFS.
