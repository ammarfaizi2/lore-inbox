Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291341AbSAaVoX>; Thu, 31 Jan 2002 16:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291339AbSAaVoP>; Thu, 31 Jan 2002 16:44:15 -0500
Received: from mx2.fuse.net ([216.68.1.120]:56300 "EHLO mta02.fuse.net")
	by vger.kernel.org with ESMTP id <S291344AbSAaVoA>;
	Thu, 31 Jan 2002 16:44:00 -0500
Message-ID: <3C59BA94.1050307@fuse.net>
Date: Thu, 31 Jan 2002 16:43:48 -0500
From: Nathan <wfilardo@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020121
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Various issues with 2.5.2-dj6
In-Reply-To: <3C58B3DD.3000800@fuse.net> <20020131041901.H31313@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>
> > Issue 2: Two IEEE1934 modules needed to have "#include 
> > <linux/interrupt.h>" added (host.c and another one I forget)
>
> Can you send the gcc error messages of these ?
> (A patch would be nice too)
>
GCC error messages:

gcc -D__KERNEL__ 
-I/home/expsoft/src/linux-kernel/linux-2.5/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/expsoft/src/linux-kernel/linux-2.5/linux/include/linux/modversions.h  
-DKBUILD_BASENAME=hosts  -c
-o hosts.o hosts.c
hosts.c: In function `hpsb_ref_host_Rsmp_b2d7a7ae':
hosts.c:53: `current' undeclared (first use in this function)
hosts.c:53: (Each undeclared identifier is reported only once
hosts.c:53: for each function it appears in.)
hosts.c:63: warning: implicit declaration of function 
`preempt_schedule_Rsmp_707f93dd'
hosts.c: In function `hpsb_unref_host_Rsmp_c4b81671':
hosts.c:74: `current' undeclared (first use in this function)
hosts.c: In function `hpsb_add_host_Rsmp_44132731':
hosts.c:115: `current' undeclared (first use in this function)
hosts.c: In function `hpsb_remove_host_Rsmp_efba6673':
hosts.c:134: `current' undeclared (first use in this function)
hosts.c: In function `hpsb_register_lowlevel_Rsmp_4bd81b68':
hosts.c:158: `current' undeclared (first use in this function)
hosts.c: In function `hpsb_unregister_lowlevel_Rsmp_19bd5bca':
hosts.c:167: `current' undeclared (first use in this function)
hosts.c: In function `hl_all_hosts':
hosts.c:183: `current' undeclared (first use in this function)
make[2]: *** [hosts.o] Error 1
make[2]: Leaving directory 
`/home/expsoft/src/linux-kernel/linux-2.5/linux/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
make[1]: Leaving directory 
`/home/expsoft/src/linux-kernel/linux-2.5/linux/drivers'
make: *** [_mod_drivers] Error 2
gcc -D__KERNEL__ 
-I/home/expsoft/src/linux-kernel/linux-2.5/linux/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=i686 -DMODULE -DMODVERSIONS -include 
/home/expsoft/src/linux-kernel/linux-2.5/linux/include/linux/modversions.h  
-DKBUILD_BASENAME=highlevel
 -c -o highlevel.o highlevel.c
highlevel.c: In function `hpsb_register_highlevel_Rsmp_d8359e3c':
highlevel.c:46: `current' undeclared (first use in this function)
highlevel.c:46: (Each undeclared identifier is reported only once
highlevel.c:46: for each function it appears in.)
highlevel.c:48: warning: implicit declaration of function 
`preempt_schedule_Rsmp_707f93dd'
highlevel.c: In function `hpsb_unregister_highlevel_Rsmp_b14574a6':
highlevel.c:64: `current' undeclared (first use in this function)
highlevel.c: In function `hpsb_register_addrspace_Rsmp_c0869354':
highlevel.c:109: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_add_host_Rsmp_a0fb4f9a':
highlevel.c:165: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_remove_host_Rsmp_39625ff3':
highlevel.c:179: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_host_reset_Rsmp_d979264a':
highlevel.c:194: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_iso_receive':
highlevel.c:211: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_fcp_request':
highlevel.c:231: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_read_Rsmp_65f866b3':
highlevel.c:253: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_write_Rsmp_1c9f5932':
highlevel.c:298: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_lock_Rsmp_cdf701d1':
highlevel.c:343: `current' undeclared (first use in this function)
highlevel.c: In function `highlevel_lock64_Rsmp_035dda42':
highlevel.c:376: `current' undeclared (first use in this function)
make[2]: *** [highlevel.o] Error 1
make[2]: Leaving directory 
`/home/expsoft/src/linux-kernel/linux-2.5/linux/drivers/ieee1394'
make[1]: *** [_modsubdir_ieee1394] Error 2
make[1]: Leaving directory 
`/home/expsoft/src/linux-kernel/linux-2.5/linux/drivers'
make: *** [_mod_drivers] Error 2

PATCH:
--- hosts.c.orig        Thu Jan 31 16:30:02 2002
+++ hosts.c     Wed Jan 30 11:59:56 2002
@@ -15,6 +15,7 @@
 #include <linux/list.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>

 #include "ieee1394_types.h"
 #include "hosts.h"
--- highlevel.c.orig    Thu Jan 31 16:30:12 2002
+++ highlevel.c Wed Jan 30 12:00:40 2002
@@ -9,6 +9,7 @@

 #include <linux/config.h>
 #include <linux/slab.h>
+#include <linux/interrupt.h>

 #include "ieee1394.h"
 #include "ieee1394_types.h"

>
> > Issue 3: Turning off hotplug (/etc/init.d/hotplug stop on a Debian 
> > unstable box - updated today) gives the following oopses (captured by 
> > "klogd -x") - see below.
>
> Could be related to the usb-driverfs changes, 2.5.3-dj1 is still cooking
> here, but has Greg KH's updated version of this work. See if you
> can repeat it later..
>
Will test ASAP.

>
> > Issue 4: Unmounting the drives read-only with Alt-SysRQ-U gives the 
> > following oops and locks the box except for further Alt-SysRQ-* (mount 
> > -o ro,remout /mount/point works fine) - see below.
>
> The ext3 related oops, hmm. Oopsing in generic_file_write seems odd.
> I'm wondering if the system was in such a state at this point that the
> subsequent oopses are just noise.
>
That's possible.  I will test it tonight and report then.

>
> > Issue 5: Mouse (via /dev/input/mice) seems slugish this time (after a 
> > fresh cold boot).  Seemed fine first few times on 2.5.2-dj6 and fine 
> > under 2.4.18-pre7 /dev/psaux.
>
> This is the 2nd report I've had of this. Hopefully Vojtech has
> an answer for this.
> 
>
It's really odd - it seems to be almost random when it behaves quickly 
and slowly.  And even within boots - I set mouse accelleration up to a 
huge value to compensate for the mouse slowness but from time to time 
the mouse behaved correctly and sent my cursor flying across the screen 
when the same touch had just moved it a few pixels before.

Further follow up:  My mouse is only intermittantly detected at boot - 
had a boot today where /proc/bus/input/devices didn't show it at all. 
 Rebooted and it worked fine.  AFAICT it's a normal PS/2 device... any 
special testing I should do?

--Nathan


