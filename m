Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbTKCPcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 10:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbTKCPcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 10:32:31 -0500
Received: from h234n2fls24o1061.bredband.comhem.se ([217.208.132.234]:31711
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S262051AbTKCPc2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 10:32:28 -0500
Date: Mon, 3 Nov 2003 16:34:55 +0100
From: Voluspa <lista2@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: NFS on 2.6.0-test9:
Message-Id: <20031103163455.57d24178.lista2@comhem.se>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003-11-03 13:42:35 Luke Driscoll wrote:

>On a kernel 2.6.0-test9 as an NFS client I am having trouble
>transferring data to and from NFS servers. It it extraordinarily
>slow.  I receive the following information in dmesg:
>
>nfs warning: mount version older than kernel
>nfs: server safe not responding, still trying

You and me the same. Here's a message I sent to
nfs@lists.sourceforge.net this Friday:

--quote--
xSubject: 2.6.0-test3-bk10-final regression getting out of hand
xDate: Fri, 31 Oct 2003 21:48:51 +0100

As reported in:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106195494828814&w=2
I'm experiencing a serious NFS regression since 2.6.0-test3-bk10-final
(bk-set determined now). Since that, along the road to 2.6.0-test9,
something has gotten completely out of hand.

cp -a /mnt/oden/etc .

_2.6.0-test3-bk10_
2 minutes

_2.6.0-test3-bk10-final_
3 minutes 47 seconds

_2.6.0-test9_
29 minutes 54 seconds

Nothing has changed in hardware or setup, and the cp tests were done
today. Not being a programmer I tried to delete individual patches in
the bk-set, but couldn't find the exact breakage point.

Erasing changes to:
linux-2.6.0-test3-bk10/fs/nfs/dir.c
No change.

Erasing changes to:
linux-2.6.0-test3-bk10/fs/nfs/nfsroot.c
No change.

Erasing changes to:
linux-2.6.0-test3-bk10/include/linux/sunrpc/timer.h
linux-2.6.0-test3-bk10/net/sunrpc/timer.c
No change.

Erasing changes to:
linux-2.6.0-test3-bk10/net/sunrpc/clnt.c
Doesn't compile.

Erasing changes to:
linux-2.6.0-test3-bk10/include/linux/sunrpc/xprt.h
linux-2.6.0-test3-bk10/net/sunrpc/xprt.c
Doesn't compile.

Using TCP or DIRECTIO in -test9 makes no difference. Here's the
relevant .config-section:

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
# CONFIG_NFSD_TCP is not set
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_GSS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

--unquote--

Mvh
Mats Johannesson
