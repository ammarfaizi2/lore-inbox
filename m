Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266851AbUG1Jrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266851AbUG1Jrb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 05:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266854AbUG1Jrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 05:47:31 -0400
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:34520 "HELO
	qinetiq-tim.net") by vger.kernel.org with SMTP id S266851AbUG1Jr2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 05:47:28 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: mke2fs -j goes nuts on 3Ware 8506-4LP
Date: Wed, 28 Jul 2004 10:50:19 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200407281050.24958.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.26.0.10; VDF: 6.26.0.48; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


I have a 3Ware 8506-4LP controller with 4 250GB Maxtor SATA drives, in a 
raid-5 configuration (64K blocks)
System is:
Dual Opteron 246 (2GHz)
2GB RAM
Tyan S2875 motherboard

Kernel: 2.6.8-rc2 (pre-empt is ON)
Rest of OS: Mandrake 10.0 AMD64 edition.

When I execute a mke2fs -j /dev/sda7  to format a 600GB partition on the raid 
as ext3, the system slows to a crawl.

Basically, the inode creation goes fine for the first 1000 nodes or so, then 
starts slowing to about 1 node per second.

According to 'top' the systems 'buffers' value is almost all my ram and both 
cpus are at almost 100% in I/O wait.

The system load will start to climb and it eventually hit ~15 before I got 
bored and rebotoed.

X is totally unresponsive although 'top' does refresh occasionally in a 
konsole.


I do understand that the 3Ware 8506 cards arent exactly stellar at raid-5 (we 
see ~22MB/sec write and upto 80MB/sec read if we're lucky) but surely a 
simple format of a filesystem shouldn't tie up the system like this?

Would a different card (3Ware 9500 series or LSI Logic MegaRAID) help here?

Cheers,

Mark.

P.S. As I write this, I'm doing an sa-learn (spamassassin) over 14k messages 
and the system is a little sluggish even though gkrellm is only showing 
~1MB/sec on the 3Ware, so I'm guessing these are just pants cards in general.
Periodically runnung 'sync' helps for a while but it fades again after that.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBB3bgBn4EFUVUIO0RAsi1AKDdSQCoGU3XZgQfo7h6yVoYgJxfewCgjdW/
lQyWsb7xGk1ZCntcDAp8C20=
=hJon
-----END PGP SIGNATURE-----
