Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270694AbTG0Inq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 04:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270695AbTG0Inq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 04:43:46 -0400
Received: from adsl-247-226.38-151.net24.it ([151.38.226.247]:23566 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S270694AbTG0Inp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 04:43:45 -0400
Date: Sun, 27 Jul 2003 10:58:56 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 devfs question
Message-ID: <20030727085856.GA845@renditai.milesteg.arr>
Mail-Followup-To: Andrey Borzenkov <arvidjaar@mail.ru>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200307262351.33808.arvidjaar@mail.ru> <20030726135012.6386c185.akpm@osdl.org> <200307270230.01823.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307270230.01823.arvidjaar@mail.ru>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 02:30:01AM +0400, Andrey Borzenkov wrote:
> it is hard to tell with the amount of information provided in bug report (even 
> error message is not given). We have three cases here:
> 
> root=123456 (real major/minor number) or root=/dev/md2 (literal string). In 
> both cases init/do_mount_devfs.c:create_dev() should notice that neither 
> /dev/123456 nor /dev/md2 exist, search /dev for ROOT_DEV and create link from 
> /dev/root to real device. If it does not work somethig is broken here, people 
> who can reproduce it should add printk's to create_dev and find_in_devfs to 
> see what happens. It may fail for /dev/md2 if block device name in sysfs 
> differs from "md2" because then it won't find correct ROOT_DEV
> 
> root=/dev/md/2 (literal string) should work simply because /dev/root is linked 
> directly to /dev/md/2
> 
> I do not have any raid devices nor possibility to create them so I cannot 
> test.

Andrew's patch makes it work, the system boots fine with raid and devfs
mounted automatically.
Also using root=/dev/md/2 as boot option works (just tried).

Before the patch I tried with root=/dev/md2, that is what I'm using with
2.4, but didn't work. The error message is:
VFS: cannot open root device "md2" or md2
please append a correct "root=" boot option
Kernel panic: VFS: unable to mount root fs on md2

Let me know if you need more info, but I think the sysfs
explanation is right.

Bye.


-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

