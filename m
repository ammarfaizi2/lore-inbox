Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263786AbREYQEX>; Fri, 25 May 2001 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263785AbREYQEN>; Fri, 25 May 2001 12:04:13 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:17728 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263783AbREYQEI>; Fri, 25 May 2001 12:04:08 -0400
Message-ID: <3B0E82F7.4ACF8CF8@redhat.com>
Date: Fri, 25 May 2001 12:06:15 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: acahalan@cs.uml.edu, aaronl@vitelus.com, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
In-Reply-To: <200105250934.CAA23240@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:

>         On the question of whether this is nothing more than
> aggregation,

Yes, on that very question, I would argue it is a mere aggregation.

> the firmware works intimately with the device driver to
> produce a unitary result.

Irrelevant.  All drivers work with some sort of firmware on their respective
targets to produce a unitary result, even if that firmware is implemented with
silicon (as a ROM BIOS that loads the proper firmware code, or as
microcode/state hardware built into the chip(set) itself).  As a closely
similar device, think about the 1542 SCSI controller.  It has a BIOS that must
load firmware before the card will work.  The only difference between it and
the device you are arguing about is *how* the firmware gets loaded, and by
what program, not whether the firmware gets loaded or whether the firmware is
required for the device to be in the least bit usefull as a computer
component.

>  The part of the driver that runs in the
> device and the CPU side speak a mutually agreed upon protocol, and the
> unitary result is that you do not have to preload the firmware as
> earlier versions of the driver required.

Again, irrelevant.  This has always been done.  In the past, it was done by a
user land program.  Now it's done as part of the kernel.  So, the code now
knows how to speak "load the firmware" language to the chipset.  This is a
feature of the driver that is, in fact, not in the least bit related to the
firmware itself.  The driver could load garbage to the device and this code
would be working properly.  The choice of what data to upload to a device is
distinctly different from the ability to upload data.

>  You actually have to do some
> kernel development to remove the code.

That's because you are assuming that uploading garbage to the device is not an
option.  This is incorrect.  You can in fact remove the firmware and upload
garbage.  The result would be that the device would not work as expected. 
Would this be because of a bug in the firmware loading code?  No.  It would be
because you uploaded garbage.  You could likewise make a much smaller
modification to the driver so that it would allow you to specify whether or
not to upload the code, then tell it not to upload the code, and preload the
firmware as before and things would work without removing the ability to
upload code from the driver.  You could also modify the driver to pass the
firmware to the driver via an initrd or some such and have this code work
without having the .h file included in the .o archive.

>  It's not simply the case that
> you could just skip distribution of an extra file and have the rest of
> the functionality work. 

That is exactly the case.  The only change that must be made to remove that .h
file from the driver source is to tell the driver where the *new* location of
the correct firmware is.  This does not constitute a dependancy on having the
firmware included in the driver, it merely constitutes a hard coded, expected
location of the firmware that must be updated whenever the firmware is moved.

> In fact, even if you zeroed out the
> microcode, you would still not get the result of having the driver
> work (e.g., if you had loaded the code originally).  Instead, the
> driver would fill the device with all zeroes.

And thank you for making my point.  The upload code would in fact work, it
would just upload a bogus firmware.  Bad data is bad data.  However, stating
that providing a driver with bad data makes it fail is a non-issue and proves
nothing.  I could write all 0's to the PCI bridge in my system and it wouldn't
work properly.  Duhhhh.....who would expect it to?

>  Greg Kroah-Hartman has
> already said he thinks removal is complicated enough that he does not
> want to voluntarily do it in 2.4.

Aka, he doesn't want to correct/work around the fact that the driver has the
location of the firmware data hard coded right now.  He doesn't have to remove
all the upload code to remove the firmware file, he merely has to teach the
driver to find the firmware code elsewhere or to not upload garbage when it
doesn't know where the firmware is.

>  For these reasons, this situation
> is not just shipping two works next to each other (mere aggregation).

Your reasons are bogus, it's a mere aggregation.

>         I hope it should be clear now that the GPL can and does
> prohibit #include'ing this and that it is not mere aggregation.
> 
>         I also hope that people understand that while I think the
> stability argument for not including my fix in 2.4 (which everyone
> seems to like technically) is BS, I would be satisfied if the
> keyspan_usa drivers were now released under GPL-compatible copying
> conditions.  However, it has now been weeks this has not been done.
> 
> Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
> adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
> +1 408 261-6630         | g g d r a s i l   United States of America
> fax +1 408 261-6631      "Free Software For The Rest Of Us."
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
