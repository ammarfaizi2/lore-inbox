Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313928AbSDFC4K>; Fri, 5 Apr 2002 21:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313931AbSDFC4B>; Fri, 5 Apr 2002 21:56:01 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:22799 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S313928AbSDFCzm>; Fri, 5 Apr 2002 21:55:42 -0500
Message-ID: <003301c1dd16$855df1b0$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <00c501c1dce3$0ed806d0$7e0aa8c0@bridge> <1674141067.1018028922@[10.10.2.3]>
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Date: Fri, 5 Apr 2002 18:55:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Sent: Friday, April 05, 2002 5:48 PM

> I need to avoid going through the BIOS ... this is a
> multiquad NUMA machine, and it doesn't take kindly
> to the reboot through the BIOS for various reasons.
> It also takes about 4 minutes, which is a pain ;-)
>
> I have source code access to our BIOS if I really wanted,
> I just want to avoid modifying it if possible.

well keep in mind that the fastest LinuxBIOS boot is 3 seconds...
a large part of the boot time on most PCs is the BIOS setting up
DOS support and painting silly logos on the screen, all of which
can go away.  I'm guessing your NUMA system has a bit more
to do at this stage due to the hardware, but still...

>
> > there are patches where a kernel can load another
> > kernel, also.
>
> Hmmm ... sounds interesting ... any pointers?

LOBOS,

http://www.acl.lanl.gov/linuxbios/papers/index.html
http://www.usenix.org/publications/library/proceedings/als2000/minnichLOBOS.
html

two kernel monte,

http://www.scyld.com/products/beowulf/software/monte.html

There's also suspend to disk support, which is closely related.
Kind of a restartable crash dump, without the crash:

http://falcon.sch.bme.hu/~seasons/linux/swsusp.html

>
> > As for taking crashdumps on the way up, I believe
> > (SGI's ?) linux kernel crash dumps does *exactly*
> > this.
>
> I was under the impression that most BIOSes reset
> memory on reboot, so this was impossible during a
> BIOS reboot?

oss.sgi.com seems to be down today... but iirc,
it doesn't boot through bios, but stashes some critical state
in a buffer previously reserverd, uses one of the above methods
to boot a new kernel, lets this kernel do the dump, then boots
through the bios to make sure hardware is completely restored
after the crash.  I'm sure it could be tailored to suit though.

I'm currently researching combining the two, to create a LinuxBIOS
firmware debug console, which will allow complete crash dump to
be taken after a hardware reset, with the smallest possible Heisenburg
effect, aside from a hardware debugger.

Basically when the kernel panics, it dumps the CPU registers and
resets the CPU.  The firmware console makes no alterations to
the state of the hardware, instead running a modified kgdb stub
like routine, possibly without even touching RAM.  Also, if an SMI
button is available, this can be used as a hardware break switch,
allowing panics to use an even less invasive HLT instruction.

Jeremy

