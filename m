Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269624AbUIRT6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269624AbUIRT6V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 15:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269626AbUIRT6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 15:58:21 -0400
Received: from web11906.mail.yahoo.com ([216.136.172.190]:3090 "HELO
	web11906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269624AbUIRT6I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 15:58:08 -0400
Message-ID: <20040918195807.18874.qmail@web11906.mail.yahoo.com>
Date: Sat, 18 Sep 2004 12:58:07 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
To: Jon Smirl <jonsmirl@gmail.com>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e47339104091811431fb44254@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Jon Smirl <jonsmirl@gmail.com> wrote:

> Original proposal.....
> At OLS we talked about a system like this for setting video modes:
> 
> 1) user owns graphics devices
> 2) user sets mode with string (or similar) format using ioctl common to
> all drivers.
> 3) driver is locked to prevent multiple mode sets
> 4) common code takes this string and does a hotplug event with it.
> 5) hotplug event runs root context in user space 
> 6) mode is decoded and verified, this may involve a little process that
> maintains the DDC database and reads a file of legal modes. Other
> schemes are possible.
> 7a) mode is set using VBIOS and vm86, signal driver mode is set
> 7b) the register values needed to set the mode are passed into a root
> priv ioctl.
> 8) driver is unlocked.
> 
> In this model all of the verification happens in user space. If you
> want to set modes other than the ones from DDC you have to add them to
> the config file. There is no need for DDC support and mode verification
> in the kernel.
> 
> To give credit this is Alan Cox's design.
> 
>
---------------------------------------------------------------------------------
> 
> I'm now starting to implement this design. Would it be better to set
> the mode via sysfs attributes? This would allow mode settting with
> something like: "echo 'my mode string' /sys/class/drm/card0/mode" A
> list of available modes could be in /sys/class/drm/card0/modes
> 
This is intersting...
I'd like to know how you plan to use VCs?  That is more then one tty
sharing the same monitor.  I'd also like to see VCs able to change modes
while not being active, thought I can't imagin how one would plan todo
this  /wo blocking.  I don't see any good reason why it can't be an ioctl,
you can have the same exe/bin/app handle BOTH the user and root parts of
the mode change.  This way it can keep a cache of things, like modes that
will currently not be valid.

> Can PAM change the ownership of a sysfs attribute/directory on login?
> For this to work logging in needs to assign you ownership of the
> attribute since you want to be able to change it but not anyone else.
> DRM may need to assign the ownership of multiple attributes, is this
> easy to do?
> 
> How are errors going to be communicated in this scheme? I can cat the
> sysfs mode variable to get a status. Is there a good way to do this
> without polling?
> 
> If the sysfs scheme doesn't work mode setting will need to be an IOCTL
> with a small program since PAM can change the ownership of the DRM
> device. The sysfs scheme has the major advantage of avoiding the need
> for the small program.
> 
There is another thing I can't see.  Why can't the module for the drm
create fb[0-9]* devices, one for each monitor?  This would seam to solve
the problem with having another app and ioctl(API).

> If we go the sysfs route what is BSD going to do, will we have to
> build parallel implementations?
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 



		
_______________________________
Do you Yahoo!?
Declare Yourself - Register online to vote today!
http://vote.yahoo.com
