Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291853AbSBTNyk>; Wed, 20 Feb 2002 08:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291854AbSBTNyb>; Wed, 20 Feb 2002 08:54:31 -0500
Received: from chabotc.xs4all.nl ([213.84.192.197]:50600 "EHLO
	chabotc.xs4all.nl") by vger.kernel.org with ESMTP
	id <S291853AbSBTNyQ>; Wed, 20 Feb 2002 08:54:16 -0500
Message-ID: <3C73AA6D.7050907@reviewboard.com>
Date: Wed, 20 Feb 2002 14:53:49 +0100
From: Chris Chabot <chabotc@reviewboard.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020219
X-Accept-Language: en,nl
MIME-Version: 1.0
To: Wakko Warner <wakko@animx.eu.org>
CC: nimeesh <nimeesh24@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: network booting
In-Reply-To: <20020220084310.95958.qmail@web12304.mail.yahoo.com> <3C73865F.5060909@reviewboard.com> <20020220063841.A9861@animx.eu.org>
Content-Type: multipart/mixed;
 boundary="------------040702060901010403070103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040702060901010403070103
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[..]

>I found out this method doesn't work on 3com adapters.  the tftpserver and
>pxelinux are the newest things on that machine (which is about 2 years old
>now)
>
>Where can I find the pxe thing you mentioned above?
>
See the README i cut&pasted below. It's the readme for intel's pxe-0.1 
for linux.. with all the relevant links in it.
ps, do note your BIOS has to be pc99 compliant to be able to do PXE booting.

If not, your alternatives are 1) a boot eprom with a kernel image or 
boot loader or 2) a floppy / cdrom with a boot loader and a kernel. This 
kernel can be configured for DHCP / nfsroot, so the actualy loading and 
anything afterwards will happen over the network.





--------------040702060901010403070103
Content-Type: text/plain;
 name="README"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="README"

Preboot Execution Environment (PXE) README


When the PXE daemons are installed and configured, you will be able to remote 
boot and install Linux.

This README provides specific instructions for configuring a remote boot
network install of Linux on your system.  However, you can modify the procedure
to build Linux boot images for a variety of purposes (e.g. Remote boot Linux as your native OS, Beowulf configurations, etc.)


PXE Background Information  
==========================

PXE defines an industry standard method of remote booting.

