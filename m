Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261464AbUJZUzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbUJZUzy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261457AbUJZUzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 16:55:53 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:16105 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S261466AbUJZUya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 16:54:30 -0400
Subject: [RFC] dev_acpi: support for userspace access to acpi
From: Alex Williamson <alex.williamson@hp.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>
In-Reply-To: <1097879998.5971.69.camel@tdi>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz> <1095785315.6307.6.camel@tdi>
	 <20040921172625.GA30425@elf.ucw.cz> <20040921190606.GE18938@wotan.suse.de>
	 <1095794035.24751.54.camel@tdi> <20040921191826.GF18938@wotan.suse.de>
	 <1095795954.24751.74.camel@tdi> <20040921195802.GF30425@elf.ucw.cz>
	 <1095799248.24751.103.camel@tdi>  <20040921210218.GJ30425@elf.ucw.cz>
	 <1097879998.5971.69.camel@tdi>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 26 Oct 2004 14:55:00 -0600
Message-Id: <1098824100.6861.46.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   Announcing the next revision of dev_acpi.  The dev_acpi module
provides userspace access to ACPI namespace using a simple character
device file.  For further discussion of the interface, see the README
file in the tarball.  The current release is available here:

http://free.linux.hp.com/~awilliam/acpi/dev_acpi/dev_acpi-20041026.tar.bz2

(it's a little big to post here raw, but if requested I'd be happy to
post the driver by itself)

   I've been tossing around sysfs and device file interfaces to the ACPI
namespace for a while now.  The idea is that there's way too much
information in namespace to not provide a userspace interface to it.
Examples include projects springing up to support ACPI features on
various laptops, increasing dependence on developing code using ACPI,
extracting system/platform information from ACPI namespace.  In short,
there are a lot of really simple things that userspace could use ACPI
namespace for, but there's currently no way to get to it.

   Previous iterations using sysfs looked pretty, but never really
achieved the full potential of the interface (no ioctl, read issues on
files, complex data for sysfs, file per operation, etc...).  The device
file interface provides a more comprehensive yet compact interface,
along with a 32bit compatibility layer, and sane read semantics on the
file.

   This revision cleans up quite a bit of code, adds some documentation
in the README file, adds a number of interfaces, and adds several more
example program, with the intent of sparking more interest.  I've
updated the acpitree program to list a bit more data, but it's basically
the same.  For anyone trying to wrap their head around ACPI namespace,
it's a great tool for getting a simple visual representation of the data
available.  I added a tool called acpivideo that will hopefully be
interesting to laptop users.  It's able to set the active video output
device, much like the hotkey on most laptops (but from command line).
It also has a daemon mode that sets up a notify handler (yes, from
userspace) and listens for events on the VGA device.  When an event is
received, it evaluates the requested state change and pokes ACPI to do
it.  See the README for more info.  If anyone knows how to poke X to not
block the switch it'd be interesting to add the hooks (currently only
seems to work from a vt).

   I added another simple program called acpiundock.  If you have a
laptop docking station with an electo-mechanical eject (like the
omnibook 500), this one should be fun.  There are no option, just run it
and see what happens (please be prepared for it to work... it just
might).

   Another fun developer tool/hack is eventwatch.  This program is
simply a version of acpitree that tries to install notify handlers on
every device in namespace.  It then sits and waits for something to
happen.  If you've wondered if that hotkey on your box does something,
try this, it just might.

   I skimmed though the ibm-acpi module and tried to provide enough
interfaces in this version of dev_acpi that the entire ibm-acpi could
potentially be done in userspace.  I don't have an IBM laptop to
experiment with, but I'd be interested to hear if someone tries.

   Anyway, please give this interface a shot.  It builds as a standalone
module and should work on any 2.6 kernel with headers available.  I've
tested this version quite a bit more than the version I posted a couple
weeks ago, especially the 32bit app on 64bit kernel code (ia64 and
x86_64).  Bug reports, feedback, opinions gladly welcomed.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

