Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVCUTOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVCUTOK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 14:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVCUTOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 14:14:09 -0500
Received: from isilmar.linta.de ([213.239.214.66]:45262 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261745AbVCUTNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 14:13:55 -0500
Date: Mon, 21 Mar 2005 20:13:53 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Norbert Preining <preining@logic.at>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] pcmcia: select crc32 in Kconfig for PCMCIA [Was: Re: pcmcia compile problems in 2.6.11-mm4 and above]
Message-ID: <20050321191353.GA13659@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Norbert Preining <preining@logic.at>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050321150143.GB14614@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321150143.GB14614@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 04:01:43PM +0100, Norbert Preining wrote:
> HI Andrew!
> 
> Compiling 2.6.12-rc1-mm1 with the attached config gives me an error
> while compiling pcmcia (I made a make oldconfig)
> drivers/built-in.o(.text+0xaf2a2): In function `pcmcia_check_driver':
> : undefined reference to `crc32_le'
> drivers/built-in.o(.text+0xafef1): In function `pcmcia_bus_hotplug':
> : undefined reference to `crc32_le'
> 
> compiling pcmcia modular works.

That's a missing dependency on CONFIG_CRC32. Could you check whether this
patch helps, please?


PCMCIA needs CRC32.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Index: linux-2.6.12-rc1/drivers/pcmcia/Kconfig
===================================================================
--- linux-2.6.12-rc1.orig/drivers/pcmcia/Kconfig	2005-03-21 20:07:42.000000000 +0100
+++ linux-2.6.12-rc1/drivers/pcmcia/Kconfig	2005-03-21 20:12:00.000000000 +0100
@@ -42,6 +42,7 @@
 
 config PCMCIA
 	tristate "16-bit PCMCIA support"
+	select CRC32
 	default y
 	---help---
 	   This option enables support for 16-bit PCMCIA cards. Most older
