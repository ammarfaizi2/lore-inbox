Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267541AbTBFXGX>; Thu, 6 Feb 2003 18:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267542AbTBFXGW>; Thu, 6 Feb 2003 18:06:22 -0500
Received: from fubar.phlinux.com ([216.254.54.154]:1514 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP
	id <S267541AbTBFXGT>; Thu, 6 Feb 2003 18:06:19 -0500
Date: Thu, 6 Feb 2003 15:15:52 -0800 (PST)
From: Matt C <wago@phlinux.com>
To: David Brown <dave@codewhore.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CCISS driver and disk failure...
In-Reply-To: <Pine.LNX.4.44.0302051806010.3082-100000@fubar.phlinux.com>
Message-ID: <Pine.LNX.4.44.0302061512020.32730-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David-

I noticed that the disk array component of this stuff actually does not 
require the kernel modules, which is good news. So, you should be able to 
install the 'cmafdtn', 'cmastor', 'cpqhealth' and 'ucd-snmp' RPMs from 
compaq and monitor your drives via SNMP without using their darn kernel 
modules. I assume that it's communicating with the array via the cciss 
driver in some way.

Hope this helps.

-Matt

On Wed, 5 Feb 2003, Matt C wrote:

> Hi David-
> 
> The only way we're able to do this on proliants is to use the *hack* 
> closed-source HP kernel modules cpqasm and cpqevt. We then run their 30+ 
> userspace daemons that monitor the system via these 2 kernel modules. Slap 
> their hacked up ucd-snmpd on top of that and you get disk status 
> monitoring via SNMP on the machine.
> 
> On a redhat machine, that's the following RPMs from HP:
> cmafdtn
> cmanic
> cmastor
> cmasvr
> cpqhealth
> ucd-snmp (from HP, of course)
> 
> It's a nasty mess, though, so if the cciss author had the time to put disk 
> fail logging into the driver, that'd be amazingly cool.
> 
> -Matt
> 
> On Tue, 4 Feb 2003, David Brown wrote:
> 
> > Hi:
> > 
> > Does anyone know of an easy way to get messages (via syslog or
> > otherwise) when a member disk of a CCISS SMART-2 raid array fails?
> > Grepping through drivers/block/cciss.c didn't yield any obvious
> > printk's. My gut feeling is that one could get the disk failure
> > information through one of the CCISS_PASSTHRU ioctls(); I saw some
> > reference to a similar call in code for monitoring the cpqarray
> > driver.
> > 
> > HP appears to have some sort of management suite, but it appears to
> > require X11 server-side, which isn't an option on this machine.
> > 
> > Is there an easy way to get disk failure information from the CCISS
> > driver, or should I continue relying on the pretty LEDs? :)
> > 
> > 
> > Thanks in advance,
> > 
> > - Dave
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

