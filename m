Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284954AbRLFDXY>; Wed, 5 Dec 2001 22:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284957AbRLFDXF>; Wed, 5 Dec 2001 22:23:05 -0500
Received: from mail.mesatop.com ([208.164.122.9]:12 "EHLO thor.mesatop.com")
	by vger.kernel.org with ESMTP id <S284954AbRLFDWx>;
	Wed, 5 Dec 2001 22:22:53 -0500
Message-Id: <200112060322.fB63MNb10689@thor.mesatop.com>
Content-Type: text/plain; charset=US-ASCII
From: Steven Cole <elenstev@mesatop.com>
Reply-To: elenstev@mesatop.com
To: esr@thyrsus.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Configure.help 2.4.17 update patch
Date: Wed, 5 Dec 2001 20:16:53 -0700
X-Mailer: KMail [version 1.3.1]
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20011203155438.A27630@thyrsus.com> <Pine.LNX.4.21.0112041203490.19552-100000@freak.distro.conectiva> <20011204184439.A1969@thyrsus.com>
In-Reply-To: <20011204184439.A1969@thyrsus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 December 2001 04:44 pm, Eric S. Raymond wrote:
> Marcelo Tosatti <marcelo@conectiva.com.br>:
> > Still doesnt apply cleanly.
>
> Weird.  OK, I rebuilt 2.4.17-pre2 from 2.4.16 plus the 2.4.17-pre2 patch.
> Here is the diff:
>
[large patch snipped]

Eric and Marcelo, 

That large patch applied cleanly against 2.4.17-pre2, but had two rejected hunks
against 2.4.17-pre4, but not to worry.  The rejected hunks are in two options
which got removed between pre2 and pre4.  

Here is a diff between pre2 and pre4 to show what got dropped.
This diff is not meant to be applied, I'm just including it here to show what happened.

I suggest that Marcelo go ahead and apply Eric's patch, with the two meaningless rejects,
and let the resulting Configure.help be the new baseline for the 2.4.x series, and fork
Configure.help for the 2.4.x and 2.5.x series, since we have different sets of patches
coming in and it is just not practical (or reasonable) to try to fit the same Configure.help
file to both the stable and development series.

Steven

Note again, this diff is just FYI, between pre2 and pre4.

--- linux-2.4.17-pre2/Documentation/Configure.help.pre2	Sat Dec  1 19:47:27 2001
+++ linux/Documentation/Configure.help	Wed Dec  5 19:01:08 2001
@@ -5154,13 +5154,6 @@
 
   It is safe to say N here for now.
 
-IPv6: routing messages via old netlink
-CONFIG_IPV6_NETLINK
-  You can say Y here to receive routing messages from the IPv6 code
-  through the old netlink interface. However, a better option is to
-  say Y to "Kernel/User network link driver" and to "Routing
-  messages" instead.
-
 Kernel httpd acceleration
 CONFIG_KHTTPD
   The kernel httpd acceleration daemon (kHTTPd) is a (limited) web
@@ -5915,33 +5908,6 @@
 
   If unsure, say N.
 
-Kernel/User network link driver
-CONFIG_NETLINK
-  This driver allows for two-way communication between the kernel and
-  user processes.  It does so by creating a new socket family,
-  PF_NETLINK.  Over this socket, the kernel can send and receive
-  datagrams carrying information.  It is documented on many systems in
-  netlink(7), a HOWTO is provided as well, for example on
-  <http://snafu.freedom.org/linux2.2/docs/netlink-HOWTO.html>.
-
-  So far, the kernel uses this feature to publish some network related
-  information if you say Y to "Routing messages", below. You also need
-  to say Y here if you want to use arpd, a daemon that helps keep the
-  internal ARP cache (a mapping between IP addresses and hardware
-  addresses on the local network) small.  The ethertap device, which
-  lets user space programs read and write raw Ethernet frames, also
-  needs the network link driver.
-
-  If unsure, say Y.
-
-Routing messages
-CONFIG_RTNETLINK
-  If you say Y here, user space programs can receive some network
-  related routing information over the netlink. 'rtmon', supplied
-  with the iproute2 package (<ftp://ftp.inr.ac.ru>), can read and
-  interpret this data.  Information sent to the kernel over this link
-  is ignored.
-
 Netlink device emulation
 CONFIG_NETLINK_DEV
   This option will be removed soon. Any programs that want to use
@@ -13852,30 +13818,11 @@
 CONFIG_TMPFS
   Tmpfs is a file system which keeps all files in virtual memory.
 
-  In contrast to RAM disks, which get allocated a fixed amount of
-  physical RAM, tmpfs grows and shrinks to accommodate the files it
-  contains and is able to swap unneeded pages out to swap space.
-
-  Everything is "virtual" in the sense that no files will be created
-  on your hard drive; if you reboot, everything in tmpfs will be
-  lost.
-
-  You should mount the file system somewhere to be able to use
-  POSIX shared memory. Adding the following line to /etc/fstab should
-  take care of things:
-
-  tmpfs		/dev/shm	tmpfs		defaults	0 0
-
-  Remember to create the directory that you intend to mount tmpfs on
-  if necessary (/dev/shm is automagically created if you use devfs).
-
-  You can set limits for the number of blocks and inodes used by the
-  file system with the mount options "size", "nr_blocks" and
-  "nr_inodes". These parameters accept a suffix k, m or g for kilo,
-  mega and giga and can be changed on remount.
+  Everything in tmpfs is temporary in the sense that no files will be
+  created on your hard drive. If you reboot, everything in tmpfs will
+  be lost.
 
-  The initial permissions of the root directory can be set with the
-  mount option "mode".
+  See <file:Documentation/filesystems/tmpfs.txt> for details
 
 Simple RAM-based file system support
 CONFIG_RAMFS
@@ -24001,10 +23948,10 @@
 # LocalWords:  filesystems smbfs ATA ppp PCTech RZ www powerquest txt CMD ESDI
 # LocalWords:  chipset FB multicast MROUTE appletalk ifconfig IBMTR multiport
 # LocalWords:  Multisession STALDRV EasyIO EC EasyConnection ISTALLION ONboard
-# LocalWords:  Brumby pci TNC cis ohio faq usenet NETLINK dev hydra ca Tyne mem
+# LocalWords:  Brumby pci TNC cis ohio faq usenet dev hydra ca Tyne mem
 # LocalWords:  carleton DECstation SUNFD JENSEN Noname XXXM SLiRP LILO's amifb
 # LocalWords:  pppd Zilog ZS SRM bootloader ez mainmenu rarp ipfwadm paride pcd
-# LocalWords:  RTNETLINK mknod xos MTU lwared Macs netatalk macs cs Wolff
+# LocalWords:  mknod xos MTU lwared Macs netatalk macs cs Wolff
 # LocalWords:  dartmouth flowerpt MultiMaster FlashPoint tudelft etherexpress
 # LocalWords:  ICL EtherTeam ETH IDESCSI TXC SmartRAID SmartCache httpd sjc dlp
 # LocalWords:  thesphere TwoServers BOOTP DHCP ncpfs BPQETHER BPQ MG HIPPI cern
