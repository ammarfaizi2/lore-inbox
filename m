Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265610AbTIDWbo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 18:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbTIDWbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 18:31:44 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:3487 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S265600AbTIDWbi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 18:31:38 -0400
Subject: Re: [PATCH] mount -w of dvd+rw etc. in vanilla 2.6
From: Pat LaVarre <p.lavarre@ieee.org>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1062714962.5959.17.camel@lintel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Sep 2003 16:36:02 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Sep 2003 22:31:37.0910 (UTC) FILETIME=[4DE8C560:01C37334]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> mount -w -t udf works with my dvd-ram ...
> mistakenly sees my dvd+rw as read-only ...

Besides that Andy Polyakov patch for mount -w of dvd+rw, the web has
Jens Axboe patches for mount -w of cd-rw, via the udf faq (Not via the
udftools faq):

http://sourceforge.net/projects/linux-udf/
udf-0.9.7.tar.gz
FAQ
http://w1.894.telia.com/~u89404340/patches/packet/

---

>From these two clues, kindly offline people have identified the Four
fragments of kernel source that cooperate to conclude erroneously that
dvd+rw etc. are not writable:

1)

drivers/scsi/sr.c understands only the CDC_DVD_RAM profile of the seven
standard mmc "writable" device "profile"s, because sr.c neglects to look
beyond the "Capabilities" mode page x2a i.e. does not look beyond the
mmc 1 standard of 1997.  Ansi did not publish an op x46 Get
Configuration standard until the mmc 2 of 1999.

2)

include/scsi/scsi.h does not yet #define GET_CONFIGURATION 0x46.

3)

drivers/cdrom/cdrom.c also understands only CDC_DVD_RAM: cdrom.c
erroneously claims all mmc profiles except CDC_DVD_RAM are not
FMODE_WRITE-able.

4)

include/linux/cdrom.h names only CDC_DVD_RAM.

---

Anyone have an idea of how best to patch this?

I've seen a few linux-2.6.0-test4/ and linux-2.4.22/ alternatives mostly
work.  Anyone interested in evaluating some of them?

Pat LaVarre



