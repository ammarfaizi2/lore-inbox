Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUIOUvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUIOUvv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUIOUuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:50:14 -0400
Received: from fep19-0.kolumbus.fi ([193.229.0.45]:6845 "EHLO
	fep19-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S267429AbUIOUt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:49:27 -0400
Date: Wed, 15 Sep 2004 23:49:21 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Peter Jones <pjones@redhat.com>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow root to modify raw scsi command permissions list
In-Reply-To: <1095277740.20046.23.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0409152306160.1972@kai.makisara.local>
References: <1095173470.5728.3.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0409152151190.1972@kai.makisara.local>
 <1095277740.20046.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Sep 2004, Peter Jones wrote:

> On Wed, 2004-09-15 at 22:14 +0300, Kai Makisara wrote:
...
> My patch leaves the defaults as what are currently in the kernel.  
> 
Yes but what I wanted to say the filter currently in the kernel is not 
safe for all devices.

> > I have already commented on MODE SELECT. I still think it is dangerous. 
> 
> It's only marked as being allowed if you have write access; /dev/hda
> usually isn't a+w, last I checked.
> 
I am thinking about other devices than disks. Tapes are what I know best 
but there are also other device types (all that support SG_IO).

For tapes it is fairly common to allow users read/write permissions for 
reading/writing tapes. MODE SELECT allows a user to mess up the drive 
parameters so that the next user thinks it is broken. This is not the 
purpose of giving read/write permissions in this case.

> I'd actually say that this isn't suitable for CD drives.  To do CDDA
> reads in many cases you need MODE_SELECT.  As such, CD drives should
> have MODE_SELECT in the list of things allowed to read.  But the point
> is that this gives control of the policy to the userland, where it
> belongs.
> 
This is why I like your approach.

...
> My intent with the patch isn't really to take any stance on which
> commands should and shouldn't be allowed.  In fact, it's quite the
> opposite -- this allows initscripts/hotplug to install an appropriate
> list of commands for each device.
> 
If you are not taking a stance, then the default list should be empty.
The starting point must be safe and it can be relaxed. I am just trying to 
have a safe enough starting point.

In an ideal world the initscripts/hotplug scripts would be updated 
instantaneously and the empty default would not be a problem. In the real 
world this does not happen and we have decide how far we want to relax the 
default security. I think this is why Linus added the filter: he wanted 
to allow users to burn CDs without special permissions. This is why I 
suggested that the default filter should allow the current default for 
CDs. It is a compromise.

...
> > This could also be done in your approach. One possibility would be to 
> > start with empty filter and call from CD/DVD registering a function that 
> > sets the filter you currently have as default. This would be both flexible 
> > and safe.
> 
> I don't want to do an empty filter, because that'll mean existing users
> of SG_IO and such break for no real reason.  The approach my patch takes
> is not to change *any* of the existing policy, but to enable distros to
> change it to their hearts' content.  It's *dead* simple to make
> initscripts and hotplug pick "correct" lists for each device.
> 
I don't know any other SG_IO users than CD/DVD software that try to use 
passthrough without CAP_RAWIO. This is probably politically incorrect, but 
no sane software developer expects to be able to send raw commands without 
proper permissions. If this kind of security hole is present, it will be 
plugged sooner or later.

-- 
Kai
