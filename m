Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbUJ0Cc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbUJ0Cc1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 22:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUJ0CcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 22:32:01 -0400
Received: from fmr06.intel.com ([134.134.136.7]:35488 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S261584AbUJ0Can convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 22:30:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] [RFC] dev_acpi: support for userspace access to acpi
Date: Wed, 27 Oct 2004 10:30:29 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F84041ABFEF@pdsmsx403>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] [RFC] dev_acpi: support for userspace access to acpi
Thread-Index: AcS7nlEahj+KXwZWTuauKN+WpkGVFgALOp0Q
From: "Yu, Luming" <luming.yu@intel.com>
To: "Alex Williamson" <alex.williamson@hp.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "acpi-devel" <acpi-devel@lists.sourceforge.net>
X-OriginalArrivalTime: 27 Oct 2004 02:30:30.0764 (UTC) FILETIME=[EDA03AC0:01C4BBCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If you want to have a full access to acpi subsystem from userspace, why not firstly move ACPI interpreter out of kernel?
Then, you can play with the whole ACPI subsystem with minimal cost of troubling kernel  in userspace.  Say, you can forget " 
ioctl, read issues on files, complex data for sysfs, file per operation, etc...".  Is it a more clean way ?
 
Thanks
Luming 

>-----Original Message-----
>From: acpi-devel-admin@lists.sourceforge.net 
>[mailto:acpi-devel-admin@lists.sourceforge.net] On Behalf Of 
>Alex Williamson
>Sent: 2004Äê10ÔÂ27ÈÕ 4:55
>To: linux-kernel
>Cc: acpi-devel
>Subject: [ACPI] [RFC] dev_acpi: support for userspace access to acpi
>
>
>   Announcing the next revision of dev_acpi.  The dev_acpi module
>provides userspace access to ACPI namespace using a simple character
>device file.  For further discussion of the interface, see the README
>file in the tarball.  The current release is available here:
>
>http://free.linux.hp.com/~awilliam/acpi/dev_acpi/dev_acpi-20041
>026.tar.bz2
>
>(it's a little big to post here raw, but if requested I'd be happy to
>post the driver by itself)
>
>   I've been tossing around sysfs and device file interfaces 
>to the ACPI
>namespace for a while now.  The idea is that there's way too much
>information in namespace to not provide a userspace interface to it.
>Examples include projects springing up to support ACPI features on
>various laptops, increasing dependence on developing code using ACPI,
>extracting system/platform information from ACPI namespace.  In short,
>there are a lot of really simple things that userspace could use ACPI
>namespace for, but there's currently no way to get to it.
>
>   Previous iterations using sysfs looked pretty, but never really
>achieved the full potential of the interface (no ioctl, read issues on
>files, complex data for sysfs, file per operation, etc...).  The device
>file interface provides a more comprehensive yet compact interface,
>along with a 32bit compatibility layer, and sane read semantics on the
>file.
>
>   This revision cleans up quite a bit of code, adds some documentation
>in the README file, adds a number of interfaces, and adds several more
>example program, with the intent of sparking more interest.  I've
>updated the acpitree program to list a bit more data, but it's 
>basically
>the same.  For anyone trying to wrap their head around ACPI namespace,
>it's a great tool for getting a simple visual representation 
>of the data
>available.  I added a tool called acpivideo that will hopefully be
>interesting to laptop users.  It's able to set the active video output
>device, much like the hotkey on most laptops (but from command line).
>It also has a daemon mode that sets up a notify handler (yes, from
>userspace) and listens for events on the VGA device.  When an event is
>received, it evaluates the requested state change and pokes ACPI to do
>it.  See the README for more info.  If anyone knows how to 
>poke X to not
>block the switch it'd be interesting to add the hooks (currently only
>seems to work from a vt).
>
>   I added another simple program called acpiundock.  If you have a
>laptop docking station with an electo-mechanical eject (like the
>omnibook 500), this one should be fun.  There are no option, 
>just run it
>and see what happens (please be prepared for it to work... it just
>might).
>
>   Another fun developer tool/hack is eventwatch.  This program is
>simply a version of acpitree that tries to install notify handlers on
>every device in namespace.  It then sits and waits for something to
>happen.  If you've wondered if that hotkey on your box does something,
>try this, it just might.
>
>   I skimmed though the ibm-acpi module and tried to provide enough
>interfaces in this version of dev_acpi that the entire ibm-acpi could
>potentially be done in userspace.  I don't have an IBM laptop to
>experiment with, but I'd be interested to hear if someone tries.
>
>   Anyway, please give this interface a shot.  It builds as a 
>standalone
>module and should work on any 2.6 kernel with headers available.  I've
>tested this version quite a bit more than the version I posted a couple
>weeks ago, especially the 32bit app on 64bit kernel code (ia64 and
>x86_64).  Bug reports, feedback, opinions gladly welcomed.  Thanks,
>
>	Alex
>
>-- 
>Alex Williamson                             HP Linux & Open Source Lab
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by:
>Sybase ASE Linux Express Edition - download now for FREE
>LinuxWorld Reader's Choice Award Winner for best database on Linux.
>http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/acpi-devel
>
