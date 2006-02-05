Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWBETus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWBETus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 14:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWBETus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 14:50:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:31759 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750706AbWBETus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 14:50:48 -0500
Date: Sun, 5 Feb 2006 20:50:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Olaf Hering <olh@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] Fix build failure in recent pm_prepare_* changes.
Message-ID: <20060205195046.GD15767@stusta.de>
References: <200602032312.k13NCDAc012658@hera.kernel.org> <20060205125610.GA26337@suse.de> <20060205190220.GB19458@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060205190220.GB19458@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 02:02:20PM -0500, Dave Jones wrote:
> On Sun, Feb 05, 2006 at 01:56:10PM +0100, Olaf Hering wrote:
>  >  On Fri, Feb 03, Linux Kernel Mailing List wrote:
>  > 
>  > > tree 8f70444139c8564c0f1e88e1f33adda036ae6a96
>  > > parent 278ff9537030bbb292b33504f5e1f6e0126793eb
>  > > author Dave Jones <davej@redhat.com> Fri, 03 Feb 2006 19:03:44 -0800
>  > > committer Linus Torvalds <torvalds@g5.osdl.org> Sat, 04 Feb 2006 00:32:00 -0800
>  > > 
>  > > [PATCH] Fix build failure in recent pm_prepare_* changes.
>  > > 
>  > > kernel/power/power.h:49: error: static declaration of 'pm_prepare_console' follows non-static declaration
>  > > include/linux/suspend.h:46: error: previous declaration of 'pm_prepare_console' was here
>  > > kernel/power/power.h:50: error: static declaration of 'pm_restore_console' follows non-static declaration
>  > > include/linux/suspend.h:47: error: previous declaration of 'pm_restore_console' was here
>  > > 
>  > > Signed-off-by: Dave Jones <davej@redhat.com>
>  > 
>  > this one is not correct, please have a closer look at
>  > f7b8988ff50d99c99746f65f420364e91362c065
>  > 
>  >   CC      drivers/macintosh/via-pmu.o
>  > drivers/macintosh/via-pmu.c: In function 'pmac_suspend_devices':
>  > drivers/macintosh/via-pmu.c:2078: error: implicit declaration of function 'pm_prepare_console'
>  > drivers/macintosh/via-pmu.c: In function 'pmac_wakeup_devices':
>  > drivers/macintosh/via-pmu.c:2194: error: implicit declaration of function 'pm_restore_console'
>  > make[2]: *** [drivers/macintosh/via-pmu.o] Error 1
> 
> Strange, my ppc[64] builds compiled and linked without failure. I think perhaps
> it's time I added -Werror-implicit-function-declaration to the Makefile.
>...

If it compiles and links and gcc guessed the prototype correctly 
everything is fine. If it compiles and links and gcc guessed the 
prototype wrongly, you have a hard to find runtime error...

I'd love to add this flag to the global Makefile, but Andrew always 
rejected it because it turns link errors into compile errors (sic) 
breaking his powerpc all*config builds due to virt_to_bus/bus_to_virt. 
But then he rejected to mark virt_to_bus/bus_to_virt as __deprecated on 
i386 because it currently generates some warnings...  :-(

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

