Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbRDITwM>; Mon, 9 Apr 2001 15:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132837AbRDITwC>; Mon, 9 Apr 2001 15:52:02 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:10718 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132833AbRDITvy>;
	Mon, 9 Apr 2001 15:51:54 -0400
Message-ID: <3AD212D4.55E5E8DB@mandrakesoft.com>
Date: Mon, 09 Apr 2001 15:51:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Srinivasan Venkatraman <srini@dcs.uky.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question on accessing /proc
In-Reply-To: <Pine.LNX.4.10.10104091537190.18228-100000@bart.dcs.uky.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivasan Venkatraman wrote:
>  I am new to this list. I did go through the FAQ before posting this
> question. I have a specific requirment - creating,modifying and deleting
> data structures inside the kernel values of which will be passed by an
> user application. I know we could do this by writing a system call or by
> ioctl command to a character device. My question is can we do this by
> writing to /proc file system ? Can we actually create, modify and delete
> data structures by accessing this file system ?

You could definitely use procfs, but it sounds like your example would
be complex.  Lately mounting filesystems has become a cheap operation in
Linux.  Mount/umount is also a convenient synchronization point.  So,
maybe consider implementing your own tiny filesystems - a data
filesystem, where you mmap(2)/read(2)/write(2) data values, and a
control filesystem, where you control the system and manipulate data
values.

That way, you can use standard Unix syscalls, standard Unix tools and
standard Unix permissions to accomplish your domain-specific task.

-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
