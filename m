Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTBFB7m>; Wed, 5 Feb 2003 20:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbTBFB7m>; Wed, 5 Feb 2003 20:59:42 -0500
Received: from fubar.phlinux.com ([216.254.54.154]:49560 "EHLO
	fubar.phlinux.com") by vger.kernel.org with ESMTP
	id <S264756AbTBFB7l>; Wed, 5 Feb 2003 20:59:41 -0500
Date: Wed, 5 Feb 2003 18:09:13 -0800 (PST)
From: Matt C <wago@phlinux.com>
To: David Brown <dave@codewhore.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CCISS driver and disk failure...
In-Reply-To: <20030204215358.GA6266@codewhore.org>
Message-ID: <Pine.LNX.4.44.0302051806010.3082-100000@fubar.phlinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David-

The only way we're able to do this on proliants is to use the *hack* 
closed-source HP kernel modules cpqasm and cpqevt. We then run their 30+ 
userspace daemons that monitor the system via these 2 kernel modules. Slap 
their hacked up ucd-snmpd on top of that and you get disk status 
monitoring via SNMP on the machine.

On a redhat machine, that's the following RPMs from HP:
cmafdtn
cmanic
cmastor
cmasvr
cpqhealth
ucd-snmp (from HP, of course)

It's a nasty mess, though, so if the cciss author had the time to put disk 
fail logging into the driver, that'd be amazingly cool.

-Matt

On Tue, 4 Feb 2003, David Brown wrote:

> Hi:
> 
> Does anyone know of an easy way to get messages (via syslog or
> otherwise) when a member disk of a CCISS SMART-2 raid array fails?
> Grepping through drivers/block/cciss.c didn't yield any obvious
> printk's. My gut feeling is that one could get the disk failure
> information through one of the CCISS_PASSTHRU ioctls(); I saw some
> reference to a similar call in code for monitoring the cpqarray
> driver.
> 
> HP appears to have some sort of management suite, but it appears to
> require X11 server-side, which isn't an option on this machine.
> 
> Is there an easy way to get disk failure information from the CCISS
> driver, or should I continue relying on the pretty LEDs? :)
> 
> 
> Thanks in advance,
> 
> - Dave
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

