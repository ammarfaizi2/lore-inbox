Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWQCb>; Thu, 23 Nov 2000 11:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129434AbQKWQCW>; Thu, 23 Nov 2000 11:02:22 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46356 "EHLO
        the-village.bc.nu") by vger.kernel.org with ESMTP
        id <S129091AbQKWQCF>; Thu, 23 Nov 2000 11:02:05 -0500
Subject: Re: binary garbage in dmesg/boot messages (2.2.18pre23)
To: erbenson@alaska.net (Ethan Benson)
Date: Thu, 23 Nov 2000 15:31:51 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux-Kernel)
In-Reply-To: <20001123054644.A23839@plato.local.lan> from "Ethan Benson" at Nov 23, 2000 05:46:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13yyLo-0007TS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> BIOS Vendor: Intel Corporation
> BIOS Version: 1.00.10.DD04
> BIOS Release: 03/19/97
> System Vendor: Sony Corporation.
> Product Name: PCV-70(U2).
> Version Sony GI.
> Serial Number 1003494.
> Board Vendor: Intel Corporation.
> Board Name: Agate.
> Board Version: AA662195-305.

So far so good

> BIOS Vendor: f.=A3^]<94>fA=E8^D.=A3ESC<94>^N^_

This looks like the table end markers are missing or the length was wrong.
If you change

static int __init dmi_table(u32 base, int len, int num, void (*decode)(struct d
{	 
		char *buf;
	struct dmi_header *dm;   
	u8 *data;
	int i=0;

in arch/i386/kernel/dmi_scan.c to use

	int i=1;

does it then behave nicely ?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
