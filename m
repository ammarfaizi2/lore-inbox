Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWGKXXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWGKXXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 19:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWGKXX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 19:23:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51378 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932237AbWGKXXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 19:23:11 -0400
Date: Tue, 11 Jul 2006 16:23:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: bunk@stusta.de, alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1: drivers/ide/pci/jmicron.c warning
Message-Id: <20060711162328.6a771ce2.akpm@osdl.org>
In-Reply-To: <20060711231014.GA30186@devserv.devel.redhat.com>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<20060711125258.GN13938@stusta.de>
	<20060711140257.GA6820@devserv.devel.redhat.com>
	<20060711221045.GC13938@stusta.de>
	<20060711231014.GA30186@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@redhat.com> wrote:
>
> I'd say that gcc warning in the case that all the enum values are enumerated
> and have returns is a broken warning irrespective of that so I won't "fix" it
> because it isn't broken. Its just like various other bogus gcc warnings
> 

But we work around gcc problems all the time.

Warnings like this have a cost - they make the build noisy and that causes
people to miss real bugs which the compiler is trying to tell them about.

So if we can implement a low-cost fix for this then we should do so.


--- a/drivers/ide/pci/jmicron.c~a
+++ a/drivers/ide/pci/jmicron.c
@@ -94,8 +94,9 @@ static int __devinit ata66_jmicron(ide_h
 			return 0;
 		return 1;
 	case PORT_SATA:
-		return 1;
+		break;
 	}
+	return 1; /* Avoid bogus "control reaches end of non-void function" */
 }
 
 static void jmicron_tuneproc (ide_drive_t *drive, byte mode_wanted)
_

