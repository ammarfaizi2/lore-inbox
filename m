Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311024AbSCLNQb>; Tue, 12 Mar 2002 08:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311166AbSCLNQX>; Tue, 12 Mar 2002 08:16:23 -0500
Received: from [203.197.61.67] ([203.197.61.67]:1925 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S311024AbSCLNQF>; Tue, 12 Mar 2002 08:16:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: vinolin <vinolin@nodeinfotech.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: __get_user usage in mm/slab.c
Date: Tue, 12 Mar 2002 18:48:47 +0530
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
In-Reply-To: <Pine.LNX.4.21.0203121237070.19747-100000@serv>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <02031218484706.00886@Vinolin>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 March 2002 17:28, Roman Zippel wrote:
> Hi,
>
> The way __get_user is currently used in mm/slab.c is not portable. It
> breaks on arch which have seperate user/kernel memory space. It still
> works during boot or from kernel threads, but /proc/slabinfo shows only
> broken entries or if a module creates a slab cache, I got lots of
> warnings.
> We have to at least insert a "set_fs(get_fs())", but IMO a separate
> interface would be better. Any opinions?
>
> bye, Roman

Hi !

I guess u need to read user space from kernel sapce.
You can use the sys_call_table functions for this.
For example, u can use the following code in your file to open a user space 
file from kernel space.

#define BEGIN_KMEM {mm_segment_t old_fs=get_fs();set_fs(get_ds());
#define END_KMEM set_fs(old_fs);}
int (*sample_open)(char *, int);

sample_open = sys_call_table[SYS_open];
BEGIN_KMEM
sample_open("/home/samplefile.txt",O_RDWR);
/* the same way close , read , write etc. can be  written */
END_KMEM

Regards,
Vinolin.


