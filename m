Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbUCDBDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 20:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbUCDBDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 20:03:39 -0500
Received: from dinsnail.net ([217.160.166.159]:40094 "EHLO heinz.dinsnail.net")
	by vger.kernel.org with ESMTP id S261380AbUCDBDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 20:03:37 -0500
Date: Thu, 4 Mar 2004 00:56:29 +0100
From: Michael Weiser <michael@weiser.dinsnail.net>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 021 release
Message-ID: <20040303235629.GA80132@weiser.dinsnail.net>
References: <20040303000957.GA11755@kroah.com> <20040303095615.GA89995@weiser.dinsnail.net> <20040303151500.GD25687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303151500.GD25687@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 07:15:00AM -0800, Greg KH wrote:
> > > Major changes from the 019 version:
> > > 	- new variable $local for the udev.permission file allows
> > > 	  permissions to be set for the currently logged in user.
> > Yay, just the other day I thought that might be a nice feature in
> > concert with RedHat's/Fedora's pam_console module. Am I right in
> > assuming that the current utmp based code will give the file to the user
> > that most recently logged into the local console? This could cause some
> > confusion with the pam_console-method which gives files to the user that
> > logged in *first* on a local console.
> I don't know, care to test it out?
Aye. It's even worse. The user logged into the lowest-numbered console
will get owner of the newly created file when using $local.

So if I log into tty2 and plug in my USB stick I will be owner of
/dev/sda1. If another guy comes along, logs into tty1, unplugs my USB
stick and replugs it, he'll be owner of /dev/sda1. But if I log out now,
re-login on tty2 and replug the stick again, I won't get the owner of
/dev/sda1 but the other guy again. This will certainly break things - at
least on Fedora Core 1. Maybe it's different with other
distributions/glibc/utmp variants/versions.

Would it be an option to check for /var/run/console.lock and use the
username stored there by pam_console if present?
-- 
Micha
