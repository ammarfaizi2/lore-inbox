Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbUDWToc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbUDWToc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 15:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDWToc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 15:44:32 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8158 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261187AbUDWTo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 15:44:27 -0400
Subject: Re: [PATCH] coredump - as root not only if euid switched
From: Albert Cahalan <albert@users.sf.net>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@mac.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton OSDL <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <1082747589.2710.100.camel@picklock.adams.family>
References: <1082734536.3450.682.camel@cube>
	 <1082747589.2710.100.camel@picklock.adams.family>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1082740942.3450.699.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 23 Apr 2004 13:22:23 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-23 at 15:14, Peter Wächtler wrote:
> Am Fr, 2004-04-23 um 17.35 schrieb Albert Cahalan:
> > > While it's more secure to not dump core at all if the
> > > program has switched euid, it's also very unpractical.
> > > Since only programs started from root, being setuid
> > > root or have CAP_SETUID it's far more practical to
> > > dump as root.root mode 600. This is the bahavior 
> > > of Solaris.
> > 
> > Solaris can keep their security holes.
> > 
> 
> I checked (older) versions on
> 
> HP-UX, True64, AiX, MacOsX
> 
> HP-UX didn't dump core on a seteuid 0->n prog
> Aix,MacOsX and True64 dumped core with ownership of user
> I could check Irix

It would be nice of you to do so, then issue some
sort of security alert.

> > Consider a setuid core dump on removable media which
> > is user-controlled.
> 
> boot into rescue system...

If you're suggesting that user-controlled media implies
the ability to boot via that media, you're very wrong.

a. LinuxBIOS
b. OpenFirmware (Mac or Sun) with boot password
c. no floppy, and a Zip drive on BIOS-disabled SCSI
d. parallel port Zip drive
e. FireWire w/o BIOS support

(the "rip computer open" option is either physically
blocked or there is a human nearby that would notice)

> > Also consider filesystems that don't store full security
> > data, like vfat and smb/cifs.
> > 
> > Core dumps to remote filesystems are a problem in
> > general, because the server might not implement the
> > type of security you expect it to implement.
> > 
> 
> mkdir /var/cores
> chmod a+rwx,o+t /var/cores
> echo /var/cores/%e.core.%p > /proc/sys/kernel/core_pattern

Sure, but you shouldn't assume that all admins know
to do this. The default must be secure.

> > Here's a better idea: add a sysctl for insecure core
> > dumps. When set, dump all cores as root.root mode 444.
> > Ignore directory permissions when doing so, so that
> > forcing dumps into a MacOS-style /cores directory does
> > not require that users be able to access it normally.
> > This lets appropriately authorized users debug setuid
> > apps and get support for them without adding security
> > holes like Solaris has.
> 
> It's tunable via coreadm
> 
> troll, troll

You said "This is the bahavior of Solaris." and I took
that for the truth. Now you say it's tunable. Well, OK
then, so Solaris _doesn't_ have an insecure config as
it comes from Sun? I have no problem with supporting an
insecure config, but you were suggesting that it would
be the new default (and only) behavior.




