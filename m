Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWGCFa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWGCFa3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 01:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGCFa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 01:30:26 -0400
Received: from koto.vergenet.net ([210.128.90.7]:6831 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751041AbWGCFaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 01:30:25 -0400
Date: Mon, 3 Jul 2006 11:59:17 +0900
From: Horms <horms@verge.net.au>
To: linux-kernel@vger.kernel.org
Cc: Adrian Bunk <trivial@kernel.org>, Magnus Damm <damm@opensource.se>
Subject: [PATCH] nfs: Update Documentation/nfsroot.txt to include dhcp, syslinux and isolinux
Message-ID: <20060703025915.GA31075@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Document the ip command a little differently to make the
  interaction between defaults and autoconfiguration a little clearer
  (I hope)

* Update autoconfiguration the current set of options, including DHCP

* Update the boot methods to add syslinux and isolinux, and remove
  dd of=/dev/fd0 which is no longer supported by linux

* Add a referance to initramfs along side initrd.
  Should the latter and its document be removed some time soon?

* Various cleanups to put the text consistently into the thrid person

* Reformated a bit to fit into 80 columns a bit more nicely

* Should the bootloaders documentation be removed or split
  into a separate documentation, it seems somewhat out of scope

Signed-Off-By: Horms <horms@verge.net.au>

 Documentation/nfsroot.txt |  275 ++++++++++++++++++++++++++-------------------
 1 file changed, 160 insertions(+), 115 deletions(-)

diff --git a/Documentation/nfsroot.txt b/Documentation/nfsroot.txt
index d56dc71..82177ec 100644
--- a/Documentation/nfsroot.txt
+++ b/Documentation/nfsroot.txt
@@ -4,15 +4,16 @@ Mounting the root filesystem via NFS (nf
 Written 1996 by Gero Kuhlmann <gero@gkminix.han.de>
 Updated 1997 by Martin Mares <mj@atrey.karlin.mff.cuni.cz>
 Updated 2006 by Nico Schottelius <nico-kernel-nfsroot@schottelius.org>
+Updated 2006 by Horms <horms@verge.net.au>
 
 
 
-If you want to use a diskless system, as an X-terminal or printer
-server for example, you have to put your root filesystem onto a
-non-disk device. This can either be a ramdisk (see initrd.txt in
-this directory for further information) or a filesystem mounted
-via NFS. The following text describes on how to use NFS for the
-root filesystem. For the rest of this text 'client' means the
+In order to use a diskless system, such as an X-terminal or printer server
+for example, it is necessary for the root filesystem to be present on a
+non-disk device. This may be an initramfs (see Documentation/filesystems/
+ramfs-rootfs-initramfs.txt), a ramdisk (see Documenation/initrd.txt) or a
+filesystem mounted via NFS. The following text describes on how to use NFS
+for the root filesystem. For the rest of this text 'client' means the
 diskless system, and 'server' means the NFS server.
 
 
@@ -21,11 +22,13 @@ diskless system, and 'server' means the 
 1.) Enabling nfsroot capabilities
     -----------------------------
 
-In order to use nfsroot you have to select support for NFS during
-kernel configuration. Note that NFS cannot be loaded as a module
-in this case. The configuration script will then ask you whether
-you want to use nfsroot, and if yes what kind of auto configuration
-system you want to use. Selecting both BOOTP and RARP is safe.
+In order to use nfsroot, NFS client support needs to be selected as
+built-in during configuration. Once this has been selected, the nfsroot
+option will become available, which should also be selected.
+
+In the networking options, kernel level autoconfiguration can be selected,
+along with the types of autoconfiguration to support. Selecting all of
+DHCP, BOOTP and RARP is safe.
 
 
 
@@ -33,11 +36,10 @@ system you want to use. Selecting both B
 2.) Kernel command line
     -------------------
 
-When the kernel has been loaded by a boot loader (either by loadlin,
-LILO or a network boot program) it has to be told what root fs device
-to use, and where to find the server and the name of the directory
-on the server to mount as root. This can be established by a couple
-of kernel command line parameters:
+When the kernel has been loaded by a boot loader (see below) it needs to be
+told what root fs device to use. And in the case of nfsroot, where to find
+both the server and the name of the directory on the server to mount as root.
+This can be established using the following kernel command line parameters:
 
 
 root=/dev/nfs
