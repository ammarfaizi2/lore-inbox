Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261606AbTCKR2v>; Tue, 11 Mar 2003 12:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261630AbTCKR2v>; Tue, 11 Mar 2003 12:28:51 -0500
Received: from unknown.Level3.net ([63.210.233.185]:38960 "EHLO
	cinshrexc03.shermfin.com") by vger.kernel.org with ESMTP
	id <S261606AbTCKR2t> convert rfc822-to-8bit; Tue, 11 Mar 2003 12:28:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: OOPS in do_try_to_free_pages with VERY large software RAID array
Date: Tue, 11 Mar 2003 12:38:44 -0500
Message-ID: <8075D5C3061B9441944E137377645118012E96@cinshrexc03.shermfin.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: OOPS in do_try_to_free_pages with VERY large software RAID array
Thread-Index: AcLnPeNYKIIvEGarQZ2N3GvoYrirbgAtf4Vg
From: "Rechenberg, Andrew" <ARechenberg@shermanfinancialgroup.com>
To: "Kevin P. Fleming" <kpfleming@cox.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin,

I tried patching md by hand since you're patch is for 2.5 but I'm having
some issues.  When I try to make bzImage I'm getting the following
error:

md.c:139: `single_release' undeclared here (not in a function)
md.c:139: initializer element is not constant
md.c:139: (near initialization for `md_state_fops.release')
md.c:140: initializer element is not constant
md.c:140: (near initialization for `md_state_fops')
md.c: In function `md_state_seq_show':
md.c:3219: warning: passing arg 1 of pointer to function from
incompatible pointer type
md.c: In function `md_state_open_fs':
md.c:3238: warning: implicit declaration of function `single_open'
make[3]: *** [md.o] Error 1
make[3]: Leaving directory `/usr/src/linux-flux/drivers/md'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-flux/drivers/md'
make[1]: *** [_subdir_md] Error 2
make[1]: Leaving directory `/usr/src/linux-flux/drivers'
make: *** [_dir_drivers] Error 2

Can you tell me if the single_release is a 2.5 "thing?"  Can you point
me in the right direction as to how to fix this problem?.

Thanks,
Andy.

-----Original Message-----
From: Kevin P. Fleming [mailto:kpfleming@cox.net] 
Sent: Monday, March 10, 2003 2:48 PM
To: Martin J. Bligh
Cc: Rechenberg, Andrew; linux-kernel@vger.kernel.org
Subject: Re: OOPS in do_try_to_free_pages with VERY large software RAID
array


Martin J. Bligh wrote:
> At a wild guess (OK, I only looked for about 1 minute), 
> md_status_read_proc is generating more than 4K of information, and 
> overwriting the end of it's 4K page. Throw some debug in there, and 
> get it to printk how much of the buffer it thinks it's using (just 
> printk sz every time it changes it). If it's > 4K, convert it to the 
> seq_file interface.
> 
> May not be it, but it seems likely given the unusual scale of what 
> you're doing, and it's easy to check.
> 
> M.

I posted a patch to do exactly this last week to the Linux-RAID mailing
list. If 
you check the archives you should find it. This problem also occurs if
you use 
the device-mapper under 2.5.X, because it makes all 256 md minors appear
in the 
tables and /proc/mdstat wants to tell you about all of them.


