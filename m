Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbTHZJM3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 05:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263483AbTHZJM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 05:12:29 -0400
Received: from [203.185.132.124] ([203.185.132.124]:8044 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263433AbTHZJM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 05:12:28 -0400
Message-ID: <3F4B23E2.8040401@nectec.or.th>
Date: Tue, 26 Aug 2003 16:09:54 +0700
From: Samphan Raruenrom <samphan@nectec.or.th>
Organization: NECTEC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en, th
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Jens Axboe <axboe@image.dk>, linux-kernel@vger.kernel.org,
       Linux TLE Team <rdi1@opentle.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Add MOUNT_STATUS ioctl to cdrom device
References: <3F4A53ED.60801@nectec.or.th> <20030825195026.A10305@infradead.org> <3F4B0343.7050605@nectec.or.th> <20030826083249.B20776@infradead.org>
In-Reply-To: <20030826083249.B20776@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
>>(my random idea)
>>- fcntl(open("/dev/cdrom", F_MNTSTAT)
>>- umount2("/dev/cdrom", MS_TEST) // not actually perform
>>- new system call! e.g. mntstat(open("/dev/cdrom"))
> In userspace.  Or you could tell me what you want to actually
> archive - your call by itself doesn't make any sense.

To get the same result in userspace, it means scanning /proc
like fuser, right?  Do you think it is ok to do that?  Because
the daemon (patched magicdev) poll the cdrom device very often
(every 2 sec.)
That's why I thought that faster is better (less load to
the system) and push the job to kernel-space.

This is what I really want to achive - "enable the eject button,
by locking the drive only when the device is really in use,
unlock otherwise".

I implement this as a modified version of GNOME magicdev.
http://bugzilla.gnome.org/show_bug.cgi?id=119892

The only visible feature of this new magicdev is that now
GNOME users can eject there CDs (the discs' icon will
disappear). The eject button now act as 'umount' command.

One new requirement from this new magicdev is the question
"will umount failed?". I have no preference on any way to
implement it. Should there be the right way to do it, I'll
do so. I can think of many way to implement it (including
adding a new lazy-lock mode to cdrom device) but since
I have no kernel hacking experience, I need everyone
advices. Novice users need this 'eject' button after all.

-- 
Samphan Raruenrom,
The Open Source Project,
National Electronics and Computer Technology Center,
National Science and Technology Development Agency,
Thailand.