PXE remote boot client support is a required by PC98 and PC99 for all Office
PCs (<http://www.pcdesguide.com/pc99>) and by the Wired for Management
Initiative sponsored by Intel Corp. (<http://developer.intel.com/ial/wfm>)
As a result, most PC OEMs offer PXE support for LAN on motherboard platforms
and for business platforms containing a PXE enabled NIC.

In addition, to upgrade existing PC platforms, PXE compliant NICs are offered
by Intel (<http://www.intel.com/network/products/pro100mgmt.htm>) 
and 3Com (<http://www.3comnicfinder.com/Product.asp?ProductID=49>), and
possibly other NIC vendors.

Finally, many NICs with boot ROM sockets or flash chips can be upgraded to PXE 
compliance.  PXE compliant boot ROMs are available from  
     -  Bootix Inc (<http://www.bootix.com>),  
     -  3Com/Lanworks (<http://www.3com.com/products/dsheets/400350.html>), and
     -  Elisa Research. (<http://www.elisaresearch.com/>).

The PXE 2.1 specification can be found at: 
	(<ftp://download.intel.com/ial/wfm/pxespec.pdf>)


Required Equipment
==================

To create a remote boot network environment you will need the following 
equipment:

     -  One DHCP Server (DHCP or BOOTP daemon required)

     -  One or (optionally) two PXE Servers (PXE daemon and TFTP/MTFTP daemon 
	required on each)

     -  One or more PXE PC clients


DHCP Server Considerations 
--------------------------

The DHCP server can be located anywhere on your network as long as it is 
reachable by the booting client(s).  The DHCP server provides the PXE client(s) 
with the following information: a client IP address, subnet mask, and optional 
gateway IP address.  Without this information the client cannot remote boot.

The PXE daemon cannot be used on this server because the DHCP daemon will not 
allow sending back a class-identifier (option 60) in the DHCP offer.  PXE 
clients must see the class-identifier (option 60) set to "PXEClient". 
Therefore this option (among others) must be provided by proxyDHCP (see next
section).


PXE Server Considerations
-------------------------

The following information provides an overview for a basic setup, but does not 
cover all the possible options available.  For more information on extending 
these capabilities you should refer to the PXE 2.1 specification.

The PXE server runs the PXE daemon and the TFTP and/or MTFTP daemons. The PXE 
daemon provides two capabilities: "proxyDHCP" and "PXE Bootserver".  The PXE 
daemon can be set up to provide either or both of the capabilities.  Both 
capabilities are required.  Normally you will enable both capabilities on a 
single machine, however you may wish to provide multiple "PXE Bootserver" 
capabilities across several machines to provide load balancing and redundancy
in a large installation.

Specific setup information is provided in the "Installing and Building PXE" 
section below.


proxyDHCP 
---------

proxyDHCP is a capability provided by the PXE daemon.  As the name implies, 
proxyDHCP works in parallel with DHCP and provides the booting client with 
remote boot configuration options.  ProxyDHCP provides the PXE client(s) with 
the following information: remote boot prompt with optional timeout, remote
boot menu and PXE Bootserver discovery options.

To insure that the server providing proxyDHCP is reachable by the PXE client,
do one of the following:

1.	Wherever you have a DHCP server on your network, place a proxyDHCP 
	server on the same subnet.  If you use routers to forward DHCP packets 
	to your DHCP server(s), you must reconfigure the routers to also 
	forward DHCP packets to the server providing proxyDHCP.

or

2.	Place a server providing proxyDHCP on each subnet where you have PXE 
	clients that you want/need to remote boot.

Whether you choose #1 or #2, is up to you.  The important thing is that the
DHCP discover packet sent by the PXE client reaches both the DHCP and the
proxyDHCP servers.

ProxyDHCP also serves up an initial NBP (network bootstrap program) to older 
(WfM-1.1a compliant) PXE boot ROMs.  These ROMs usually identify themselves
with a version numbers from 0.97 to 0.99n.  To insure support for these boot
ROMs, you must have a TFTP/MTFTP daemon installed on your proxyDHCP server and
you must include the initial bootstrap file:

	/tftpboot/X86PC/UNDI/BStrap/bstrap.0

At this point, the booting client now has enough information to discover the
PXE Bootserver.  Configuration of the PXE Bootserver is described in the next 
section.


PXE Bootserver  
--------------

The PXE Bootserver is a capability provided by the PXE daemon. The PXE 
Bootserver is the capability that provides the booting client with boot images 
for a particular boot environment.  In this case, you are setting up the PXE 
Bootserver to serve Linux remote installation boot images.

A PXE Bootserver serves up requested NBPs to PXE clients. PXE Clients locate
PXE Bootservers using discovery information provided to the client by
proxyDHCP.  The discovery method used by the PXE client (multicast, broadcast
or unicast) and the list of available bootserver types is controlled by
proxyDHCP.  PXE Bootservers always listen for all three types of discovery
requests and will respond to all valid requests.

Mulicast discovery:  If multicast discovery is used, all the PXE Bootservers 
must be configured to listen for the same multicast session.  If there are 
routers between your PXE Bootservers and your PXE clients, the routers must be 
configured to forward multicast IP packets.  When a PXE client tries to
discover a PXE Bootserver using multicast discovery, the client writes a PXE
Bootserver request packet to the PXE Bootserver multicast IP address and waits
for a matching broadcast or unicast PXE Bootserver reply packet.

Broadcast discovery:  If broadcast discovery is used, all of the PXE
Bootservers must be configured to listen for broadcast packets.  If there are
routers between your PXE Bootservers and your PXE clients, the routers must be 
configured to forward DHCP broadcast packets to the PXE Bootservers.

Unicast discovery:  If a list of PXE Bootserver types and IP addresses is 
included in the proxyDHCP offer packet, the PXE client will unicast a PXE 
Bootserver request packet to each PXE Bootserver in the list until it gets a 
matching PXE Bootserver reply packet.


PXE Client  
----------

Almost any Pentium-class machine with PXE support either built into the BIOS or 
included as an option ROM on an add-in NIC can be a PXE client.

There are two classes of PXE capable clients:  those that comply with the  
"Wired for Management Baseline Version 1.1a" (WfM-1.1a) specification and those 
that comply with the "Preboot Execution Environment Version 2.0" (PXE-2.0) 
specification.  The PXE for WfM-1.1a capability is a subset of PXE-2.0. 
Clients written to the WfM-1.1a specification require an additional bootstrap
program to be downloaded from the proxyDHCP server.  This is discussed earlier
in the "proxyDHCP" section.

When a client has completed its DHCP sequence and has received its proxyDHCP 
offer packet, it then does the following:

     -  If the offer packet includes a boot prompt, it is displayed on the 
	screen.

     -  If the offer packet includes a boot prompt timeout, the client waits 
	until the timeout expires.  If the timeout expires, the first item in 
	the remote boot menu is automatically selected.

     -  If the user presses F8, the timer stops and the remote boot menu is 
	displayed.  The user then selects the desired remote boot option. As 
	set up here, the two options are "Local Boot" and "Install  Linux"

     -  The selected boot menu item is executed.  This may be 'local boot', 
	which will cause PXE to unload and return control to the system BIOS, 
	which is normally followed by an attempt to boot from either the floppy 
	or hard drive.

     -  If "Install  Linux" is selected, the client tries to discover a PXE 
	Bootserver that serves Linux install NBPs.
	
     -  If a matching PXE Bootserver is not found, the client will timeout and 
	return control to the system BIOS.

     -  If a matching PXE Bootserver is found, the client downloads the initial 
	bootstrap from the boot server and transfers control to the downloaded 
	program.


Installing and Building PXE 
===========================

Install the PXE package:

	rpm -ihv /PATH-TO-RPM-FILE/pxe-#.#-#.src.rpm

If you want to rebuild the PXE network bootstrap programs (NBPs), you must 
install the dev86 package:

	rpm -ihv /PATH-TO-RPM-FILE/dev86-#.#.#-#.i386.rpm

After the PXE package is installed, the following files are created in your  
SOURCES directory ( /usr/src/redhat/SOURCES/ ):

	pxe-README (this file) 
	pxe-linux.tar.gz (PXE daemon, MTFTP daemon and NBP source files)
	pxe-linux-config.patch (RedHat specific changes/enhancements)
	pxe.init (PXE daemon start/stop script)

Expand the PXE tar file.  This will create a pxe-linux/ directory with the PXE 
daemon and NBP source files.

	cd /usr/src/redhat/SOURCES 
	tar xvofz pxe-linux.tar.gz

Apply the patch:

	patch -p0 <pxe-linux-config.patch

Copy the PXE daemon start/stop script:

	cp pxe.init /etc/rc.d/init.d/pxe

Build and install the PXE daemon:

	cd pxe-linux/server 
	make 
	make install

After running 'make install' the following files are installed:

	/usr/sbin/pxe 
	/usr/sbin/in.mtftpd 
	/etc/pxe.conf 
	/etc/mtftp.conf 
	/tftpboot/X86PC/UNDI/BStrap/bstrap.0 
	/tftpboot/X86PC/UNDI/linux-install/linux.0

You must add the following line to your /etc/inetd.conf file to enable the 
TFTP daemon:

	tftp dgram udp wait root /usr/sbin/tcpd in.tftpd /tftpboot

If you want to use the PXE MTFTP daemon, then also add this line to your 
/etc/inetd.conf file:

	mtftp dgrap udp wait root /usr/sbin/tcpd in.mtftpd /tftpboot

If you want to use the PXE MTFTP daemon, add the following line to your 
/etc/services file:

	mtftp		1759/udp

You must also add the following lines to your /etc/services file:

	pxe		67/udp 
	pxe		4011/udp

You now must edit the /etc/pxe.conf and /etc/mtftpd.conf files so they match 
your existing/desired network configuration.  For simple testing the existing 
/etc/pxe.conf and /etc/mtftpd.conf files are adequate. For improved performance 
and complex network configurations, these files must be changed.  These changes 
are covered later in this document in the "Configuring the PXE Daemon" section 
and in the "Configuring the MTFTP Daemon" section.

To enable the remote  Linux installation, you must add two more files to the 
/tftpboot/X86PC/UNDI/linux-install/ directory.  These files are:

	linux.1  (The Linux kernel)

and

	linux.2 (The Linux installation initrd image)

You will find the kernel and initial RAMDisk (initrd) image on the CD or FTP 
site:

	Kernel = misc/src/trees/boot/vmlinux 

	Initrd = misc/src/trees/initrd-network.img



Copy the vmlinux file to /tftpboot/X86PC/UNDI/linux-install/linux.1 and the 
initrd file to /tftpboot/X86PC/UNDI/linux-install/linux.2

Now start your PXE services.  You do this by restarting your Linux server or by 
running the following commands:

	/etc/rc.d/init.d/pxe start 
	/etc/rc.d/init.d/inet restart


Now boot a PXE client.  When "Press F8 to view menu..." is displayed on the 
booting client, press the <F8> key.  Select "Install Linux" from the remote
boot menu.

The client should download the kernel and initrd image, boot the kernel and 
bring up a Linux network installation screen.  If this does not happen, go back 
and double check your configuration files and insure your PXE and TFTP/MTFTP 
daemons are running.


Configuring the PXE Daemon
==========================

The following information provides an overview for a basic setup, but does not 
cover all the possible options available.  For more information on extending 
these capabilities you should refer to the PXE 2.1 specification.

The PXE daemon configuration file, /etc/pxe.conf, will work correctly for the 
'Network #1' setup defined later in this section.  If you need to add other 
proxyDHCP or Bootservers to your network, you will need to change some of the 
settings in this file.

Most of the fields in the configuration file are not described in this document 
because they do not affect the Linux remote boot installation.  Inside the 
configuration file you will find that all of the fields, and their settings, 
are documented.


Common Fields to Check
----------------------

[Discovery_MCast_Disabled]:  If you have routers on your network between your 
PXE Bootservers and your PXE clients and these routers are not configured to 
forward multicast IP packets, you will need to this field from '0' to '1'.  You 
will also want to disable MTFTP (see the next section on how to configure the 
MTFTP daemon).

[Discovery_BCast_Disabled]:  If you have routers on your network between your 
PXE Bootservers and your PXE clients and these routers are not configured to 
forward broadcast IP packets, you will need to change this field from '0' to 
'1'.

[Discovery_List]:  If you disable both multicast and broadcast discovery 
mechanisms, you MUST enable unicast discovery by filling in this field with the 
IP addresses and types of your PXE Bootservers.


Network #1 -  using a single PXE Server
----------

     -  A DHCP server

     -  One PXE server (proxyDHCP and PXE Bootserver both enabled)

     -  One or more PXE clients

     -  The defaults in your PXE daemon configuration file support this
     	configuration.


Network #2 – using multiple PXE Servers
----------

     -  A DHCP server

     -  One PXE Server with proxyDHCP enabled

     -  One or more PXE Servers with PXE Bootserver enabled

     -  One or more PXE clients

For this configuration, you must make the following changes to your PXE daemon 
configuration file (/etc/pxe.conf):

     -  On the PXE Server with proxyDHCP enabled, remove "13,linux-install" 
	from the list of supported [Service_Types].

     -  On the PXE Server() with PXE Bootserver enabled, change [StartProxy] 
	from '1' to '0' and remove "0,BStrap" from the list of supported 
	[Service_Types].


Configuring the MTFTP Daemon
============================

The MTFTP daemon configuration file, /etc/mtftpd.conf, will not need to be 
changed.  It is already configured to remote boot a Linux installation 
using MTFTP.

If you do not, or cannot, use MTFTP on your network; change 
[IsMulticastEnabled] from '1' to '0'.

You should not need to change the MTFTP port numbers [ServerPort] and 
[ClientPort].  All MTFTP servers and client on the same network can use the 
same initial port numbers.  Like TFTP, a MTFTP session switches to a different 
port number after the first packet exchange.

The [OpenTimeout] and [ReopenDelay] fields are good for most situations.  If 
you find that you are multicasting large files you might want to increase the 
timeout/delay fields a little.  Please note that these fields affect all 
multicasted files.  If you make these fields larger than 5 seconds, you should 
probably remove the smaller files from the [Multicast_ip_addresses] section.

If you look at the last section, [Multicast_ip_addresses] in the configuration 
file, you will see that both NBPs (bstrap.0 and linux.0), the kernel (linux.1) 
and the initial RAMDisk image (linux.2) have been assigned multicast IP 
addresses.  Any file that is not listed in this section will NOT be 
multicasted.  Any file that is listed MUST have a unique multicast IP address 
assigned to it.

If you change the name or location of your /tftpboot directory, you will have
to edit the filenames in the /etc/mtftpd.conf file and the directory names in
the /etc/pxe.conf file.


--------------040702060901010403070103--

