Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbTBCULh>; Mon, 3 Feb 2003 15:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264877AbTBCULa>; Mon, 3 Feb 2003 15:11:30 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:10761 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S266274AbTBCUK6>; Mon, 3 Feb 2003 15:10:58 -0500
Date: Mon, 3 Feb 2003 20:20:30 +0000
From: John Levon <levon@movementarian.org>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Switch APIC to driver model (and make S3 sleep with APIC on)
Message-ID: <20030203202029.GA99614@compsoc.man.ac.uk>
References: <200301280121.CAA13798@harpo.it.uu.se> <20030202124235.GA133@elf.ucw.cz> <20030203103254.GA25619@compsoc.man.ac.uk> <20030203154008.GC480@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030203154008.GC480@elf.ucw.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18fn4w-00072x-00*qMwH.J4VGx6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 04:40:08PM +0100, Pavel Machek wrote:

> should apt-get install

not packaged yet I'm afraid. Get
http://movementarian.org/oprofile-0.5.tar.gz, ./configure \
--with-kernel-support && make && make install

> --ctr0-event=CPU_CLK_UNHALTED && opcontrol --start

If it's an Intel CPU (not pentium 4) this should be OK
For Athlon, use INST_RETIRED

> do the trick? If that works does it mean oprofile is okay?

Run a few kernel compiles and stress it a bit. Run "op_time" to check
you get output...

> > I don't pretend to understand the PM layer at all, but it looks like
> > that both nmi.c's and oprofile's resume functions will get called. This
> > won't work: if oprofile has control of the perfctr's/nmi stuff, you
> > can't let the NMI watchdog's resume() be called, as it may conflict with
> > what oprofile is trying to resume.
> 
> oprofile() should already have checks to prevent that, and I added one

I haven't seen where you added these checks. They did not exist before:
oprofile took responsibility for the NMI/perfctr handling off the NMI
watchdog entirely, then handed it back when oprofile finished.

Basically you have to ensure that only the right pm callback is called,
not both.

> [        if (nmi_watchdog == NMI_LOCAL_APIC)

I don't see an added line like this ?

regards
john
