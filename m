Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311743AbSCXIIU>; Sun, 24 Mar 2002 03:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311748AbSCXIIK>; Sun, 24 Mar 2002 03:08:10 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:29195 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S311743AbSCXIH7>;
	Sun, 24 Mar 2002 03:07:59 -0500
Date: Sun, 24 Mar 2002 00:07:29 -0800
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@tech9.net>, Andrew Morton <akpm@zip.com.au>,
        christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020324080729.GD16785@kroah.com>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy> <20020323224433.GB11471@ufies.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 24 Feb 2002 05:05:43 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2002 at 05:44:33PM -0500, christophe barbé wrote:
> With the 'everything is module' and 'everything is hotplug' approach in
> mind (which is a appealing way and IMHO this is the way we are going),
> I see two part for this problem:
> 
> . Persistence after plug out/plug in 
> 
> . Persistence after suspend/resume
> 
> The first one is a userland problem. The card identification could be
> based on the MAC address (for NICs at least, in the case of cardbus the
> bus position has no real signification). This should then be the
> responsibility of the userspace tool (hotplug) to indicate the correct
> option for this card. The problem is when the module is already loaded,
> the userspace tool has no way to indicate this option.

Untrue.  See
	http://www.kroah.com/linux/hotplug/ols_2001_hotplug_talk/html/mgp00014.html
for a 6 line version of /sbin/hotplug that always assigns the same
"ethX" value to the same MAC address.  I think the patch to nameif has
gone in to support this, but I'm not sure.

And why is there a limitation of only 8 devices?  Why not do what all
USB drivers do, and just create the structure that you need to use at
probe() time, and destroy it at remove() time?

Just my $0.02

thanks,

greg k-h
