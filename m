Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262306AbSJOBCm>; Mon, 14 Oct 2002 21:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262310AbSJOBCm>; Mon, 14 Oct 2002 21:02:42 -0400
Received: from mta02ps.bigpond.com ([144.135.25.134]:16621 "EHLO
	wmailout2.bigpond.com") by vger.kernel.org with ESMTP
	id <S262306AbSJOBCk>; Mon, 14 Oct 2002 21:02:40 -0400
From: harisri <harisri@telstra.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, harisri@bigpond.com
Message-ID: <fd1cf102287.102287fd1cf@bigpond.com>
Date: Tue, 15 Oct 2002 11:08:31 +1000
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: en
Subject: Re: 2.4.20-pre10aa1 oops report (was Re: Linux-2.4.20-pre8-aa2
 oops report. [solved])
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,
 
> this smells like a problem with one of your modules. Please make 100%
> sure you use exactly the same .config for both 2.4.20pre10 and
> 2.4.20pre10aa1 and please try to find which is the module that is
> crashing the kernel after it's being loaded. Expect always different
> kind of crashes and oopses. You can also try to turn on the slab
> debugging option in the kernel hacking menu.

Yes I am using the same .config file from 2.4.20-pre10 on 
2.4.20-pre10aa1 (of course I run make oldconfig, and accept the default 
setting that shows up on 2.4.20-pre10aa1)

I think you are right, it has something to do with the kernel modules.

> > Code;  c01e55e2 <fast_clear_page+12/50>
> 
> you also may want to configure the kernel as i686 instead of K7 so
> fast_clear_page won't be used to see if it makes any difference.

Ok. That didn't really help. Kernel compiled for i386 even crashes, but 
the k7 optimised kernel crashes at the Athlon speed :-)
 
> the place where the oops happens is most certainly not the problem,
> either something is wrong with fast_clear_page for whatever hardware
> reason, or more likely the moduled by modprobe is corrupting the
> freelist and alloc_pages returned garbage.
> 
> btw, how much memory do you have? If you've more than 800M it 
> could be a
> broken driver using pte_offset by hand, try to reproduce with mem=800m
> in such case. To fix this you should find which is the module that is
> destabilizing the kernel.

My computer has 512 MB RAM. No highmem.

I am able to trigger the issue (after 3 attempts [1]) with,
CONFIG_AGP m
CONFIG_AGP_AMD y
CONFIG_DRM y
CONFIG_DRM_RADEON m

While I couldn't trigger the issue (after 5 attempts [1]) without them. 
Hence I suspect it may be something to do with them. But it takes a lot 
of time to test these all, I think I will have good answers in couple of 
days time considering the amount of time it takes to perform the tests.

[1]
1. Login to XFree86/Gnome
2. Start Mozilla, Evolution, OpenOffice Writer/Calc/Impress, Konqueror, 
KMail. And exit them all.
3. mke2fs -j /dev/hdc9; mount /dev/hdc9 /test;cd /test;dd if=/dev/zero 
of=zero bs=1024 count=2097152;cd /
4. Redo the step 2
5. Log out and log in and redo step 2
6. Unmount /test

Repeat the above test cycle few times (on 3rd attempt or so) the system 
oops (when I had AGP/AMD/DRM/Radeon stuff).

Thanks for your help.

Hari
harisri@bigpond.com
 

