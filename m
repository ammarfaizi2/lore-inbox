Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWBSSub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWBSSub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 13:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWBSSub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 13:50:31 -0500
Received: from iabervon.org ([66.92.72.58]:18704 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932204AbWBSSua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 13:50:30 -0500
Date: Sun, 19 Feb 2006 13:50:59 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: Christoph Hellwig <hch@infradead.org>, Bill Davidsen <davidsen@tmr.com>,
       Greg KH <greg@kroah.com>, Nix <nix@esperi.org.uk>,
       Jens Axboe <axboe@suse.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <200602181215.30277.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.64.0602191319480.6773@iabervon.org>
References: <878xt3rfjc.fsf@amaterasu.srvr.nix> <43F641A2.50200@tmr.com>
 <20060218120617.GA911@infradead.org> <200602181215.30277.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Feb 2006, Gene Heskett wrote:

> But I fail to see where this would help to 'find' the right device to 
> write to, other than the obvious prefixing of '/dev/' to $drive name.  
> We already knew that, and in fact it works very well. Please explain to 
> Joerg in one syllable words he might, if he wanted to, understand.

Honestly, the right thing for Joerg is /dev/cdrom or /dev/cdroms/*. The 
principle ought to be that something in userspace will talk to the kernel 
and produce a /dev structure containing names the user will recognize. 
(FWIW, /dev/cdrom has worked on every Linux machine I've had since my 
first system 10 years ago, but I've heard of people having multiple 
drives.)

Probably the right thing for getting the user to really know which thing 
is which is to have a configuration program that configures udev by 
listing all the devices that go through cdrom.c, giving some info about 
them, letting the user open the tray on them (to distinguish identical 
devices), and having the user give each a name, which then appears in 
/dev/cdroms (by reconfiguring udev). All of the detailed info from the 
kernel should go to the system configuration utility, not to cdrecord, 
which shouldn't need it, because either the default drive (/dev/cdrom) or 
the drive from /dev/cdroms that the user specifies will be right.

	-Daniel
*This .sig left intentionally blank*
