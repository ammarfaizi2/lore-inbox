Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129886AbQKMDKc>; Sun, 12 Nov 2000 22:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbQKMDKW>; Sun, 12 Nov 2000 22:10:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33290 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129886AbQKMDKN>;
	Sun, 12 Nov 2000 22:10:13 -0500
Message-ID: <3A0F5B73.E613050B@mandrakesoft.com>
Date: Sun, 12 Nov 2000 22:09:39 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu
CC: linux-kernel@vger.kernel.org, p_gortmaker@yahoo.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, viro@math.psu.edu
Subject: Re: Linux 2.4 Status/TODO page (test11-pre3)
In-Reply-To: <200011121939.eACJd9D01319@trampoline.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
> 4. Boot Time Failures

>      * Various Alpha's don't boot under 2.4.0-test9 (PCI-PCI bridges are
>        not configured correctly Michal Jaegermann; Richard Henderson may
>        have an idea what's failing.)

Move to patch-exists-but-not-merged.  rth has patches, co-developed with
Ivan Kokshaysky


> 8. Fix Exists But Isnt Merged

>      * Many network device drivers don't call MOD_INC_USE_COUNT in
>        dev->open. (Paul Gortmaker has patches)

Update:  net drivers can now set an owner member as of test11-pre3, to
completely eliminate any race.  Net drivers that don't call MOD_xxx at
all should just be updated to use the new stuff.


>      * using ramfs with highmem enabled can yield a kernel NULL pointer
>        dereference. (wollny at cns.mpg.de has a patch)

fixed as of test11-pre2.


> 9. To Do

>      * Fix mount failures due to copy_* user mishandling

Details?


>      * Misc locking problems
>           + Power management locking (Alan Cox)

A patch from Alan for this made it into test10 or test11-pre1.


>      * Copying between two encrypting loop devices causes an immediate
>        deadlock in the request queue (Andi Kleen)

Loopback block device has serious problems, not just this..   I am gonna
look at it this week...


>      * 2.4.0-test10 pcmcia fails to detect IRQ's correctly, and will
>        sometimes kill all software interrupts on card insertion on a NEC
>        Versa LX (David Ford)

Still does this with test11-pre-latest?


>      * VGA Console can cause SMP deadlock when doing printk {CRITICAL}
>        (Keith Owens)

move to "should already be fixed, confirmation wanted."  I think Keith
said he doesn't exercise that particular code path anymore, so he didn't
test James' patch.


>      * drivers/input/mousedev.c dereferences userspace pointers directly
>        (prumpf)

yum :)

> 10. To Do But Non Showstopper
> 
>      * Go through as 2.4pre kicks in and figure what we should mark
>        obsolete for the final 2.4 (i.e. XT hard disk support?)

* Go through as 2.4pre kicks in and figure out what FOO_DEBUG options
need to be turned off.  __iovirt_debug is a notable one that will hurt
performance (IMHO), because every write[bwl] gets routed to a function
call that checks stuff before performing the I/O.


>      * Union mount (Al Viro)

I think this is complete?  Isn't this mount --bind?

>      * Loop device can still hang (William Stearns has script that will
>        hang 2.4.0-test7, Peter Enderborg has a short sequence that will
>        hang 2.4.0test9)

Maybe combine this entry and the loopback crypto one above into a more
general "loopback works for some cases, deadlocks for others"

> 11. To Check
>      * NFS bugs are fixed

Is this worthy of an entry?   I think that every bug fix applied should
have a listing here, then.  :)  check that parport bugs are fixed. 
check that serial bugs are fixed.  etc. ...

>      * List of potential problems found by Stanford students using g++
>        hacks:
>           + Andy Chou's list of mismatched spinlocks and interrupts/bh
>             enable/disable.
>           + Seth Andrew Hallem's list potentially sleeping functions
>             called with interrupts off or spinlocks held.
>           + Dawson Engler's list of potential kmalloc/kfree bugs

A few people are hanging onto these lists, and going through them.  This
could be an 'in progress' item.


>      * Potential races in file locking code (Christian Ehrhardt -- patch
>        which may fix some of these posted by trond, at
>        http://boudicca.tux.org/hypermail/linux-kernel/2000week45/0404.htm
>        l)

I think trond's patch was applied.


>      * many drivers are not hot-plugging safe (__devinit/__devexit)
>        (Barklomiej Zolnierkiewicz)

Many drivers are not supposed to be hotplug safe!

If the hardware is not known to be hotpluggable, then the driver should
not use __devinit/exit.  Doing so needlessly avoids the __init code
drop, wasting memory.


> 12. Probably Post 2.4

>      * module remove race bugs (ipchains modules -- Rusty; won't fix for
>        2.4)

Is this an ipchains bug, or a more general module subsystem bug?


>      * NCR5380 isnt smp safe (Frank Davis --- belives the driver should
>        be rewritten)

hehe  I personally believe many of the current kernel drivers should be
rewritten ;-)

	Jeff


-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
