Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289823AbSAPBps>; Tue, 15 Jan 2002 20:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290336AbSAPBpj>; Tue, 15 Jan 2002 20:45:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:14346 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289823AbSAPBpd>; Tue, 15 Jan 2002 20:45:33 -0500
Subject: Re: 2.5.3-pre1 compile error
To: davej@suse.de (Dave Jones)
Date: Wed, 16 Jan 2002 01:57:30 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <20020116013039.A31653@suse.de> from "Dave Jones" at Jan 16, 2002 01:30:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16QfKU-00077u-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another weirdo. Where did this come from ??

This looks dubious but with the right results.

> -		pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
> +		pmi_base  = (unsigned short*)isa_bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);

The address passed back from the BIOS is a physical address. Not a bus
address, not an ISA address. phys_to_virt I suspect is genuinely the right
thing in this unusual case.

