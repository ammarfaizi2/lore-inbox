Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319076AbSHMWuN>; Tue, 13 Aug 2002 18:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319080AbSHMWuM>; Tue, 13 Aug 2002 18:50:12 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:65420 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319076AbSHMWuL>; Tue, 13 Aug 2002 18:50:11 -0400
Date: Tue, 13 Aug 2002 18:53:57 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@rastan.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: announcing NFSv4 patches against 2.5.31
Message-ID: <Pine.SOL.4.44.0208131852230.25942-100000@rastan.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is an announcement of a set of 38 patches against Linux 2.5.31,
which implement basic NFSv4 functionality.  The patches were
developed as part of the NFSv4 project at the University of Michigan.
We are aiming to work with other kernel developers in the next
few weeks, to get the patches included in 2.5.x.  In addition, we
could always use more testing, so if anyone wants to apply the patches
and bang on them, that would be extremely helpful as well.

For now, only the bare minimum of features have been implemented --
just enough to create a functional network file system.  Byte-range
file locking, state management, recovery from server reboot, extended
attributes, ACL's, the NFSv4 "pseudo filesystem", and strong security
are still unimplemented in 2.5.x.  Actually, we have implementations of
most of these features in 2.4.x, but are waiting to port them to 2.5.x
until the "minimal" patches have been approved.

(For those familiar with the NFSv4 protocol, I should elaborate by
 saying that the client does all of its READs and WRITEs using "magic
 stateids" and uses OPEN and CLOSE only when it needs to create a
 file.  The server treats all state-manipulating operations such
 as SETCLIENTID,OPEN,CLOSE... as no-ops and does not remember state.
 Instead of a proper implementation of the pseudo filesystem, the
 first entry in /etc/exports is chosen as the nominal root.)

Here are directions for running NFSv4.  Note that a few userland
utilities are necessary (URL's given as needed):

1. Apply the NFSv4 patches to a clean 2.5.31 kernel, either one at a time
   from the messages following this one, or all at once by downloading
   the "grand unified patch" from
       www.citi.umich.edu/projects/nfsv4/patches-2.5/patch-2.5.31-E
   There will be seperate kernel config options for NFSv4 support in
   the client and server.

2. Download and install the GSSD daemon from
       www.citi.umich.edu/projects/nfsv4/simple-gssd/
   This daemon must be running on both the client and server.

3. Warning!!  Special configuration on the server is necessary before an
   NFSv4 export will be accessible.
     First, it must be exported specifically to the client in question,
   without use of string wildcards, e.g.

       /some/export     farringdon.citi.umich.edu(rw)

   in /etc/exports is OK, but

       /some/export     *.citi.umich.edu(rw)

   is not.
     Second, only the _first_ export (by order in /etc/exports) will be
   visible to a given client.
     Finally, this export will appear to an NFSv4 client as '/' instead of
   the actual export pathname (/some/export in the example above).
     All of this special configuration is only necessary because this
   set of patches does not include a proper implementation of the NFSv4
   pseudo filesystem.  As soon as these patches patches (or a variant
   thereof) is incorporated into the kernel, our next goal is to develop a
   satisfactory pseudofs for 2.5.x, at which point the need for this
   special configuration will go away.

4. On the client, you will need a patched version of the mount and umount
   utilities.  Download util-linux-2.11t from kernel.org, apply the patch

   www.citi.umich.edu/projects/nfsv4/patches-2.5/patch-util-linux-2.11t-A

   and build mount and umount as usual.  If you are nervous about
   tampering with the built-in mount and umount on your system, we
   recommend creating symlinks, e.g.

# ln -s /usr/src/util-linux-2.11t-nfsv4/mount/mount /usr/local/bin/mount4
# ln -s /usr/src/util-linux-2.11t-nfsv4/mount/umount /usr/local/bin/umount4

   You should then be able to start the server as usual, and mount with

# mount4 -t nfs -o vers=4,... somehost.somedomain.com:/ /mnt/nfs

   If this doesn't work, it is probably because GSSD is not running
   on either the client or the server, or because you're not mounting '/'
   (see 3. above).


These directions, as well as copies of the patches, are also available at
   www.citi.umich.edu/projects/nfsv4/patches-2.5
This URL will always be kept up-to-date with the latest versions of the
patches.

Cheers,
 Kendrick Smith
 Center for Information Technology and Integration, University of Michigan

