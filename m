Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266135AbTAIL5J>; Thu, 9 Jan 2003 06:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265909AbTAIL5J>; Thu, 9 Jan 2003 06:57:09 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:29131 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S265894AbTAIL5G>; Thu, 9 Jan 2003 06:57:06 -0500
Date: Thu, 9 Jan 2003 03:52:51 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: dipankar@in.ibm.com, <linux-scsi@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx broken in 2.5.53/54 ?
In-Reply-To: <274040000.1041869813@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.44.0301090346180.28704-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just tried 2.5.55 and it still locks up. I will hook up my laptop and
see if I can get aa serial console dump tomorrow night.

messages are

Slave Alloc 0
launching DV thread
begin domain validation
scsi0:2477 going from state 0 to state 1
scsi0:A:0:0: sending INQ
scsi0:timeout while doing DV command 12
scsi0:0:0:0 command completed status=0x90000
scsi0:A:0:0 enntering ahc_linux_dv_transition, state=1 statis=0x14005, cmd->result=0x90000
scsi0:2645 going from state 1 to state 1

at this point all the messages between the 'going to state' messages
repeat exactly, this happens for a couple min and then a whole bunch of
other stuff scrolls by (I don't know if this happens on previous versions,
I had given up before that much time had passed) the final message is
something about a recovery sleep and then the machine stops responding (I
waited 10 min this time to make sure it wasn't going to start working
again)

Daavid Lang

 On Mon, 6 Jan 2003, Justin T. Gibbs wrote:

> Date: Mon, 06 Jan 2003 09:16:53 -0700
> From: Justin T. Gibbs <gibbs@scsiguy.com>
> To: dipankar@in.ibm.com
> Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
> Subject: Re: aic7xxx broken in 2.5.53/54 ?
>
> > Hi Justin,
> >
> > On Fri, Jan 03, 2003 at 08:14:06AM -0700, Justin T. Gibbs wrote:
> >> > Looks like the aic7xxx driver in 2.5.53 and 54 are broken on my
> >> > hardware.
> >>
> >> It looks like the driver recovers fine.
> >
> > Not for long. It dies shortly afterwards.
>
> In what fashion?
>
> >> > aic7xxx: PCI Device 0:1:0 failed memory mapped test.  Using PIO.
> >> > Uhhuh. NMI received for unknown reason 25 on CPU 0.
> >>
> >> SERR must be enabled by your BIOS.  I will change the driver so
> >> that, should the memory mapped I/O test fail, an SERR (and thus an
> >> NMI) is not generated.
> >
> > I guess having to use PIO with aic7xxx is bad. MMIO failure is
> > what we need to investigate.
>
> The only way that I know how to investigate these issues is
> with a PCI bus analyzer.  We're in the process of going through
> all of the systems we have in our lab to see which ones fail and
> why, but I certainly don't have one of every failing system on
> the planet. 8-)
>
> >> Just out of curiosity, do you have any strange PCI options enabled
> >> in your BIOS?  I remeber seeing memory mapped I/O failures on this
> >> ServerWorks chipset under FreeBSD in the past, but an updated BIOS
> >> resolved the issue for the affected users.  It seemed that the BIOS
> >> incorrectly placed the Adaptec controller in a prefetchable region.
> >>
> >
> > I didn't change anything in that box since it was delivered to me. FYI
> > it is an IBM x250. Would it help if I can get a PCI space dump and mtrr
> > dump ? FWIW, the older driver works fine. Does the older driver use
> > only PIO ?
>
> It would be good to know the chipset on the motherboard.  As to why
> the old driver worked, for 6.X.X drivers, you may have just been lucky.
> For 5.X.X drivers, they perform a read after every register write to
> "manually" prevent any byte-merging.  These reads are actually more
> expensive than just using PIO.  Neither of these older drivers included
> a test to try and catch fishy behavior.
>
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
