Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265745AbUAKDkz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 22:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265752AbUAKDkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 22:40:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63107 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265745AbUAKDkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 22:40:46 -0500
Message-ID: <4000C5A3.5070101@pobox.com>
Date: Sat, 10 Jan 2004 22:40:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Netdev <netdev@oss.sgi.com>
CC: Andrew Morton <akpm@osdl.org>
Subject: [NETDEV] experimental net driver queue updated
Content-Type: multipart/mixed;
 boundary="------------010204090309070907070407"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010204090309070907070407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


The 250+ patch queue was getting way too big to manage, so using BK I 
split things up locally into a number of buckets.  This allowed me to 
much more easily digest Al Viro's latest patch flood, as well as get 
things into much better shape for submission to upstream (as soon as the 
tree re-opens)...  some changes were definitely more experimental than 
others, and won't go to Andrew/upstream until bugs and interface issues 
are fully sorted out.

This split-up allowed me to easily create broken-out sets of patches, 
which are available at the URL below.

Note the new "netdev" moniker too, that's not a typo.

Summary of new changes:
* forcedeth update
* more fixes and cleanups from Al Viro
* netpoll, atmel, dgrs updates
* other bits

Summary of patchkit:
* new e100 driver (rewritten from scratch)
* new nVidia nForce NIC driver
* new pci200syn WAN driver

* r8169 major bug fixes
* e1000 minor updates / fixes
* sk98lin vendor updates / fixes
* many bonding updates and cleanups
* misc bug fixes

* 8139too NAPI support
* tulip NAPI support

* netconsole / netdump support
* net_device allocation and reference counting work


Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.1-bk1-netdev2.patch.bz2

Full changelog:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.1-bk1-netdev2.log

Broken-out patches (broken out into "buckets" not changesets):
http://www.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/broken-out/

BK repo:
bk://gkernel.bkbits.net/netdev-2.6
	or
http://gkernel.bkbits.net/netdev-2.6

Changelog delta attached.



--------------010204090309070907070407
Content-Type: text/plain;
 name="changelog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="changelog.txt"


Alexander Viro:
  o [wan pci200syn] eliminate embedded hdlc_device struct
  o [netdrvr s390/qeth] Alloc fixes
  o [netdrvr shaper] fix double-free
  o [netdrvr dvb/dvb_net] fixes
  o [netdrvr arch/uml] leak fix
  o [netdrvr saa9730] fix double-free
  o [netdrvr arm/am79c961] Fix for IO-before-request_region race
  o [wan] leak fixes in hostess_sv11, lapbether
  o [netdrvr s390/lcs] Leak fix
  o [wireless orinoco] check alloc_etherdev for failure
  o [netdrvr apne] resource leak fix
  o [netdrvr 3c509] Leak fixed
  o [netdrvr acenic] Race and leak fixes
  o [all over] more kfree -> free_netdev
  o [netdrvr isa-skeleton] cleanups and fixes
  o [wan sdla] Fixed leaks and double-free
  o [netdrvr fec] switched to sane allocation.  It still leaks on failure exits, though
  o [netdrvr s390/netiucv] partially sanitized wrt allocation
  o [wireless airo] switched to sane allocation
  o [netdrvr tun] Killed bogus ->init()
  o [wan sealevel] Plugged a leak
  o [wan sbni] sane net_device allocation; plug a bunch of leaks
  o [wan hostess_sv11] sane net_device allocation
  o [wan hdlc_fr] Switched allocation of net_device to alloc_netdev()
  o [wan hdlc] kill embedding of struct net_device
  o [wan hdlc] removal hdlc_to_dev()
  o [wan dscc4] embedded struct removal
  o [wan farsync] embedded struct hdlc_device removal
  o [wan pc300]  use alloc_hdlcdev()/free_hdlcdev().  Leak fixed
  o [wan hdlc] kill embedded struct in various drivers
  o [wan hdlc] new private struct pointer in hdlc_device, and helpers for it
  o [wan hdlc] switch register_hdlc_device() to take net_device arg
  o [wan dscc4] Uses of ->hdlc and hdlc_to_dev() encapsulated into dscc4_to_dev()
  o [wan hdlc] new hdlc_stats() helper
  o [wan pc300] more direct use of net_device
  o [wan hdlc] switch internal ioctl dispatch to net_device
  o [wan wanxl] eliminated hdlc_to_name() uses and a bunch of port->hdlc ones
  o [wan hdlc_x25] eliminated hdlc_to_dev() and hdlc_to_name() uses
  o [wan hdlc] hdlc_fr: eliminated ->netdev, hdlc_to_dev() and hdlc_to_name() uses
  o [wan hdlc] hdlc_cisco: killed ->netdev, hdlc_to_name() and hdlc_to_dev() uses
  o [wan hdlc] hdlc->proto.*() switched to net_device
  o [wan farsync] Eliminated a bunch of port->hdlc and hdlc_to_dev() uses
  o [wan hdlc] hdlc->attach() switched to net_device
  o [wan hdlc] hdlc_set_carrier() switched to net_device
  o [wan hdlc] switch sca_xxx() to use net_device
  o [wan hdlc] new port_to_dev() helper
  o [wan hdlc] hdlc_close() switched to net_device
  o [wan hdlc] hdlc_open() switched to net_device
  o [wan lapb] kill now-unused custom token container
  o [wan lapb] Printks switched from %p lapb->token to %p lapb->dev
  o [wan lapb] switch to use net_device instead of custom token
  o [wan lapb] beginning of cleanups

Andi Kleen:
  o Mark IBM TR driver as not 64 bit clean

Jeff Garzik:
  o [tokenring olympic] use memset_io to fix certain platforms

Manfred Spraul:
  o [netdrvr forcedeth] alloc fixes

Matt Mackall:
  o netpoll carrier handling
  o netconsole init return code
  o netconsole init return code
  o [netdrvr] add netpoll support to several 8390-based drivers
  o netpoll abort for bad interface

Simon Kelley:
  o [wireless atmel] various updates

Stephen Hemminger:
  o bugfixes for dgrs.c


--------------010204090309070907070407--

