Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265834AbTFSQn2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265835AbTFSQn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:43:28 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:57069 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265834AbTFSQnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:43:19 -0400
Message-ID: <3EF1EA8A.7070105@sun.com>
Date: Thu, 19 Jun 2003 12:53:30 -0400
From: Mike Waychison <michael.waychison@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFS autmounter support v2
References: <11504.1056033106@warthog.warthog> <3EF1D326.4040109@sun.com> <20030619153453.GG6754@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030619153453.GG6754@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Thu, Jun 19, 2003 at 11:13:42AM -0400, Mike Waychison wrote:
> 
>  
>
>>Introducing special trap vfsmounts w/o super_blocks means we can no 
>>longer have arbitrary actions on those traps.  AFS wants to define what 
>>happens in kernelspace, autofs wants to define it in userspace.  Last I 
>>checked, vfsmount doesn't have an ops structure.
>>    
>>
>
>It would have send an event over attached opened file.  Attached at
>creation time.
>
That's a pretty good idea then :)

> 
>  
>
>>This only works for mounts performed in kernel space.  It doesn't lend 
>>itself to performing mounts in userspace and would force autofs to 
>>re-implement mount(1) parsing/struct packing in kernelspace.  Definitely 
>>not a good solution.
>>    
>>
>
>Or if passed event contains opened mountpoint-to-be.
>
By this, I assume you are implying that infrastructure for mounting on a 
given struct file (w/ S_ISDIR) would be made.  Correct?

How would this kind of trap be installed in userspace?  'mount -t trap 
-o fd=# none /trappoint' which gets caught by the vfs layer in a special 
manner I suppose?  The vfs system would of course be responsible for 
pipe errors/closure.  As well, the passed opened mountpoint-to-be would 
have to be owned by the process owning the reading end of the pipe.

> 
>  
>
>>I'm still partial to the idea that a usenamespace ioctl on 
>>/proc/<pid>/mounts is a cleaner solution in the long run, both for 
>>automounting as well as for administration tools.
>>    
>>
>
>Vetoed.  ioctl() is _not_ an acceptable way to implement any generic
>functionality.  It basically says "my interface is a garbage".
>

Alright.  Automounting aside, does it still make sense to have *some* 
way for a sys-admin to join an existing namespace?  sys_pushns(pid_t 
pid)/sys_popns() perhaps?  Administrating an environment with multiple 
running namespaces may become difficult to administer without such 
capability.

>
>And yes, we need to think about a new syscall for mount-related
>work.  With sane API - mount(2) one is _not_.  sys_mount() would
>still stay, obviously.
>

What is not sane about mount(2)?  Are you talking about the 
move/bind/remount functionality?



Mike Waychison


