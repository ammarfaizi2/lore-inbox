Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWGCTis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWGCTis (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 15:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGCTis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 15:38:48 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:30612 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751252AbWGCTiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 15:38:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Greg KH <greg@kroah.com>
Subject: Re: Battery-related regression between 2.6.17-git3 and 2.6.17-git6
Date: Mon, 3 Jul 2006 21:39:22 +0200
User-Agent: KMail/1.9.3
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
References: <200607020021.15040.rjw@sisk.pl> <200607031316.46034.rjw@sisk.pl> <20060703180053.GA16787@kroah.com>
In-Reply-To: <20060703180053.GA16787@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607032139.22488.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 July 2006 20:00, Greg KH wrote:
> On Mon, Jul 03, 2006 at 01:16:45PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > On Sunday 02 July 2006 11:15, Rafael J. Wysocki wrote:
> > > On Sunday 02 July 2006 00:21, Rafael J. Wysocki wrote:
> > > > With the recent -git on my box (Asus L5D, x86_64 SUSE 10) the powersave
> > > > demon is apparently unable to get the battery status, although the data in
> > > > /proc/acpi/battery/BAT0 seem to be correct.  As a result, battery status
> > > > notification via kpowersave doesn't work and it's hard to notice when the
> > > > battery is low/critical.
> > > > 
> > > > So far I have verified that this feature works fine with 2.6.17-git3 and
> > > > doesn't work with 2.6.17-git6 (-git5 doesn't compile here).
> > > > 
> > > > I'll try to get more information tomorrow (unless someone in the know has
> > > > an idea of what's up ;-) ).
> > > 
> > > I've verified that the problem first appeared in 2.6.17-git4.
> > 
> > Apparently this happens because powersaved takes the battery status
> > information from hald and the following kernel changes make hald crash on
> > my system:
> > 
> > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=43104f1da88f5335e9a45695df92a735ad550dda
> > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=bd00949647ddcea47ce4ea8bb2cfcfc98ebf9f2a
> > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c182274ffe1277f4e7c564719a696a37cacf74ea
> > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=9bde7497e0b54178c317fac47a18be7f948dd471
> > http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=36679ea59846d8f34a48f71ca1a37671ca0ad3c5
> > 
> > (ie. after reverting them hald works again).
> 
> Ick, that should not cause any problems, as sysfs should look identical
> to how it was before those patches.  Except that the /sys/class/usb/
> stuff is now symlinks instead of real directories, but HAL has had to
> handle that for a long time now (and it's even documented in
> Documentation/ABI/testing/sysfs-class)

Well, apparently one of them happens to trigger a buffer overflow in "my"
version of hal. ;-)

> Can you tell me exactly which of the above patches breaks HAL?

That would be quite a bit of testing and now I'm sure it's a hal issue.

> Which version of HAL are you using?  I have 0.5.7 here and it works just
> fine.

0.5.4 :-(

> And why would they even matter?  The battery is not a USB device...

No, it's not, but if hald is not running, powersaved cannot get the battery
status from it.  Well ...

Thanks,
Rafael
