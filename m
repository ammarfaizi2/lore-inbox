Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315412AbSFXWti>; Mon, 24 Jun 2002 18:49:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315410AbSFXWth>; Mon, 24 Jun 2002 18:49:37 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:60689 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315406AbSFXWtg>;
	Mon, 24 Jun 2002 18:49:36 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Toni Viemero <toni.viemero@iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Another .text.exit error with 2.4.19-rc1 
In-reply-to: Your message of "Tue, 25 Jun 2002 00:56:19 +0300."
             <20020624215619.GE27147@perplex.selfdestruct.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 25 Jun 2002 08:49:28 +1000
Message-ID: <10787.1024958968@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002 00:56:19 +0300, 
Toni Viemero <toni.viemero@iki.fi> wrote:
>drivers/scsi/scsidrv.o(.data+0x3874): undefined reference to local symbols
>in discarded section .text.exit'
>aq144:/usr/src/linux# perl ../reference_discarded.pl 
>Finding objects, 392 objects, ignoring 0 module(s)
>Finding conglomerates, ignoring 35 conglomerate(s)
>Scanning objects
>Error: ./drivers/scsi/ips.o .data refers to 000000d4 R_386_32
>.text.exit

Untested.

--- drivers/scsi/ips.c	Tue Jun  4 13:34:30 2002
+++ drivers/scsi/ips.c.new	Tue Jun 25 08:48:25 2002
@@ -284,7 +284,7 @@
        name:		ips_hot_plug_name,
        id_table:	ips_pci_table,
        probe:		ips_insert_device,
-       remove:		ips_remove_device,
+       remove:		__devexit_p(ips_remove_device),
    };
 #endif
 

