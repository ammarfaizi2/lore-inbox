Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWDUEvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWDUEvP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 00:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932233AbWDUEoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 00:44:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:39041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932230AbWDUEoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 00:44:00 -0400
Date: Thu, 20 Apr 2006 21:39:57 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 21/22] alim15x3: ULI M-1573 south Bridge support
Message-ID: <20060421043957.GU12846@kroah.com>
References: <20060421043353.602539000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alim15x3-uli-m-1573-south-bridge-support.patch"
In-Reply-To: <20060421043706.GA12846@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: KAI.HSU <windsboy@gmail.com>

[PATCH] alim15x3: ULI M-1573 south Bridge support

>From http://bugzilla.kernel.org/show_bug.cgi?id=6358

The alim15x3.c havn't been update for 3 years.  Recently when we use this
"ULI M1573" south bridge chip found that can't mount CDROM(VCD) smoothly,
must waiting for a long time.  After I check the "ULI M1573" south bridge
datasheet, I found the reason.  The reason is the "ULI M1573" version in
the Linux is "0xC7" not "0xC4" anymore So I was modified the source than it
was successed.

Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ide/pci/alim15x3.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.16.9.orig/drivers/ide/pci/alim15x3.c
+++ linux-2.6.16.9/drivers/ide/pci/alim15x3.c
@@ -731,6 +731,8 @@ static unsigned int __devinit ata66_ali1
 	
 	if(m5229_revision <= 0x20)
 		tmpbyte = (tmpbyte & (~0x02)) | 0x01;
+	else if (m5229_revision == 0xc7)
+		tmpbyte |= 0x03;
 	else
 		tmpbyte |= 0x01;
 

--
