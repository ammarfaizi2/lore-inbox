Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129245AbRCBPbj>; Fri, 2 Mar 2001 10:31:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129249AbRCBPba>; Fri, 2 Mar 2001 10:31:30 -0500
Received: from ns2.cypress.com ([157.95.67.5]:64158 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S129245AbRCBPbU>;
	Fri, 2 Mar 2001 10:31:20 -0500
Message-ID: <3A9FBCB4.3F3931F8@cypress.com>
Date: Fri, 02 Mar 2001 09:31:00 -0600
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
        Hylke van der Schaaf <hylke@lx.student.wau.nl>
Subject: Re: DMA on a AMD7409 controller with kernel 2.4.2
In-Reply-To: <Pine.LNX.4.10.10103011556310.10136-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 1 Mar 2001, Hylke van der Schaaf wrote:
> 
> > With kernet 2.2.18 DMA mode for my harddisks worked just fine,
> > getting IDE DMA working on an AMD7409 controller with kernel 2.4.2 is a problem.
> >
> > questions:
> > Why is DMA disabled on revision < C4?
> > How can I gat DMA working again?
> > in 2.2.18 I get:
> > hylke:/home/hylke# hdparm -tT /dev/hda
> >
> > /dev/hda:
> >  Timing buffer-cache reads:   128 MB in  0.89 seconds =143.82 MB/sec
> >  Timing buffered disk reads:  64 MB in  2.85 seconds = 22.46 MB/sec
> > ----------------------------
> >
> > All was fine.
> > I compiled 2.4.2, with:
> >       CONFIG_AMD7409_OVERRIDE=y

I'm not using this, since my drives are not UDMA66 or UDMA100

> > hylke:/home/hylke# hdparm -v /dev/hda
> >
> > /dev/hda:
> >  multcount    = 16 (on)
> >  I/O support  =  1 (32-bit)
> >  unmaskirq    =  1 (on)
> >  using_dma    =  0 (off)
> >  keepsettings =  0 (off)
> >  nowerr       =  0 (off)
> >  readonly     =  0 (off)
> >  readahead    =  8 (on)
> >  geometry     = 2495/255/63, sectors = 40088160, start = 0
> > hylke:/home/hylke# hdparm -tT /dev/hda
> >
> > /dev/hda:
> >  Timing buffer-cache reads:   128 MB in  0.90 seconds =142.22 MB/sec
> >  Timing buffered disk reads:  64 MB in 12.59 seconds =  5.08 MB/sec

I get 148.8 and 12 MB/sec on my IBM-DTTA-351010 drives.
I get the same message about no single word DMA due
to chip revision.
# hdparm -v /dev/hda

/dev/hda:
multcount    = 16 (on)
I/O support  =  3 (32-bit w/sync)
unmaskirq    =  0 (off)
using_dma    =  1 (on)
keepsettings =  0 (off)
nowerr       =  0 (off)
readonly     =  0 (off)
readahead    =  8 (on)
geometry     = 19650/16/63, sectors = 19807200, start = 0

What does /proc/ide/hda/settings show?
What about /proc/ide/amd74xx ?


	-Thomas
