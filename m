Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272322AbTG3Wfl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272323AbTG3Wfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:35:41 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:6795
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S272322AbTG3Wfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:35:36 -0400
Date: Wed, 30 Jul 2003 18:51:15 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.x NFS and NFSD
Message-ID: <20030730185115.B16021@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone had any luck with either of these?

2.6.x as a server:
I'm using nfs-kernel-server v1.0.5-1 (debian).
Config Ops:
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y   << I didn't configure this, where'd it come from?
CONFIG_EXPORTFS=m
CONFIG_SUNRPC=m
This is in /etc/exports:
/ vegeta(rw,no_root_squash,async,nohide)

on the machine vegeta, I mount this machine (kingkai:/ /mnt), cd to /mnt, do
ls, and ls hangs.  client uses kernel 2.4.20 with NFSv3 enabled and it was
mounted v3.

2.6.x as a client:
If the server is using 2.4.x with the kernel nfs server, all's fine except
for nohide.  I have a 2.4.21 alpha machine exporting / and /raid-0 with the
nohide option.  If I mount it to /mnt and cd /mnt/raid-0 there's nothing
there.  On 2.4.20 client this works. (NFSv3 here)

If the server is using the userspace nfs server (I don't like exporting all
those mount points with nohide and this works for me on most machines that I
access occasionally.  I assume userspace is NFSv2. 2.2beta47-12) Kernel
2.6.x will simply say the nfs server is not responding if I do an ls.  If I
copy a file (not using tab completion), it seems to work.

client options:
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set


Now on a positive note, my hp scanjet 5370c works with 2.6.0-test2 great
where as 2.4 it doesn't.  the NFS is holding me back.


P.S.
Vegeta: kernel 2.4.20, userspace nfs, inspiron 8100 1ghz pIII 256mb ram
	NIC: intel 10/100
Kingkai: Kernel 2.6.0-test1, kernel nfs, home build 700mhz pIII 256mb ram
	NIC: 3com 3cr990srv 10/100   MainBoard: MSI MS-6163 v2
Alpha: Kernel 2.4.21, kernel nfs, AlphaServer 1000A 4/266 160mb ram
	NIC: Dec Tulip 10/100

All machines use ext3 as the local filesystem.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
