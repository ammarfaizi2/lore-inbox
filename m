Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312894AbSDGBbi>; Sat, 6 Apr 2002 20:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312896AbSDGBbh>; Sat, 6 Apr 2002 20:31:37 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:50115 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312894AbSDGBbh>; Sat, 6 Apr 2002 20:31:37 -0500
Date: Sat, 06 Apr 2002 17:32:19 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Faster reboots (and a better way of taking crashdumps?)
Message-ID: <1759496962.1018114339@[10.10.2.3]>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Be very careful with loading a boot sector.  The problem is
> that lilo will ask the BIOS to drive the disk, and the disk
> is almost certainly in a different state than when the BIOS left it,
> and the BIOS hasn't been given a reset state command.  Without letting
> the BIOS know you did something strange you are going out and looking
> for trouble.

Good point. I would need to jump back to 16 bit mode (which there's
already code to do) and reset the disk.

> But if you can load a boot sector you can just about as easily load
> the whole kernel, which on startup will only ask the BIOS hardware
> information and not to drive the hardware (which should be safe).

Mmmm ... I'd have to reimplement most of the bootloader in order to
read the mapped blocks off disk and duplicate the use of lilo.conf, 
etc to make it usable ... not too attractive an option ... I think
it'd be easier to reutilise what we have already.

>> 2. Things that are reset by reboot that we don't reset during
>> normal kernel boot?
> 
> A sane BIOS will toggle the board level reset line on reboot.
> The all don't but that makes it look like a fresh boot, with
> a negligible speed penalty.

I know that, but what I mean is that I'm *not* going to get
this reset if I just jump back to the init point ... I was
trying to work out what kind of trouble that would cause.

> Seriously check out my code it should just work unless there are 

OK, I took a very brief scan of just the descriptions of your
patches - looks like the main thing you're doing is creating
a 32 bit kernel entry point, right? So above and beyond that
I'd have to rework the LILO code to work in 32 bit, which 
probably isn't that hard now I think about it ... all the hard
stuff is actually done by the command line binary, so maybe ...

> special apic shutdown rules for NUMAQ machines.

The APICs should be OK ... the interconnect firmware sets them
up, and Linux never changes them, so everything *should* be OK
in theory. Of course if it ever gets screwed up, reboot won't
fix it, but then I can't reboot at all right now, so ... ;-)

On the other hand, I don't reset the processors fully (I have
to use NMI to boot rather than the INIT, INIT, STARTUP sequence),
which seems to be asking for trouble ;-(

M.

