Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314044AbSDKNMl>; Thu, 11 Apr 2002 09:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314045AbSDKNMk>; Thu, 11 Apr 2002 09:12:40 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:62726 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S314044AbSDKNMj>; Thu, 11 Apr 2002 09:12:39 -0400
Date: Thu, 11 Apr 2002 09:09:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Baldur Norddahl <bbn-linux-kernel@clansoft.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: More than 10 IDE interfaces
In-Reply-To: <3CB53D70.5070100@evision-ventures.com>
Message-ID: <Pine.LNX.3.96.1020411085829.3677F-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2002, Martin Dalecki wrote:

> Baldur Norddahl wrote:
> > Hi,
> > 
> > I have a machine with the following configuration:
> > 
> > 2 on board IDE interfaces (AMD chipset)
> > 2 Promise Technology UltraDMA100 controllers with each 2 IDE interfaces.
> > 4 Promise Technology UltraDMA133 controllers with each 2 IDE interfaces.
> > 
> > This adds up to 14 IDE interfaces. And I just discovered that the kernel
> > only supports 10 IDE interfaces :-(
> > 
> > So I tried to hack the kernel, and I was partially successfull. I changed
> > MAX_HWIF from 10 to 14. I made up some major numbers for the extra
> 
> In your case if should be changed to 15 there is an off by one error here in the
> interpretation of this constant.

  ??? If the current value is 10, and supports 10 interfaces, and I
believe that is the case, why should he need a value of 15 to get 14?
Doesn't the off by one error happen on smaller values, or what?

  I am NOT disagreeing with you, I just don't see how to code an off by
one and have it work some of the time and not others.
 
> > interfaces (115, 116, 117 and 118).
> > 
> > drivers/ide/ide.c and fs/partitions/check.c were modified to know about
> > IDE10_MAJOR to IDE13_MAJOR.
> > 
> > With there changes the kernel detects the extra interfaces and the disks on
> > them. They get some strange names like IDE< and the last disk is named hd{,
> > but I guess I can live with that :-)
> 
> The cause of those funny names is well known in the 2.5.xx series.
> The solution to it will first involve a complete rewrite of the kernel
> parameter parsing in ide.c

  I thought devfs was supposed to eliminate all this stuff and replace
names with long hierarchical names. In hindsight it probably would have
been better to call drives something like hdNNX, where NN is the interface
and X is m or s. Hum, I wonder how hard that would be as a retrofit?

> > But when it tries to detect the partitions on the extra interfaces, it locks
> > up. The last lines it writes is:
> > 
> > Partition check:
> >  hda: hda1
> >  hde: hde1
> >  hdg: hdg1
> >  hdi: hdi1
> >  hdk: hdk1
> >  hdm: hdm1
> >  hdo: hdo1
> >  hdq: hdq1
> >  hds: hds1
> >  hdu:
> 
> See above + make MAX_HWIFS 15 and you should have more luck. (Not tested
> actually).

  Right. I would be interested in this one myself, but I don't have a good
way of getting that many drives attached. I have a pile of old Promise
ATA33 cards, and I could come up with a hundred 400-500MB drives, but the
case and cabling is a serious issue.

  Anyway, if you have a moment to hint why an off by one error is not
biting us on ten drives I'd be interested.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

