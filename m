Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264943AbSL0PBO>; Fri, 27 Dec 2002 10:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSL0PBO>; Fri, 27 Dec 2002 10:01:14 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4872 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264943AbSL0PBN>; Fri, 27 Dec 2002 10:01:13 -0500
Date: Fri, 27 Dec 2002 16:09:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: bert hubert <ahu@ds9a.nl>, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: swsusp in 2.5.53 BUG on kernel/suspend.c line 718
Message-ID: <20021227150929.GB16911@atrey.karlin.mff.cuni.cz>
References: <20021227142032.GA6945@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021227142032.GA6945@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need one-liner to fix this, search mailing lists.

								Pavel

> Hi!
> 
> I wanted to try software suspend again in Linux as 2.5 is doing almost
> everything pretty well for me already.
> 
> I boot my uniprocessor Pentium III laptop with:
> 
> kernel (hd0,0)/boot/vmlinuz-2.5.53 root=/dev/hda1 resume=/dev/hda2
> 
> # swapon -s
> Filename				Type		Size	Used Priority
> /dev/hda2                               partition	489972	0    -1
> 
> $ cat /proc/meminfo 
> MemTotal:       191240 kB
> 
> When I suspend, things proceed swimmingly, I see a lot of dots printed and
> processes entering the refrigerator, until line 718 is hit in
> kernel/suspend.c:
> 
>    if (nr_copy_pages != count_and_copy_data_pages(pagedir_nosave)) /* copy */
>        BUG();
> 
> When I aded some printks, it turns out that count_and_copy_data pages
> returns 5440 (decimal) and that nr_copy_pages is 5458, 18 more. Before this
> function is called, the address c034c000 was printed twice prefixed with
> 'nosave', once during each call of count_and_copy_data_pages it appears.
> 
> So it appears some pages were freed in the critical section!
> 
> Another interesting note is that pdflush reported 'Bogus wakeup' twice
> during the refrigeration phase. I also see two pdflushes running.
> 
> If I remove the BUG();, on resume it crashes on an unhandled NULL pointer,
> the EIP is in a function aptly named do_magic() at +0x9e.
> 
> Compiler is gcc 3.2.1. Anything I can do to help, just let me know!
> 
> Regards,
> 
> bert
> 

-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
