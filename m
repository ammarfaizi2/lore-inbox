Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTK3QC0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 11:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTK3QC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 11:02:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26288 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264928AbTK3QCW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 11:02:22 -0500
Message-ID: <3FCA147F.4040503@pobox.com>
Date: Sun, 30 Nov 2003 11:02:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: libata and pm
References: <3FC9CBB8.7020108@gmx.de>
In-Reply-To: <3FC9CBB8.7020108@gmx.de>
Content-Type: multipart/mixed;
 boundary="------------000704040501010009020803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000704040501010009020803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Prakash K. Cheemplavam wrote:
> Hi,
> 
> I wonder whether libata can easily be made compatible with swsup or pmdisk.
> 
> Currently my tries stop with the message:
> 
> PM: Preparing system for suspend
> Stopping tasks: 
> =================================================exiting...========
>  stopping tasks failed (1 tasks remaining)
> Restarting tasks...<6> Strange, katad-1 not stopped
>  done
> 
> 
> I think that katad belongs to libata.

I'm curious if this [completely untested] patch works?  :)

	Jeff



--------------000704040501010009020803
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== drivers/scsi/libata-core.c 1.7 vs edited =====
--- 1.7/drivers/scsi/libata-core.c	Mon Nov 24 11:19:30 2003
+++ edited/drivers/scsi/libata-core.c	Sun Nov 30 11:01:26 2003
@@ -2567,6 +2567,9 @@
 
 		timeout = ata_thread_iter(ap);
 
+		if (current->flags & PF_FREEZE)
+			refrigerator(PF_IOTHREAD);
+
                 if (signal_pending (current))
                         flush_signals(current);
 

--------------000704040501010009020803--

