Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVG2AaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVG2AaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 20:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVG2AaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 20:30:13 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:54770 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261568AbVG2AaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 20:30:11 -0400
Message-ID: <42E9787D.2020700@mvista.com>
Date: Thu, 28 Jul 2005 17:29:49 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  disk quotas fail when /etc/mtab is symlinked to /proc/mounts
References: <42E97236.6080404@mvista.com> <20050728172302.1b04511a.akpm@osdl.org>
In-Reply-To: <20050728172302.1b04511a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Mark Bellon <mbellon@mvista.com> wrote:
>  
>
>>If /etc/mtab is a regular file all of the mount options (of a file 
>> system) are written to /etc/mtab by the mount command. The quota tools 
>> look there for the quota strings for their operation. If, however, 
>> /etc/mtab is a symlink to /proc/mounts (a "good thing" in some 
>> environments)  the tools don't write anything - they assume the kernel 
>> will take care of things.
>>
>> While the quota options are sent down to the kernel via the mount system 
>> call and the file system codes handle them properly unfortunately there 
>> is no code to echo the quota strings into /proc/mounts and the quota 
>> tools fail in the symlink case.
>>    
>>
>
>hm.  Perhaps others with operational experience in that area can comment.
>  
>
OK.

>  
>
>> The attached patchs modify the EXT[2|3] and [X|J]FS codes to add the 
>> necessary hooks. The show_options function of each file system in these 
>> patches currently deal with only those things that seemed related to 
>> quotas; especially in the EXT3 case more can be done (later?).
>>    
>>
>
>It seems sad to do it in each filesystem.  Is there no way in which we can
>do this for all filesystems, in a single place in the VFS?
>  
>
Each file system must be able to echo it's own FS specific options, 
hence the show_options hook (XFS is a good example). EXT3 has it's own 
form of journalled quota file options, hence the need for the specific hook.

The "older style" (e.g. "usrquota", "grpquota", "quota") could be done 
generically but a FS might want any number of quota options. The few 
lines of code in each file system didn't seem so bad especially if the 
show_function start echoing more.

mark
