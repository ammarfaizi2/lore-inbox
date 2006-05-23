Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWEWOHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWEWOHu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 10:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWEWOHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 10:07:50 -0400
Received: from darla.ti-wmc.nl ([217.114.97.45]:54428 "EHLO smtp.wmc")
	by vger.kernel.org with ESMTP id S1751338AbWEWOHt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 10:07:49 -0400
Message-ID: <44731733.7000204@ti-wmc.nl>
Date: Tue, 23 May 2006 16:07:47 +0200
From: Herman Elfrink <herman.elfrink@ti-wmc.nl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Followup-To: netdev@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
FLAME stands for "Forwarding Layer for Meshing"

FLAME provides an intermediate layer between the network layer (e.g. 
IPv4/IPv6) and the link (MAC) layer, providing L2.5 meshing. Both 
network layer and MAC layer can be used unchanged: to the network layer 
FLAME appears as a normal Ethernet-type MAC layer, and the underlying 
`real' MAC layer will see it as just another type of network layer.

URL (http://www.ti-wmc.nl/flame/)

FLAME uses an unofficial protocol number (0x4040), any tips on how to 
get an official IANA number would be highly appreciated.

Please send your feedback to the FLAME mailinglist: 
flame<at>www<dot>ti<dash>wmc<dot>nl.


README:
-----------------------------------------------------------
General:
========
FLAME implements an intermediate layer between IP an MAC, providing
MAC-level forwarding. It is used to solve mesh networking below the
networking layer (L2.5 meshing).
Using FLAME, the meshed net is represented to the network layer as a normal
ethernet-type subnet, so, unlike L3 mesh solutions like OLSR and AODV, all
standard IP mechanisms (routing, addressing, broadcast/multicast, neighbor
discovery) work as expected.
FLAME is independent of and can be used under each type of network layer
(IP, IPv6, etc).
For more information: see the documentation in the /doc directory.
FLAME is provided as a kernel module for linux 2.4 and 2.6.
MACINFO is an additional module that is used to store the cost value related
to nodes (identified by MAC addresses) in the FLAME network. These cost
values can be retrieved by user programs and could be used to make
routing decisions.

Requirements
============
In order to compile flame, the kernel source for the currently running
kernel should be available via the symbolic link: /lib/modules/`uname 
-r`/build
Use Makefile-2.4 for compiling with 2.4.x linux kernels and Makefile for
2.6.x(.x) kernels.

Installation
============
- Extract the tarball
- Compile and install the code (requires kernel source):
    make
    make install

Configuration
=============
Invent a name () for each FLAME device you want to use
(e.g. 'flm0'), and create an interface configuration entry for
each device (e.g. on Mandriva: /etc/sysconfig/network-scripts/ifcfg-flm0)
For all MAC devices to be used under a FLAME device: if IP is configured
for a MAC device, its prefix should differ from the IP prefix for the 
FLAME device.

Usage
=====
- Load module:
    modprobe flame [debuglevel=]  [flm_topo_timer=]
      : debug level, default: 1
      : topology check timer (in seconds), default: 5
- Open/close a device with:
    echo "up   []" > /proc/net/flame/cmd
    echo "down " > /proc/net/flame/cmd
      : name of FLAME device, e.g. flm0
      : comma-separated list of MAC devices (at least one) that are
      used below the FLAME device. All of these must be up.
    : comma-separated list of MAC addresses of devices
      for which traffic should be ignored; each MAC address should
      be a semicolon-separated list of 6 hex-pairs
- Get current forwarding info from FLAME:
    cat /proc/net/flame/fwd
- Get nodes/cost information from MACINFO:
    cat /proc/net/macinfo

Bugs
====
Should you find any bugs (and preferably fix them ;-) please let us know via
the mailinglist.
subject: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing

FLAME stands for "Forwarding Layer for Meshing"

FLAME provides an intermediate layer between the network layer (e.g. 
IPv4/IPv6) and the link (MAC) layer, providing L2.5 meshing. Both 
network layer and MAC layer can be used unchanged: to the network layer 
FLAME appears as a normal Ethernet-type MAC layer, and the underlying 
`real' MAC layer will see it as just another type of network layer.

URL (http://www.ti-wmc.nl/flame/)

FLAME uses an unofficial protocol number (0x4040), any tips on how to 
get an official IANA number would be highly appreciated.

Please send your feedback to the FLAME mailinglist: 
flame<at>www<dot>ti<dash>wmc<dot>nl.


<include: readme>
------------------

General:
========
FLAME implements an intermediate layer between IP an MAC, providing
MAC-level forwarding. It is used to solve mesh networking below the
networking layer (L2.5 meshing).
Using FLAME, the meshed net is represented to the network layer as a normal
ethernet-type subnet, so, unlike L3 mesh solutions like OLSR and AODV, all
standard IP mechanisms (routing, addressing, broadcast/multicast, neighbor
discovery) work as expected.
FLAME is independent of and can be used under each type of network layer
(IP, IPv6, etc).
For more information: see the documentation in the /doc directory.
FLAME is provided as a kernel module for linux 2.4 and 2.6.
MACINFO is an additional module that is used to store the cost value related
to nodes (identified by MAC addresses) in the FLAME network. These cost
values can be retrieved by user programs and could be used to make
routing decisions.

Requirements
============
In order to compile flame, the kernel source for the currently running
kernel should be available via the symbolic link: /lib/modules/`uname 
-r`/build
Use Makefile-2.4 for compiling with 2.4.x linux kernels and Makefile for
2.6.x(.x) kernels.

Installation
============
- Extract the tarball
- Compile and install the code (requires kernel source):
    make
    make install

Configuration
=============
Invent a name () for each FLAME device you want to use
(e.g. 'flm0'), and create an interface configuration entry for
each device (e.g. on Mandriva: /etc/sysconfig/network-scripts/ifcfg-flm0)
For all MAC devices to be used under a FLAME device: if IP is configured
for a MAC device, its prefix should differ from the IP prefix for the 
FLAME device.

Usage
=====
- Load module:
    modprobe flame [debuglevel=]  [flm_topo_timer=]
      : debug level, default: 1
      : topology check timer (in seconds), default: 5
- Open/close a device with:
    echo "up   []" > /proc/net/flame/cmd
    echo "down " > /proc/net/flame/cmd
      : name of FLAME device, e.g. flm0
      : comma-separated list of MAC devices (at least one) that are
      used below the FLAME device. All of these must be up.
    : comma-separated list of MAC addresses of devices
      for which traffic should be ignored; each MAC address should
      be a semicolon-separated list of 6 hex-pairs
- Get current forwarding info from FLAME:
    cat /proc/net/flame/fwd
- Get nodes/cost information from MACINFO:
    cat /proc/net/macinfo

Bugs
====
Should you find any bugs (and preferably fix them ;-) please let us know via
the mailinglist.
