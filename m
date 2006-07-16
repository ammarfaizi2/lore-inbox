Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751234AbWGPMUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbWGPMUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 08:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWGPMUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 08:20:04 -0400
Received: from smtpout.mac.com ([17.250.248.184]:41926 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751234AbWGPMUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 08:20:02 -0400
In-Reply-To: <200607152039.50786.a1426z@gawab.com>
References: <200607152039.50786.a1426z@gawab.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1256E02-209F-4D19-ACB2-1E92004E80B5@mac.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH -mm 5/7] add user namespace
Date: Sun, 16 Jul 2006 08:19:32 -0400
To: Al Boldi <a1426z@gawab.com>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 15, 2006, at 13:39:50, Al Boldi wrote:
> Trond Myklebust wrote:
>> On Sat, 2006-07-15 at 06:35 -0600, Eric W. Biederman wrote:
>>> I hope the confusion has passed for Trond.  My impression was he  
>>> figured this was per process data so it didn't make sense any  
>>> where near a filesystem, and the superblock was the last place it  
>>> should be.
>>
>> You are still using the wrong abstraction. Data that is not global  
>> to the entire machine has absolutely _no_ place being put into the  
>> superblock. It doesn't matter if it is process-specific, container- 
>> specific or whatever-else-specific, it will still be vetoed.
>>
>> If your real problem is uid/gid mapping on top of generic  
>> filesystems, then have you looked into the *BSD solution of using  
>> a stackable filesystem (i.e. umapfs)?
>
> A stackable FS is really overkill here, when all that is needed is  
> a simple mapping.  An easy solution would be, to allow for perMount  
> Handlers via hooks into the VFS, as was suggested in the '[RFC]  
> VFS: FS CoW using redirection' thread.

IMHO a UID mapping is completely the wrong solution for this.  The  
problem is the the subject (the process) and object (the filesystem)  
place different meanings on different UIDs, in other words their UIDs  
are in different namespaces.  The result is that you should tag that  
filesystem (vfsmount, really) with a different namespace tag and fix  
the namespace system to properly handle cross-namespace permissions,  
not forcibly graft on some fragile mapping system.  By using the  
keyring system for foreign-namespace UID permissions the actual  
permissions fall out quite nicely.

Cheers,
Kyle Moffett

