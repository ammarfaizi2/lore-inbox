Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261643AbUJ0Da0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261643AbUJ0Da0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUJ0D2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:28:43 -0400
Received: from mailhub.hp.com ([192.151.27.10]:7583 "EHLO mailhub.hp.com")
	by vger.kernel.org with ESMTP id S261631AbUJ0D1H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:27:07 -0400
Subject: RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi
From: Alex Williamson <alex.williamson@hp.com>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041ABFEF@pdsmsx403>
References: <3ACA40606221794F80A5670F0AF15F84041ABFEF@pdsmsx403>
Content-Type: text/plain; charset=Shift-JIS
Organization: LOSL
Date: Tue, 26 Oct 2004 21:27:24 -0600
Message-Id: <1098847644.9215.16.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   The kernel certainly needs an ACPI interpreter and it needs it before
userspace is launched.  Handing off the interpreter to userspace or
managing two interpreters poking ACPI at the same time seems like a much
more complicated problem.  The kernel is the primary consumer, I think
it would just shift the problem elsewhere to consider moving it.

  The problems quoted below were from the previous sysfs interface I was
developing.  I think these problems are fixed with this current device
file interface.  I'm hoping dev_acpi is already more clean.  Thanks,

	Alex

On Wed, 2004-10-27 at 10:30 +0800, Yu, Luming wrote:
> If you want to have a full access to acpi subsystem from userspace,
> why not firstly move ACPI interpreter out of kernel?
> Then, you can play with the whole ACPI subsystem with minimal cost of
> troubling kernel  in userspace.  Say, you can forget " 
> ioctl, read issues on files, complex data for sysfs, file per
> operation, etc...".  Is it a more clean way ?
>  
> Thanks
> Luming 
> 
> >-----Original Message-----
> >From: acpi-devel-admin@lists.sourceforge.net 
> >[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of 
> >Alex Williamson
> >Sent: 2004”N10ŒŽ27“ú 4:55
> >To: linux-kernel
> >Cc: acpi-devel
> >Subject: [ACPI] [RFC] dev_acpi: support for userspace access to acpi
> >
> >
> >   Announcing the next revision of dev_acpi.  The dev_acpi module
> >provides userspace access to ACPI namespace using a simple character
> >device file.  For further discussion of the interface, see the README
> >file in the tarball.  The current release is available here:
> >
> >http://free.linux.hp.com/~awilliam/acpi/dev_acpi/dev_acpi-20041
> >026.tar.bz2
> >
> >(it's a little big to post here raw, but if requested I'd be happy to
> >post the driver by itself)
> >
> >   I've been tossing around sysfs and device file interfaces 
> >to the ACPI
> >namespace for a while now.  The idea is that there's way too much
> >information in namespace to not provide a userspace interface to it.
> >Examples include projects springing up to support ACPI features on
> >various laptops, increasing dependence on developing code using ACPI,
> >extracting system/platform information from ACPI namespace.  In short,
> >there are a lot of really simple things that userspace could use ACPI
> >namespace for, but there's currently no way to get to it.
> >
> >   Previous iterations using sysfs looked pretty, but never really
> >achieved the full potential of the interface (no ioctl, read issues on
> >files, complex data for sysfs, file per operation, etc...).  The device
> >file interface provides a more comprehensive yet compact interface,
> >along with a 32bit compatibility layer, and sane read semantics on the
> >file.
> >
> >   This revision cleans up quite a bit of code, adds some documentation
> >in the README file, adds a number of interfaces, and adds several more
> >example program, with the intent of sparking more interest.  I've
> >updated the acpitree program to list a bit more data, but it's 
> >basically
> >the same.  For anyone trying to wrap their head around ACPI namespace,
> >it's a great tool for getting a simple visual representation 
> >of the data
> >available.  I added a tool called acpivideo that will hopefully be
> >interesting to laptop users.  It's able to set the active video output
> >device, much like the hotkey on most laptops (but from command line).
> >It also has a daemon mode that sets up a notify handler (yes, from
> >userspace) and listens for events on the VGA device.  When an event is
> >received, it evaluates the requested state change and pokes ACPI to do
> >it.  See the README for more info.  If anyone knows how to 
> >poke X to not
> >block the switch it'd be interesting to add the hooks (currently only
> >seems to work from a vt).
> >
> >   I added another simple program called acpiundock.  If you have a
> >laptop docking station with an electo-mechanical eject (like the
> >omnibook 500), this one should be fun.  There are no option, 
> >just run it
> >and see what happens (please be prepared for it to work... it just
> >might).
> >
> >   Another fun developer tool/hack is eventwatch.  This program is
> >simply a version of acpitree that tries to install notify handlers on
> >every device in namespace.  It then sits and waits for something to
> >happen.  If you've wondered if that hotkey on your box does something,
> >try this, it just might.
> >
> >   I skimmed though the ibm-acpi module and tried to provide enough
> >interfaces in this version of dev_acpi that the entire ibm-acpi could
> >potentially be done in userspace.  I don't have an IBM laptop to
> >experiment with, but I'd be interested to hear if someone tries.
> >
> >   Anyway, please give this interface a shot.  It builds as a 
> >standalone
> >module and should work on any 2.6 kernel with headers available.  I've
> >tested this version quite a bit more than the version I posted a couple
> >weeks ago, especially the 32bit app on 64bit kernel code (ia64 and
> >x86_64).  Bug reports, feedback, opinions gladly welcomed.  Thanks,
> >
> >	Alex
> >
> >-- 
> >Alex Williamson                             HP Linux & Open Source Lab
> >
> >
> >
> >-------------------------------------------------------
> >This SF.Net email is sponsored by:
> >Sybase ASE Linux Express Edition - download now for FREE
> >LinuxWorld Reader's Choice Award Winner for best database on Linux.
> >http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> >_______________________________________________
> >Acpi-devel mailing list
> >Acpi-devel@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
> 
-- 
Alex Williamson                             HP Linux & Open Source Lab

