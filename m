Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312455AbSCYSCf>; Mon, 25 Mar 2002 13:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312476AbSCYSC0>; Mon, 25 Mar 2002 13:02:26 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:38414 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312455AbSCYSCP>;
	Mon, 25 Mar 2002 13:02:15 -0500
Date: Mon, 25 Mar 2002 10:01:33 -0800
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020325180133.GB28629@kroah.com>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy> <20020323224433.GB11471@ufies.org> <20020324080729.GD16785@kroah.com> <20020324142545.GC20703@ufies.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Mon, 25 Feb 2002 15:20:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2002 at 09:25:45AM -0500, christophe barbé wrote:
> On Sun, Mar 24, 2002 at 12:07:29AM -0800, Greg KH wrote:
> > On Sat, Mar 23, 2002 at 05:44:33PM -0500, christophe barbé wrote:
> > > With the 'everything is module' and 'everything is hotplug' approach in
> > > mind (which is a appealing way and IMHO this is the way we are going),
> > > I see two part for this problem:
> > > 
> > > . Persistence after plug out/plug in 
> > > 
> > > . Persistence after suspend/resume
> > > 
> > > The first one is a userland problem. The card identification could be
> > > based on the MAC address (for NICs at least, in the case of cardbus the
> > > bus position has no real signification). This should then be the
> > > responsibility of the userspace tool (hotplug) to indicate the correct
> > > option for this card. The problem is when the module is already loaded,
> > > the userspace tool has no way to indicate this option.
> > 
> > Untrue.  See
> > 	http://www.kroah.com/linux/hotplug/ols_2001_hotplug_talk/html/mgp00014.html
> > for a 6 line version of /sbin/hotplug that always assigns the same
> > "ethX" value to the same MAC address.  I think the patch to nameif has
> > gone in to support this, but I'm not sure.
> 
> Untrue what ? The persistence after plug out/in ?

No, the sentence, "The problem is when the module is already loaded..."
/sbin/hotplug gets called when the network device is started up, it
doesn't only get called before the module is loaded.

> The problem here is not to give the same interface to a given NIC. The
> problem is to give the same options to a given NIC. But a solution can
> simply be to set the option from hotplug using the proc interface. The
> 3c59x doesn't support that for wol but that can be changed.

Understood.

> > And why is there a limitation of only 8 devices?  Why not do what all
> > USB drivers do, and just create the structure that you need to use at
> > probe() time, and destroy it at remove() time?
> 
> This is an implementation issue which is not really important. It comes
> from Donald Becker. Your dynamic structure doesn't solve the problem
> 'which options for which cards', does it ? 

No, but it solves the problem, "only 8 devices max", and "what to do
when a card is removed and then plugged back in."  Both seems like good
things to fix in the driver :)

thanks,

greg k-h
