Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932242AbWCAOuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWCAOuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 09:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWCAOuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 09:50:23 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:62104 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S932242AbWCAOuX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 09:50:23 -0500
Message-ID: <4405B4AA.7090207@free.fr>
Date: Wed, 01 Mar 2006 15:50:18 +0100
From: Laurent Riffard <laurent.riffard@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050920
X-Accept-Language: fr-fr, fr, en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@osdl.org>
CC: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>	 <4404CE39.6000109@liberouter.org>	 <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>	 <4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>	 <4405723E.5060606@free.fr>  <20060301023235.735c8c47.akpm@osdl.org> <1141221511.7775.10.camel@homer>
In-Reply-To: <1141221511.7775.10.camel@homer>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01.03.2006 14:58, Mike Galbraith a écrit :
> On Wed, 2006-03-01 at 02:32 -0800, Andrew Morton wrote:
> 
>>Laurent Riffard <laurent.riffard@free.fr> wrote:
>>
>>>Le 01.03.2006 01:21, Andrew Morton a écrit :
>>> > Laurent Riffard <laurent.riffard@free.fr> wrote:
>>> > 
>>> >>BUG: unable to handle kernel NULL pointer dereference at virtual address 00000034
>>> > 
>>> > 
>>> > I booted that thing on five machines, four architectures :(
>>> > 
>>> > Could people please test a couple more patchsets, see if we can isolate it?
>>> > 
>>> > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
>>> > 
>>> > is 2.6.16-rc5-mm1 minus:
>>> > 
>>> > proc-make-proc_numbuf-the-buffer-size-for-holding-a.patch
>>> > tref-implement-task-references.patch
>>> > proc-dont-lock-task_structs-indefinitely.patch
>>> > proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>>> > proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch
>>> > proc-optimize-proc_check_dentry_visible.patch
>>>
>>> Ok, 2.6.16-rc5-mm1.1 works for me:
>>> - I can run java from command line in runlevel 1
>>> - I can launch Mozilla in X
>>
>>Useful, thanks.  So the second batch of /proc patches are indeed the problem.
>>
>>If you have (even more) time you could test
>>http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm2-pre1.gz. 
>>That's the latest of everything with the problematic sysfs patches reverted
>>and Eric's recent /proc fixes.
> 
> 
> Seems to work OK here, with debug settings as in Paul Jackson's report.
> No java crash, no fuser -n tcp NNNN crash.  Only thing I see so far is
> the proc symbolic link to nirvana permissions thingie.  Box is P4 HT.
> 
> 	-Mike
> 

2.6.16-rc5-mm2-pre1 works fine for me except numerous "BUG: warning at fs/inotify.c:533/inotify_d_instantiate()".

Thanks
-- 
laurent
