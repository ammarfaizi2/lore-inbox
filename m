Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262437AbSJ0PlZ>; Sun, 27 Oct 2002 10:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262440AbSJ0PlZ>; Sun, 27 Oct 2002 10:41:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23824 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262437AbSJ0PlY>;
	Sun, 27 Oct 2002 10:41:24 -0500
Message-ID: <3DBC0A87.1000102@pobox.com>
Date: Sun, 27 Oct 2002 10:47:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Waechtler <pwaechtler@mac.com>
CC: linux-kernel@vger.kernel.org, jakub@redhat.com, torvalds@transmeta.com
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
References: <3DBC075B.AF32C23@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Waechtler wrote:

>I applied the patch from Jakub against 2.5.44
>There are still open issues but it's important to get this in before
>feature freeze.
>
>While you can implement Posix mqueues in userland (Irix is doing this
>with fcntl(fd,F_SETLKW,) and shmem) a kernel implementation has some advantages:
>
>a) no hassle with locks in case an app crashes
>b) guaranteed notification with signals (you can have two apps with
>	different uid that can acces the queue but aren't allowed to
>	send signals)
>c) surprisingly, seems a little faster - did not test with NPT
>
>
>Open issues are:
>
>- notification not tested
>- still linear search in queues
>- I would really enhance the sys_ipc for handling posix mqueue as well
>	(yes, perhaps it's more ugly - but it fits naturally, you can't
>	specify a priority with a read() - ending up with ioctl())
>- funny "locking" in ipc/util.c 
>- check the ipc ids
>
>  
>

I don't comment on the overall concept of the patch itself, it's not my 
area of expertise and it's too early in the morning to think about it ;-)

However, there are three issues to consider in the meantime:
* Documentation/CodingStyle problems.  You need to use standard 
one-tab-for-indentation formatting, just like the code around what you 
are adding/modifying.
* There is weird text translation in the patch (short example follows). 
 It may be better if you use mutt and vi to include your patch directly, 
without word wrapping, if attachments are getting mangled.

-		msq =3D msg_lock(msqid);
-		err =3D -EIDRM;
-		if(msq=3D=3DNULL)
-			goto out_free;
-		ss_del(&s);
-		=

* Linus probably won't see your email, he has threatened to flush his entire inbox when he returns from his trip ;-)

Regards,

	Jeff





