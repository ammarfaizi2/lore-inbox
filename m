Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRDSQLD>; Thu, 19 Apr 2001 12:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRDSQJV>; Thu, 19 Apr 2001 12:09:21 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:64268 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S131205AbRDSQJM>;
	Thu, 19 Apr 2001 12:09:12 -0400
Message-ID: <25369470B6F0D41194820002B328BDD27C92@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: FW: Bug in serial.c
Date: Thu, 19 Apr 2001 12:09:04 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

-----Original Message-----
From: Marc Karasek
To: 'Disconnect '
Sent: 4/19/01 11:49 AM
Subject: RE: Bug in serial.c

 I have changed everything to point to /dev/ttyS0.  The settings in
lilo.conf (I am booting from a floppy to emulate the embedded space) are
all for ttyS0.  Lilo pritns to the terminal (minicom on another Linux
box) and the kernel prints as well.  When I get to inittab (running
busybox) it asks for some input thru a script to setup the embedded
emulation.  At this point it just sits there.  If I turn on the debug in
serial.c I can see the characters (hex values) as I type.  Kernel 2.4.2
works fine, with the only problem being the smp compile issue.  As I
need module support and cannot have a kernel of 600k+ size I am in a bit
of a pickle.....



-----Original Message-----
From: Disconnect
To: Marc Karasek
Cc: 'linux-kernel@vger.kernel.org'
Sent: 4/19/01 11:38 AM
Subject: Re: Bug in serial.c

On Thu, 19 Apr 2001, Marc Karasek did have cause to say:

> 2) In 2.4.3 the console port using ttySX is broken.  It dumps fine to
the
> terminal but when you get to a point of entering data (login,
configuration
> scripts, etc) the terminal does not accept any input.  

Most gettys and such take a /dev/tty* argument, which has to be changed
to
point to the serial port for a serial console. Config scripts (and
anything else) specifically using /dev/tty or /dev/console should work
fine, however. (I wouldn't recommend pointing a getty at /dev/console -
we
had some issues on a headless server trying that. Easiest to point it at
/dev/ttyS0 or whatnot.)

> 
> So far I have been able to debug to the point where I see that the
kernel is
> receiving the characters from the serial.c driver.  But it never echos
them
> or does anything else with them.  I will continue to look into this at
this
> end.  
> 
> I was also wondering if anyone else has seen this or if a patch is
avail for
> this bug??
> 
> Marc Karasek
> Sr. Firmware Engineer
> iVivity Inc
> marc_karasek@ivivity.com  
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---
   _.-=<Disconnect>=-._
|     dis@sigkill.net    | And Remember...
\  shawn@healthcite.com  / He who controls Purple controls the
Universe..
 PGP Key given on Request  Or at least the Purple parts!

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P+>+++ L++++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t 5--- 
X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
