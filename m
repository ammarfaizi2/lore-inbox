Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbUK3S36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbUK3S36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 13:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbUK3S35
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 13:29:57 -0500
Received: from smtp07.auna.com ([62.81.186.17]:44492 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S262233AbUK3S3c convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 13:29:32 -0500
Date: Tue, 30 Nov 2004 18:29:28 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: cdrecord dev=ATA cannont scanbus as non-root
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
References: <1101763996l.13519l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411292246310.15146@yvahk01.tjqt.qr>
	<1101765555l.13519l.1l@werewolf.able.es> <20041130071638.GC10450@suse.de>
	<1101834765l.8903l.4l@werewolf.able.es>
	<Pine.LNX.4.53.0411301835511.11795@yvahk01.tjqt.qr>
	<1101836984l.13015l.0l@werewolf.able.es>
	<Pine.LNX.4.53.0411301854001.29170@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.53.0411301854001.29170@yvahk01.tjqt.qr> (from
	jengelh@linux01.gwdg.de on Tue Nov 30 18:56:46 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101839368l.13015l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.11.30, Jan Engelhardt wrote:
> >Err, as it tries to open a device and it does not exist.
> >I tries sequentially
> >hda, hdb, hdc.. up to 256 until it finds something to open.
> >If it exists, but has not permissions, it keeps trying on the next.
> >But if it is not present, cdrecord gives up.
> 
> Reasonable procedure. Albeit, leaky:
> Imagine you use devfs... open()ing something like hd* would probably always
> create a node. Although there is a max on possible, meaningful, nodes,
> someone could use this to fill up /dev with
> ridiculuous amounts of nodes, all of which are to my knowledge in kernel space.
> "Well then, goodbye".
> 
> Luckily, even the very default config does not create arbitrarily nodes, and
> cdrecord doesnot probe arbitr. devices.
> 
> So I guess, yes, cdrecord should probe harder. Preferably by looking into /sys
> when using a 2.6 system.
> 

Patch for cdrecord:

--- cdrtools-2.01/libscg/scsi-linux-ata.c.orig	2004-11-30 19:02:37.929176615 +0100
+++ cdrtools-2.01/libscg/scsi-linux-ata.c	2004-11-30 19:06:11.316213702 +0100
@@ -385,8 +385,6 @@
 						device, f, errno);
 					}
 					return (-2);
-				} else if (errno == ENOENT || errno == ENODEV) {
-					break;
 				}
 			} else {
 				/* ugly hack, make better, when you can. Alex */

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam3 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1


