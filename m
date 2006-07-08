Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWGHRTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWGHRTI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 13:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWGHRTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 13:19:08 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:26828 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964901AbWGHRTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 13:19:07 -0400
Subject: Re: pcmcia IDE broken in 2.6.18-rc1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060708145541.GA2079@elf.ucw.cz>
References: <20060708145541.GA2079@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 08 Jul 2006 18:36:39 +0100
Message-Id: <1152380199.27368.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-08 am 16:55 +0200, ysgrifennodd Pavel Machek:
> ide2: I/O resource 0xF887E00E-0xF887E00E not free.
> ide2: ports already in use, skipping probe
> ide2: I/O resource 0xF887E01E-0xF887E01E not free.
> ide2: ports already in use, skipping probe


Looks like ioremap values not I/O ports. Probably the various IDE layer
changes from 2.6.17-mm.

My first guess would be the PCMCIA layer changes to use mmio ports are
not setting hwif->mmio (I think its ->mmio) to 2 and doing their own
resource management.

Alan

