Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSHPWTR>; Fri, 16 Aug 2002 18:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317308AbSHPWTR>; Fri, 16 Aug 2002 18:19:17 -0400
Received: from host.greatconnect.com ([209.239.40.135]:40711 "EHLO
	host.greatconnect.com") by vger.kernel.org with ESMTP
	id <S317282AbSHPWTQ>; Fri, 16 Aug 2002 18:19:16 -0400
Subject: Re: proc/sys/fs file-nr?
From: Samuel Flory <sflory@rackable.com>
To: John Coppens <jcoppens@usa.net>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020816183312.728a970a.jcoppens@usa.net>
References: <20020816183312.728a970a.jcoppens@usa.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Aug 2002 15:22:27 -0700
Message-Id: <1029536548.6469.185.camel@flory.corp.rackablelabs.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-16 at 14:33, John Coppens wrote:
> Hi.
> 
> The last few days I had a problem with an image viewer, and thought I'd investigate
> a little. The program makes thumbnails, and after a while, complains about
> 'too many files open'. I found a reference to the proc/sys/fs/file-max and
> wanted to check file-nr first. /usr/src/linux/Documentation states:
> 
> "The three  values  in file-nr denote the number of allocated file handles, the
> number of  used file handles, and the maximum number of file handles."
> 
> I'm confused now. Each time I open a new directory with images, the second number
> _decreases_! It _increases_ when I close the viewer program. Is this normal?
> 
> Finally, the viewer (gThumb) gives up at: 
> 
> 1961    50      8192
> 
> with the 'too many...' error. Shouldn't the number increase till 8192? This is
> the number in file-max? (Kernel 2.4.18)

Check inode-nr in addition to file-max.  What is your ulimit set to.  I
think the default is 1024.

[root@flory sflory]# ulimit -a
core file size        (blocks, -c) 0
data seg size         (kbytes, -d) unlimited
file size             (blocks, -f) unlimited
max locked memory     (kbytes, -l) unlimited
max memory size       (kbytes, -m) unlimited
open files                    (-n) 1024
pipe size          (512 bytes, -p) 8
stack size            (kbytes, -s) 8192
cpu time             (seconds, -t) unlimited
max user processes            (-u) 4086
virtual memory        (kbytes, -v) unlimited
[root@flory sflory]# ulimit -n 2048
[root@flory sflory]# ulimit -n
2048




