Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUBHO2J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 09:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUBHO2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 09:28:09 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:36101 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263679AbUBHO2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 09:28:05 -0500
Date: Sun, 8 Feb 2004 15:40:52 +0100
To: "John J. Foster" <festus@frognet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sound and multiple X-servers
Message-ID: <20040208144052.GA16903@hh.idb.hist.no>
References: <1076197321.8976.3.camel@Highway-61>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076197321.8976.3.camel@Highway-61>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 06:42:23PM -0500, John J. Foster wrote:
> Good evening,
> 
> Could someone please point me to the correct resources regarding proper
> setup of the various sound devices (/dev/cdrom, /dev/mixer, etc...) and
> multiple X servers/sessions? I realize this is not the proper group, but
> I have been searching google, the XFree86 website, ALSA website,
> newsgroups, etc... and anywhere else I can think of on and off for a few
> months now. I'm currently running FedoraCore on an ASUS A7N8X Deluxe
> motherboard, but I don't really think the particular hardware or version
> of Linux is the problem. I hope it's just a missed configuration issue.
> Each of these devices seems to only be available to the first X session
> to logon.
> I've bypassed this restriction for CD Audio by creating device files for
> all 4 users of this machines, and then configuring their preferred
> cd-player app to poing at their device file. It works fine. Any
> logged-in user can now play cd's.
> 
> brw-------    1 bird     disk      11,   0 Dec 31 18:20 /dev/cd-bird
> brw-------    1 festus   disk      11,   0 Dec 31 18:15 /dev/cd-festus
> brw-------    1 kayde    disk      11,   0 Jan  8 21:09 /dev/cd-kayde
> brw-------    1 monet    disk      11,   0 Dec 31 18:19 /dev/cd-monet
> 
Seems you make several device nodes for the _same_ device, with different
owners.  This is not the normal way to do i, are you going to
create a new set of nodes whenever there's a new user?

The usual way is to have only one node per device, and set permissions
so that all users can use the device.  Let the cdrom device be owned
by some group (cdromusers). Lett all your users belong to that group,
and give the group rw permissions.  Similar for other shared devices.

> My problem now is /dev/mixer, I think. Only the first logged-in user
> gets any system sounds.
> 
Seems you have a lousy soundcard (or sound driver) that isn't shareable.
Several solutions:
1. Replace with a shareable card.  I know the trident 4dwave cards are,
   there are probably others.  This is also useful when a single
   user want to run two sound programs simultaneously, such as
   both "system sounds" and a game and a background mp3/cd at the same time.
2. Use several cards, the best solution if your simultaneous users sit at 
   different locations.  Each may then have his/her own set of speakers.
3. Use software mixing, there are sound daemons available for this purpose.


> Before I go further, am I missing something obvious?
Take a look at how groups & permissions works.  Then think about
what kind of soundcard you want.

Helge Hafting


