Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRBVSKR>; Thu, 22 Feb 2001 13:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbRBVSKI>; Thu, 22 Feb 2001 13:10:08 -0500
Received: from pcsalo.cern.ch ([137.138.213.103]:2063 "EHLO pcsalo.cern.ch")
	by vger.kernel.org with ESMTP id <S129682AbRBVSKD>;
	Thu, 22 Feb 2001 13:10:03 -0500
Message-ID: <3A9555E9.826DAFE5@cern.ch>
Date: Thu, 22 Feb 2001 18:09:45 +0000
From: Fons Rademakers <Fons.Rademakers@cern.ch>
Organization: CERN
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: timw@splhi.com
CC: linux-kernel@vger.kernel.org, andre@suse.com, omnibook@zurich.ai.mit.edu
Subject: Re: had: lost interrupt...
In-Reply-To: <20010217100820.A16593@pcsalo.cern.ch> <20010221162449.B2118@kochanski.internal.splhi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

  thanks for answering. However, I found the problem for my laptop. It was due
to the broken /etc/sysconfig/apm-scripts/... in RH7.0 that was always executing
the xlock and xcreensaver on suspend. Correcting this script and not running
this xlock stuff the interrupt lost problem disappeared. However, it should not
have happened in the first place so maybe you suggestion would allow one to
run both xlock on suspend and still being able to resume. I'll try that although
I won't need the xlock feature.

Cheers, Fons.



Tim Wright wrote:
> 
> You didn't give the (likely more) important part of your .config, but I'll bet
> that you have CONFIG_APM_ALLOW_INTS disabled. Turn it on, rebuild and reboot.
> At least on a Thinkpad T20, trying to use UDMA, and APM without APM_ALLOW_INTS
> enabled gives an 'hda: lost interrupt'. Even worse, I didn't hang, but was able
> to go on and trash my hard drive :-(
> With CONFIG_APM_ALLOW_INTS turned on, everything behaves nicely.
> 
> Tim
> 
> On Sat, Feb 17, 2001 at 10:08:21AM +0100, Fons Rademakers wrote:
> > Hi,
> >
> >    in my laptop (HP 4150B) I upgraded from a 12GB IBM Travelstar to an
> > 20GB IBM Travelstar (both 4200rpm). After the upgrade I moved also to
> > 2.4.2-pre3 and reiserfs. However, the problem I now have is that after
> > resume I get the message "hda: lost interrupt" and the only thing to do
> > is to reset the machine (in the only good thing is that reiserfs saved
> > me a lot of fsck time).
> >
> > Any idea what the problem might be? Is the larger disk not supported by
> > the BIOS (it is recognized properly). People mentioned not to use DMA
> > anymore?
> >
> > With 2.2.18 and the 12GB disk there were never problems (except that the
> > disk got bad blocks ;-().
> >
> > My IDE setup in .config is below.
> >
> >
> > Cheers, Fons.
> >
> [IDE config elided]
> 
> --
> Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
> IBM Linux Technology Center, Beaverton, Oregon
> Interested in Linux scalability ? Look at http://lse.sourceforge.net/
> "Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI

-- 
Org:    CERN, European Laboratory for Particle Physics.
Mail:   1211 Geneve 23, Switzerland
E-Mail: Fons.Rademakers@cern.ch              Phone: +41 22 7679248
WWW:    http://root.cern.ch/~rdm/            Fax:   +41 22 7677910