@@ -49,23 +51,21 @@ root=/dev/nfs
 
 nfsroot=[<server-ip>:]<root-dir>[,<nfs-options>]
 
-  If the `nfsroot' parameter is NOT given on the command line, the default
-  "/tftpboot/%s" will be used.
+  If the `nfsroot' parameter is NOT given on the command line,
+  the default "/tftpboot/%s" will be used.
 
-  <server-ip>	Specifies the IP address of the NFS server. If this field
-		is not given, the default address as determined by the
-		`ip' variable (see below) is used. One use of this
-		parameter is for example to allow using different servers
-		for RARP and NFS. Usually you can leave this blank.
+  <server-ip>	Specifies the IP address of the NFS server. 
+		The default address is determined by the `ip' parameter
+		(see below). This parameter allows the use of different
+		servers for IP autoconfiguration and NFS.
 
-  <root-dir>	Name of the directory on the server to mount as root. If
-		there is a "%s" token in the string, the token will be
-		replaced by the ASCII-representation of the client's IP
-		address.
+  <root-dir>	Name of the directory on the server to mount as root.
+		If there is a "%s" token in the string, it will be
+		replaced by the ASCII-representation of the client's
+		IP address.
 
   <nfs-options>	Standard NFS options. All options are separated by commas.
-		If the options field is not given, the following defaults
-		will be used:
+		The following defaults are used:
 			port		= as given by server portmap daemon
 			rsize		= 1024
 			wsize		= 1024
