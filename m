Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262745AbVCDAKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262745AbVCDAKS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVCDAIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:08:48 -0500
Received: from smtp08.auna.com ([62.81.186.18]:20657 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S262800AbVCCXy6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:54:58 -0500
Date: Thu, 03 Mar 2005 23:54:41 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: 2.6.11-rc3-mm2: broken NFS ?
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Balsa 2.3.0
Message-Id: <1109894081l.8982l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

I have a problem with nfs. It always worked, so I don't know what is
failing now.

I have a server running 2.6.11-rc3-mm2. I try to export a dir via nfs:

/etc/exports:
  /raid belly.cps.unizar.es(ro,insecure,no_root_squash,no_subtree_check)

nada:/proc/fs/nfs# exportfs -v 
/raid           belly.cps.unizar.es(ro,wdelay,insecure,no_root_squash,no_subtree_check)

So it looks ok...

But when I try to mount it from OSX:

belly:~ root# mount nada:/raid ./w
mount_nfs: can't access /raid: Permission denied

But the server shows it got mounted:
nada:/var/lib/nfs# cat rmtab
155.210.152.151:belly.cps.unizar.es:0x00000001
belly.cps.unizar.es:/raid:0x00000001

If I now restart nfs:
nada:/var/lib/nfs# service nfs restart
Shutting down NFS mountd:                                       [  OK  ]
Shutting down NFS daemon:                                       [  OK  ]
Shutting down NFS services:                                     [  OK  ]
Starting NFS services:                                          [  OK  ]
Starting NFS daemon:                                            [  OK  ]
Starting NFS mountd:                                            [  OK  ]
nada:/var/lib/nfs# cat /proc/fs/nfs/exports
# Version 1.1
# Path Client(Flags) # IPs

Nothing ?

What is wrong with this setup ?

Kernel is 2.6.11-rc3-mm2, nfs-utils-1.0.7.

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


