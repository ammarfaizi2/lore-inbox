Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284768AbRLSJdY>; Wed, 19 Dec 2001 04:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284629AbRLSJdO>; Wed, 19 Dec 2001 04:33:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56395 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284608AbRLSJc6>; Wed, 19 Dec 2001 04:32:58 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        Christian Koenig <ChristianK.@t-online.de>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Otto Wyss <otto.wyss@bluewin.ch>, Alexander Viro <viro@math.psu.edu>,
        antirez <antirez@invece.org>, Andreas Dilger <adilger@turbolabs.com>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        Craig Christophel <merlin@transgeek.com>
Subject: Re: Booting a modular kernel through a multiple streams file / Making Linux multiboot capable and grub loading kernel modules at boot time.
In-Reply-To: <200112181605.KAA00820@tomcat.admin.navo.hpc.mil>
	<m1r8prwuv7.fsf@frodo.biederman.org> <3C204282.3000504@zytor.com>
	<m1itb3wsld.fsf@frodo.biederman.org> <3C2052C0.2010700@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Dec 2001 02:12:31 -0700
In-Reply-To: <3C2052C0.2010700@zytor.com>
Message-ID: <m18zbzwp34.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Eric W. Biederman wrote:
> 
> > I have a personally dislike for using firmware calls to drive hardware
> > devices, so I won't be picking that up.  But I am interested in what
> > it requires to not burn bridges.  So I can make certain a linux kernel
> > loaded with a linux booting linux patch can requery the firmware.
> >
> 
> > My impression is that the linux kernel already does the important
> > things by not smashing firmware reserved memory, (assuming you aren't
> > loaded with loadlin).  So all that is required is to switch the idt
> > back to address 0, and switch the cpu back to 16bit real mode.
> > But if you know of other cases that need to be handled I would be
> > happy to hear about it.
> >
> 
> 
> Unfortunately that's not the case.  The big issue is "who owns the interrupt
> controller", and "who owns the interrupts." 
[snip]



> You can check out the BIOS extender I wrote for genesis at
> ftp://ftp.zytor.com/pub/linux/genesis/

Thanks.  I've got genesis-1.10 now looking and digesting to see if you
have any unexpected tricks takes a little longer.

For my purposes I intend to fully disable the BIOS and then after I
have done all of my work, reenable the BIOS.  Which should be a little
easier and have a slightly different set of issues. 

>From the 10,000 foot level it looks like I am pretty safe already
except for those BIOS functions that drive the hardware.  For those I
need to setup the legacy PIC back to it's default setting, and
possibly a few other hardware things.   I wonder just how sensitive
the an x86 BIOS really is to changing those things...

For the most part I find it perfectly acceptable if I break all of the
firmware hardware drivers.  As long as the information callbacks are
preserved.  But preserver enough so I could load dos from linux would
be nice.

Eric
