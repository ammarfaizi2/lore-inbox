Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267623AbTBLU1l>; Wed, 12 Feb 2003 15:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTBLU1l>; Wed, 12 Feb 2003 15:27:41 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:28288 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267623AbTBLU1j>; Wed, 12 Feb 2003 15:27:39 -0500
From: Andreas Arens <ari@goron.de>
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] AMD IDE oops in current 2.4-ac
Date: Wed, 12 Feb 2003 21:37:10 +0100
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <20030212204815.A8782@www.goron.de> <20030212194912.GA24138@codemonkey.org.uk>
In-Reply-To: <20030212194912.GA24138@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302122137.10500.ari@goron.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 February 2003 20:49, Dave Jones wrote:
>  > Current 2.4.21-pre4-ac kernels oops in amd74xx.c with
>  > certain chipsets due to a table order problem. The
>  > problem is correctly detected by a BUG() in the pci probe
>  > routine, which should trigger for all non-nforce chipsets.
>
> If moving entries in the table caused a bug, adding new entries
> could do the same too perhaps ? This sounds quite fragile
> based on your description & diff.
>
amd74xx_probe() compares the pci device ids of both the
probe table and the settings table, so should be save from
misprogramming.
To protect against using random memory after the end
of the table, a bug check on the table size could help:
        if (dev->device != d->device) BUG();
+      if (sizeof(amd_ide_chips) >= id->driver_data) BUG();
        if (dev->device != amd_config->id) BUG();

Even with this it still looks error prone, especially since
the probe table and the config table are several lines
spread across the file.

Regards
Andy

