Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUCDBTd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:19:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUCDBTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:19:33 -0500
Received: from mail.kroah.org ([65.200.24.183]:50090 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261364AbUCDBTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:19:30 -0500
Date: Wed, 3 Mar 2004 17:19:20 -0800
From: Greg KH <greg@kroah.com>
To: Michael Weiser <michael@weiser.dinsnail.net>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040304011919.GA2207@kroah.com>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <20040303151500.GD25687@kroah.com> <20040303235629.GA80132@weiser.dinsnail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303235629.GA80132@weiser.dinsnail.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2004 at 12:56:29AM +0100, Michael Weiser wrote:
> On Wed, Mar 03, 2004 at 07:15:00AM -0800, Greg KH wrote:
> > > > Major changes from the 019 version:
> > > > 	- new variable $local for the udev.permission file allows
> > > > 	  permissions to be set for the currently logged in user.
> > > Yay, just the other day I thought that might be a nice feature in
> > > concert with RedHat's/Fedora's pam_console module. Am I right in
> > > assuming that the current utmp based code will give the file to the user
> > > that most recently logged into the local console? This could cause some
> > > confusion with the pam_console-method which gives files to the user that
> > > logged in *first* on a local console.
> > I don't know, care to test it out?
> Aye. It's even worse. The user logged into the lowest-numbered console
> will get owner of the newly created file when using $local.
> 
> So if I log into tty2 and plug in my USB stick I will be owner of
> /dev/sda1. If another guy comes along, logs into tty1, unplugs my USB
> stick and replugs it, he'll be owner of /dev/sda1. But if I log out now,
> re-login on tty2 and replug the stick again, I won't get the owner of
> /dev/sda1 but the other guy again. This will certainly break things - at
> least on Fedora Core 1. Maybe it's different with other
> distributions/glibc/utmp variants/versions.

Ick, well you are describing a pretty pathalogical situation.  I suspect
for 99.9% of the users who would use this option, it will work just
fine, as they only have 1 user on the system at a time.

So, if you have multiple users on the physical system, then don't use
$local :)

Feel free to send a update to the documentation that illustrates this
limitation of the feature.

thanks,

greg k-h
