Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTL0Oo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 09:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264479AbTL0Oo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 09:44:59 -0500
Received: from fep03.swip.net ([130.244.199.131]:12030 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP id S264433AbTL0Oo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 09:44:57 -0500
Message-ID: <3FED9A87.4020209@free.fr>
Date: Sat, 27 Dec 2003 15:43:19 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kernel@pacrimopen.com
Subject: Re: IDE performance drop between 2.4.23 and 2.6.0
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I solved the problem in a very strange way. Note that the (b) disk
performance only improves after readahead has been increased on another
(c) drive! (the (c) drive performance was also increased by to 2.4
levels but is not shown here). I could reliably repeat this behavior
after rebooting.

Can any IDE expert explain it?

# hdparm /dev/hdb
~ multcount    =  0 (off)
~ IO_support   =  1 (32-bit)
~ unmaskirq    =  1 (on)
~ using_dma    =  1 (on)
~ keepsettings =  0 (off)
~ readonly     =  0 (off)
~ readahead    = 256 (on)
~ geometry     = 65535/16/63, sectors = 80418240, start = 0
# hdparm -t /dev/hdb
~ Timing buffered disk reads:   34 MB in  3.09 seconds =  11.02 MB/sec
# hdparm -a 4096 /dev/hdb
/dev/hdb: readahead = 4096 (on)
# hdparm -t /dev/hdb
~ Timing buffered disk reads:   34 MB in  3.08 seconds =  11.04 MB/sec
# hdparm -a 4096 /dev/hdc
/dev/hdc: readahead = 4096 (on)
# hdparm -t /dev/hdb
~ Timing buffered disk reads:   46 MB in  3.12 seconds =  14.76 MB/sec



- --
Jean-Luc Fontaine  mailto:jfontain@free.fr  http://jfontain.free.fr/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE/7ZqDkG/MMvcT1qQRAvLKAKC0t3Lsq+B4DBCAwQVadoXVkPxahACfZbfU
UBE4kGDSf6WpuMRtsuxSJCU=
=0u8i
-----END PGP SIGNATURE-----

