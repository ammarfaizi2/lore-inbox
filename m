Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTF0Rif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 13:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264544AbTF0Rif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 13:38:35 -0400
Received: from csl2.consultronics.on.ca ([204.138.93.2]:13448 "EHLO
	csl2.consultronics.on.ca") by vger.kernel.org with ESMTP
	id S264543AbTF0Ri0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 13:38:26 -0400
Date: Fri, 27 Jun 2003 13:52:27 -0400
From: Greg Louis <glouis@dynamicro.on.ca>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.4.21-ac3 nfs v3 malfunctioning, -ac2 ok
Message-ID: <20030627175227.GA5449@athame.dynamicro.on.ca>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Organization: Dynamicro Consulting Limited
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem summary: nfs v3 in -ac3 mishandles root directory exports:
subdirectories exported with the nohide option are invisible to the
client, and re-export on the server (exportfs -rv) shows exports of /
failing with "Invalid parameter".

Config info:

NFS file system support (CONFIG_NFS_FS) [Y/m/n/?] 
  Provide NFSv3 client support (CONFIG_NFS_V3) [Y/n/?] 
  Allow direct I/O on NFS files (EXPERIMENTAL) (CONFIG_NFS_DIRECTIO) [N/y/?] 
NFS server support (CONFIG_NFSD) [Y/m/n/?] 
  Provide NFSv3 server support (CONFIG_NFSD_V3) [Y/n/?] 
  Provide NFS server over TCP support (EXPERIMENTAL) (CONFIG_NFSD_TCP) [N/y/?] 

nfs-utils-1.0.3

Details:

I've got 3 Linux boxes at home that allow nfs mounts of each other's
root trees, and each server exports its other mounted subtrees
with the "nohide" option so that they should be visible to the clients
after the NFS mount of / is performed.

With an -ac2 client and -ac2 server, this works fine.  Mounts succeed,
clients can see, read and write into exported subtrees.

With -ac3 client and server, when the server offers to export / to that
client, an initial mount seems to work; however, the nohide option for
subdirectories that are also exported does not.  The client can't see
the contents of such subdirectories, and a write to the mount point by
the client writes to the parent disk as if the mounted tree wasn't
there.  Further, if one then does exportfs -rv on the server, exports
of / to the kernel fail with "Invalid parameter" and the client can no
longer mount / at all.

With an -ac2 client and -ac3 server, the initial mounts of the server /
are successful, and mounted-and-exported subdirectory trees are visible
to the client; I didn't try re-exporting in this configuration.  With
-ac2 on both ends, re-exporting is successful.

The -ac2 tree's .config file was copied into the -ac3 tree and new
options presented during 'make oldconfig' were declined.

-- 
| G r e g  L o u i s          | gpg public key: finger     |
|   http://www.bgl.nu/~glouis |   glouis@consultronics.com |
| http://wecanstopspam.org in signatures fights junk email |
