Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273479AbRIQFBq>; Mon, 17 Sep 2001 01:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273480AbRIQFBh>; Mon, 17 Sep 2001 01:01:37 -0400
Received: from host194.steeleye.com ([216.33.1.194]:30981 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S273479AbRIQFBc>; Mon, 17 Sep 2001 01:01:32 -0400
Message-Id: <200109170501.f8H51mv04975@localhost.localdomain>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Tom Rini <trini@kernel.crashing.org>
cc: Keith Owens <kaos@ocs.com.au>, James.Bottomley@HansenPartnership.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10-pre10 
In-Reply-To: Message from Tom Rini <trini@kernel.crashing.org> 
   of "Sun, 16 Sep 2001 21:03:14 PDT." <20010916210314.C14279@cpe-24-221-152-185.az.sprintbbd.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Sep 2001 00:01:48 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trini@kernel.crashing.org said:
> Well, I guess my question is, is this arch-specific or driver
> specific? The lasi700 driver is hppa-only.  The NCR_D700 doesn't have
> any restrictions. James? 

Well, the original intent was to separate the chip core logic from the actual 
board driver.  To that end, I needed two cores, one which was io mapped and 
one which was mem mapped.  In theory, set up the way it is, I can keep 
architectural dependencies out of the chip core (53c700.c).  The two file 
strategy was the only way I could think to do this.

lasi700 is completely parisc specific.  NCR_D700 is and x86 microchannel card.

Actually, the way you're suggesting will work with some modifications:  All I 
have to do in Config.in is require the lasi700 and the NCR_D700 to do a 
define_bool CONFIG_53C700_MEM_MAPPED y and define_bool CONFIG_53C700_IO_MAPPED 
y respectively when they're selected and insist that one or other of these 
flags be present in the core driver before it will compile.

I've got a big sync to do with the work I've been doing on the parisc driver, 
so I'll put that in too.

James


