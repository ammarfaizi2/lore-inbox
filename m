Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289831AbSAPCpd>; Tue, 15 Jan 2002 21:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289832AbSAPCpW>; Tue, 15 Jan 2002 21:45:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13482 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289831AbSAPCpJ>;
	Tue, 15 Jan 2002 21:45:09 -0500
Date: Tue, 15 Jan 2002 18:43:20 -0800 (PST)
Message-Id: <20020115.184320.101833626.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: davej@suse.de, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3-pre1 compile error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16QfKU-00077u-00@the-village.bc.nu>
In-Reply-To: <20020116013039.A31653@suse.de>
	<E16QfKU-00077u-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Wed, 16 Jan 2002 01:57:30 +0000 (GMT)

   This looks dubious but with the right results.
   
   > -		pmi_base  = (unsigned short*)bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
   > +		pmi_base  = (unsigned short*)isa_bus_to_virt(((unsigned long)screen_info.vesapm_seg << 4) + screen_info.vesapm_off);
   
   The address passed back from the BIOS is a physical address. Not a bus
   address, not an ISA address. phys_to_virt I suspect is genuinely the right
   thing in this unusual case.
   
This slipped thru by accident, it is part of the "kill bus_to_virt"
stuff I'm working on with Jens.  Oops...