@@ -81,129 +81,174 @@ nfsroot=[<server-ip>:]<root-dir>[,<nfs-o
 ip=<client-ip>:<server-ip>:<gw-ip>:<netmask>:<hostname>:<device>:<autoconf>
 
   This parameter tells the kernel how to configure IP addresses of devices
-  and also how to set up the IP routing table. It was originally called `nfsaddrs',
-  but now the boot-time IP configuration works independently of NFS, so it
-  was renamed to `ip' and the old name remained as an alias for compatibility
-  reasons.
+  and also how to set up the IP routing table. It was originally called
+  `nfsaddrs', but now the boot-time IP configuration works independently of
+  NFS, so it was renamed to `ip' and the old name remained as an alias for
+  compatibility reasons.
 
   If this parameter is missing from the kernel command line, all fields are
   assumed to be empty, and the defaults mentioned below apply. In general
-  this means that the kernel tries to configure everything using both
-  RARP and BOOTP (depending on what has been enabled during kernel confi-
-  guration, and if both what protocol answer got in first).
+  this means that the kernel tries to configure everything using
+  autoconfiguration.
 
-  <client-ip>	IP address of the client. If empty, the address will either
-		be determined by RARP or BOOTP. What protocol is used de-
-		pends on what has been enabled during kernel configuration
-		and on the <autoconf> parameter. If this parameter is not
-		empty, neither RARP nor BOOTP will be used.
+  The <autoconf> parameter can appear alone as the value to the `ip'
+  parameter (without all the ':' characters before) in which case auto-
+  configuration is used.
+
+  <client-ip>	IP address of the client. 
+  
+  		Default:  Determined using autoconfiguration.
 
   <server-ip>	IP address of the NFS server. If RARP is used to determine
 		the client address and this parameter is NOT empty only
-		replies from the specified server are accepted. To use
-		different RARP and NFS server, specify your RARP server
-		here (or leave it blank), and specify your NFS server in
-		the `nfsroot' parameter (see above). If this entry is blank
-		the address of the server is used which answered the RARP
-		or BOOTP request.
-
-  <gw-ip>	IP address of a gateway if the server is on a different
-		subnet. If this entry is empty no gateway is used and the
-		server is assumed to be on the local network, unless a
-		value has been received by BOOTP.
-
-  <netmask>	Netmask for local network interface. If this is empty,
+		replies from the specified server are accepted.
+
+		Only required for for NFS root. That is autoconfiguration
+		will not be triggered if it is missing and NFS root is not
+		in operation.
+
+		Default: Determined using autoconfiguration.
+		         The address of the autoconfiguration server is used.
+
+  <gw-ip>	IP address of a gateway if the server is on a different subnet.
+
+		Default: Determined using autoconfiguration.
+
+  <netmask>	Netmask for local network interface. If unspecified
 		the netmask is derived from the client IP address assuming
-		classful addressing, unless overridden in BOOTP reply.
+		classful addressing.
 
-  <hostname>	Name of the client. If empty, the client IP address is
-		used in ASCII notation, or the value received by BOOTP.
+		Default:  Determined using autoconfiguration.
 
-  <device>	Name of network device to use. If this is empty, all
-		devices are used for RARP and BOOTP requests, and the
-		first one we receive a reply on is configured. If you have
-		only one device, you can safely leave this blank.
+  <hostname>	Name of the client. May be supplied by autoconfiguration,
+  		but its absence will not trigger autoconfiguration.
 
-  <autoconf>	Method to use for autoconfiguration. If this is either
-		'rarp' or 'bootp', the specified protocol is used.
-		If the value is 'both' or empty, both protocols are used
-		so far as they have been enabled during kernel configura-
-		tion. 'off' means no autoconfiguration.
+  		Default: Client IP address is used in ASCII notation.
 
-  The <autoconf> parameter can appear alone as the value to the `ip'
-  parameter (without all the ':' characters before) in which case auto-
-  configuration is used.
+  <device>	Name of network device to use.
 
+		Default: If the host only has one device, it is used.
+			 Otherwise the device is determined using
+			 autoconfiguration. This is done by sending
+			 autoconfiguration requests out of all devices,
+			 and using the device that received the first reply.
 
+  <autoconf>	Method to use for autoconfiguration. In the case of options
+                which specify multiple autoconfiguration protocols,
+		requests are sent using all protocols, and the first one
+		to reply is used. 
 
+		Only autoconfiguration protocols that have been compiled
+		into the kernel will be used, regardless of the value of
+		this option.
 
-3.) Kernel loader
-    -------------
+                  off or none: don't use autoconfiguration (default)
+		  on or any:   use any protocol available in the kernel
+		  dhcp:        use DHCP
+		  bootp:       use BOOTP
+		  rarp:        use RARP
+		  both:        use both BOOTP and RARP but not DHCP 
+		               (old option kept for backwards compatibility)
 
-To get the kernel into memory different approaches can be used. They
-depend on what facilities are available:
+                Default: any
 
 
-3.1)  Writing the kernel onto a floppy using dd:
-	As always you can just write the kernel onto a floppy using dd,
-	but then it's not possible to use kernel command lines at all.
-	To substitute the 'root=' parameter, create a dummy device on any
-	linux system with major number 0 and minor number 255 using mknod:
 
-		mknod /dev/boot255 c 0 255
 
-	Then copy the kernel zImage file onto a floppy using dd:
+3.) Boot Loader
+    ----------
 
-		dd if=/usr/src/linux/arch/i386/boot/zImage of=/dev/fd0
+To get the kernel into memory different approaches can be used.
+They depend on various facilities being available:
 
-	And finally use rdev to set the root device:
 
-		rdev /dev/fd0 /dev/boot255
+3.1)  Booting from a floppy using syslinux
 
-	You can then remove the dummy device /dev/boot255 again. There
-	is no real device available for it.
-	The other two kernel command line parameters cannot be substi-
-	tuted with rdev. Therefore, using this method the kernel will
-	by default use RARP and/or BOOTP, and if it gets an answer via
-	RARP will mount the directory /tftpboot/<client-ip>/ as its
-	root. If it got a BOOTP answer the directory name in that answer
-	is used.
+	When building kernels, an easy way to create a boot floppy that uses
+	syslinux is to use the zdisk or bzdisk make targets which use
+      	and bzimage images respectively. Both targets accept the
+     	FDARGS parameter which can be used to set the kernel command line.
+
+	e.g. 
+	   make bzdisk FDARGS="root=/dev/nfs"
+
+   	Note that the user running this command will need to have
+     	access to the floppy drive device, /dev/fd0
+
+     	For more information on syslinux, including how to create bootdisks
+     	for prebuilt kernels, see http://syslinux.zytor.com/
+
+	N.B: Previously it was possible to write a kernel directly to
+	     a floppy using dd, configure the boot device using rdev, and
+	     boot using the resulting floppy. Linux no longer supports this
+	     method of booting.
+
+3.2) Booting from a cdrom using isolinux
+
+     	When building kernels, an easy way to create a bootable cdrom that
+     	uses isolinux is to use the isoimage target which uses a bzimage
+     	image. Like zdisk and bzdisk, this target accepts the FDARGS
+     	parameter which can be used to set the kernel command line.
+
+	e.g.
+	  make isoimage FDARGS="root=/dev/nfs"
+
+     	The resulting iso image will be arch/<ARCH>/boot/image.iso
+     	This can be written to a cdrom using a variety of tools including
+     	cdrecord.
+
+	e.g.
+	  cdrecord dev=ATAPI:1,0,0 arch/i386/boot/image.iso
+
+     	For more information on isolinux, including how to create bootdisks
+     	for prebuilt kernels, see http://syslinux.zytor.com/
 
 3.2) Using LILO
-	When using LILO you can specify all necessary command line
-	parameters with the 'append=' command in the LILO configuration
-	file. However, to use the 'root=' command you also need to
-	set up a dummy device as described in 3.1 above. For how to use
-	LILO and its 'append=' command please refer to the LILO
-	documentation.
+	When using LILO all the necessary command line parameters may be
+	specified using the 'append=' directive in the LILO configuration
+	file. 
+	
+	However, to use the 'root=' directive you also need to create 
+	a dummy root device, which may be removed after LILO is run.
+
+	mknod /dev/boot255 c 0 255
+	
+	For information on configuring LILO, please refer to its documentation.
 
 3.3) Using GRUB
-	When you use GRUB, you simply append the parameters after the kernel
-	specification: "kernel <kernel> <parameters>" (without the quotes).
+	When using GRUB, kernel parameter are simply appended after the kernel
+	specification: kernel <kernel> <parameters>
 
 3.4) Using loadlin
-	When you want to boot Linux from a DOS command prompt without
-	having a local hard disk to mount as root, you can use loadlin.
-	I was told that it works, but haven't used it myself yet. In
-	general you should be able to create a kernel command line simi-
-	lar to how LILO is doing it. Please refer to the loadlin docu-
-	mentation for further information.
+	loadlin may be used to boot Linux from a DOS command prompt without
+	requiring a local hard disk to mount as root. This has not been
+	thoroughly tested by the authors of this document, but in general
+	it should be possible configure the kernel command line similarly
+	to the configuration of LILO.
+	
+	Please refer to the loadlin documentation for further information.
 
 3.5) Using a boot ROM
-	This is probably the most elegant way of booting a diskless
-	client. With a boot ROM the kernel gets loaded using the TFTP
-	protocol. As far as I know, no commercial boot ROMs yet
-	support booting Linux over the network, but there are two
-	free implementations of a boot ROM available on sunsite.unc.edu
-	and its mirrors. They are called 'netboot-nfs' and 'etherboot'.
-	Both contain everything you need to boot a diskless Linux client.
+	This is probably the most elegant way of booting a diskless client.
+	With a boot ROM the kernel is loaded using the TFTP protocol. The
+	authors of this document are not aware of any no commercial boot
+	ROMs that support booting Linux over the network. However, there
+	are two free implementations of a boot ROM, netboot-nfs and
+	etherboot, both of which are available on sunsite.unc.edu, and both
+	of which contain everything you need to boot a diskless Linux client.
 
 3.6) Using pxelinux
-	Using pxelinux you specify the kernel you built with
+	Pxelinux may be used to boot linux using the PXE boot loader
+	which is present on many modern network cards.
+
+	When using pxelinux, the kernel image is specified using
 	"kernel <relative-path-below /tftpboot>". The nfsroot parameters
 	are passed to the kernel by adding them to the "append" line.
-	You may perhaps also want to fine tune the console output,
-	see Documentation/serial-console.txt for serial console help.
+	It is common to use serial console in conjunction with pxeliunx,
+	see Documentation/serial-console.txt for more information.
+
+	For more information on isolinux, including how to create bootdisks
+	for prebuilt kernels, see http://syslinux.zytor.com/
 
 
 
