Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbQKCWWp>; Fri, 3 Nov 2000 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129094AbQKCWWf>; Fri, 3 Nov 2000 17:22:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:29203 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129069AbQKCWWT>;
	Fri, 3 Nov 2000 17:22:19 -0500
Message-ID: <3A033A45.D8F6E952@mandrakesoft.com>
Date: Fri, 03 Nov 2000 17:20:53 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu
CC: linux-kernel@vger.kernel.org, jeremy@goop.org,
        "David S. Miller" <davem@redhat.com>, rgooch@atnf.csiro.au,
        sct@redhat.com
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <200011031509.eA3F9V719729@trampoline.thunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu wrote:
> 4. Boot Time Failures
> 
>      * Crashes on boot on some Compaqs ? (may be fixed)

compaq laptops?  desktops?  or alphas?


>      * Various Alpha's don't boot under 2.4.0-test9 (PCI resource
>        allocation problem? Michal Jaegermann; Richard Henderson may have
>        an idea what's failing.)

Elaboration:  PCI-PCI bridges are not configured correctly

> 5. Compile errors

I doubt you need this category :)


> 6. In Progress
>      * Fix all remaining PCI code to use pci_enable_device (mostly done)

Most drivers are done, and all of the important drivers are done
(IMHO).  Maybe we could move this to a cleanup category?  Its definitely
not a showstopper..


>      * DMFE is not SMP safe (Frank Davis patch exists, but hasn't gotten
>        much commens yet)

update:  frank davis patch is poor.

DMFE accesses multiple hardware registers for a single operation, and
requires SMP locking to synchronize between all that code.


>      * Audit all char and block drivers to ensure they are safe with the
>        2.3 locking - a lot of them are not especially on the
>        read()/write() path. (Frank Davis --- moving slowly; if someone
>        wants to help, contact Frank)

Haven't heard any update on this in a long while...


>      * Fixing autofs4 to deal with VFS changes (Jeremy Fitzhardinge)

I thought this was complete a long time ago?


> 8. Fix Exists But Isnt Merged

>      * Many network device drivers don't call MOD_INC_USE_COUNT in
>        dev->open. (Paul Gortmaker has patches)

There exists a patch which makes MOD_xxx in net drivers obsolete.  I'm
hoping that one will get applied...


>      * mtrr.c is broken for machines with >= 4GB of memory (David Wragg
>        has a fix)

His patch looks ok to me, too....   Does somebody want to submit this
patch to Linus?  I haven't seen the maintainer (Richard Gooch) speak up
on this issue at all.


>      * Issue with notifiers that try to deregister themselves? (lnz;
>        notifier locking change by Garzik should backed out, according to
>        Jeff)

Done.


>      * The new hot plug PCI interface does not provide a method for
>        passing the correct device name to cardmgr (David Hinds, alan)

Move to "in progress"...


>      * 2.4.0-test8 pcmcia is unusable in fall forms (kernel, mixed, or
>        dhinds code) (David Ford)

"fall forms"?

David clearly has problems w/ pcmcia, but it is not at all as broken as
he makes it out to be:  all my cardbus laptops boot and work.


>      * Spin doing ioctls on a down netdeice as it unloads == BOOM
>        (prumpf, Alan Cox)

not an issue.


>	Possible other net driver SMP issues (andi
>        kleen)

No showstoppers AFAICS, but small races do exist.


>      * PCMCIA/Cardbus hangs (Basically unusable - Hinds pcmcia code is
>        reliable)

Again "whatever".  The CardBus code is definitely usable.  It is not
mature, but saying it is "basically unusable" is wildly inaccurate.


>      * RTL 8139 cards sometimes stop responding. Both drivers don't
>        handle this quite good enough yet. (reported by Rogier Wolff,
>        tentatively reported as fixed by David Ford; reports from Frank
>        Jacobberger and Shane Shrybman indicate that it doesn't appear to
>        be fixed in test9)

I'm hoping this is fixed in test10, but haven't gotten any reports back
yet...


>      * kiobuf seperate lock functions/bounce/page_address fixes

Do Stephen Tweedie's recently posted kiobuf patches fix this issue?


>      * Potential races in file locking code (Christian Ehrhardt)
>           + locks_verify_area checks the wrong range if O_APPEND is set
>             and the current file position is not at the end of the file.
>           + dito if the file position changes between the call to
>             locks_verify_area and the actual read/write (requires a
>             shared file pointer, an attacker can use this to circumvent
>             virtually any mandatory lock).
>           + active writes should prevent anyone from getting mandatory
>             locks for the area beeing written.
>           + active reads should prevent anyone from getting mandatory
>             write locks for the area beeing read.

a fix patch for file locks (related to nfs, but still it appears to fix
some general issues)  was posted this week:  
http://boudicca.tux.org/hypermail/linux-kernel/this-week/0404.html


>      * Eepro100 driver can sometimes report out of resources on reboot
>        (Josue Emmanuel Amaro)

More than just on reboot.

-- 
Jeff Garzik             | Dinner is ready when
Building 1024           | the smoke alarm goes off.
MandrakeSoft            |	-/usr/games/fortune
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
