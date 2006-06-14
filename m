Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWFNLGi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWFNLGi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 07:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbWFNLGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 07:06:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:10370 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932285AbWFNLGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 07:06:38 -0400
Date: Wed, 14 Jun 2006 13:05:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Fengguang Wu <fengguang.wu@gmail.com>, linux-kernel@vger.kernel.org,
       Lubos Lunak <l.lunak@suse.cz>, Dirk Mueller <dmueller@suse.de>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] the /proc/filecache interface
Message-ID: <20060614110542.GE28536@elf.ucw.cz>
References: <20060612075130.GA5432@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060612075130.GA5432@mail.ustc.edu.cn>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The /proc/filecache support has been half done. And I'd like to hear
> early comments on the interface.
> 
> (The patch is not quite ready for code reviews. It is attached in case
> someone are interested to have it a try.)

I guess this is going to be nice for loading cache after
suspend-to-disk and for the fast boot, but...

> SAMPLE OUTPUT
> 
> root ~# echo -n ALL > /proc/filecache
> root ~# head /proc/filecache
> # file ALL
> #      ino       size   cached cached%  state   refcnt  uid     gid     dev             file
>     413605         23       24    100   --      0       0       0       03:00(hda)      /sbin/modprobe
>     381701         17       20    100   --      1       0       0       03:00(hda)      /bin/cat
>     398088          1        4    100   --      0       0       0       03:00(hda)      /root/bin/checkpath
>     381698        611      612    100   --      1       0       0       03:00(hda)      /bin/bash
>     159498          1        4    100   --      0       0       0       03:00(hda)      /etc/mtab
>     381719         30       32    100   --      0       0       0       03:00(hda)      /bin/rm
>     335993          4        4    100   --      0       0       43      03:00(hda)      /var/run/utmp
>          0    3687424      828      0   --      0       0       0       00:02(bdev)     03:00
>     159701          5        8    100   --      0       0       0       03:00(hda)      /etc/modprobe.d/aliases
>      31866       1238     1240    100   --      4       0       0       03:00(hda)      /lib/tls/libc-2.3.5.so
>     381705         51       52    100   --      0       0       0       03:00(hda)      /bin/cp
>      31814         27       28    100   --      0       0       0       03:00(hda)      /lib/libblkid.so.1.0
>     159534         17       20    100   --      0       0       0       03:00(hda)      /etc/ld.so.cache
> [...]

> root ~# echo -n /lib/tls/libc-2.3.5.so > /proc/filecache
> root ~# head /proc/filecache
> # file /lib/tls/libc-2.3.5.so
> # flags LK:locked ER:error RF:referenced UD:uptodate DT:dirty AC:active SL:slab CK:checked A1:arch_1 RS:reserved PV:private WB:writeback NS:nosave CP:compound SC:swapcache MD:mappedtodisk RC:reclaim ns:nosave_free RA:readahead MM:mmap
> # idx   len                     state                   	refcnt  location
> 0       21      ____RFUD__AC__________________MD______MM        4       0.0.Normal
> 21      1       ____RFUD__AC__________________MD______MM        3       0.0.Normal
> 22      3       ______UD______________________MD________        1       0.0.Normal
> 25      1       ____RFUD__AC__________________MD______MM        2       0.0.Normal
> 26      2       ______UD______________________MD________        1       0.0.Normal
> 28      1       ______UD______________________MD____RA__        1       0.0.Normal
> 29      2       ______UD______________________MD________        1       0.0.Normal

The interface is really too ugly to live. How do you expect it being
used from two programs, simultaneously?

We don't really want to do ascii pretty-printing in kernel, sorry. It
probably needs to go into /sys , and be redesigned to provide "one
value per file" rule...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
