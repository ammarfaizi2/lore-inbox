Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269005AbRHBPQa>; Thu, 2 Aug 2001 11:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269007AbRHBPQU>; Thu, 2 Aug 2001 11:16:20 -0400
Received: from [193.45.212.82] ([193.45.212.82]:4 "EHLO levi.aronsson.se")
	by vger.kernel.org with ESMTP id <S269005AbRHBPQE>;
	Thu, 2 Aug 2001 11:16:04 -0400
Date: Thu, 2 Aug 2001 17:16:40 +0200
Message-Id: <200108021516.f72FGeT00741@levi.aronsson.se>
From: Lars Aronsson <lars@aronsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Subject: Oops in dmi_table() from Linux 2.4.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi guys, it's me again,


My previously reported problem has its roots here:

	Linux 2.4.7
	file arch/i386/kernel/dmi_scan.c
	function dmi_table()
	the if() statement for breaking out of the loop.

What happened on my hardware is that dm->type == 255 (this happens the
very first time these statements are executed), which I guess
indicates that there are no DMI data on my hardware/BIOS.  The type of
dm->type is u8, which means the loop is not broken.  I have no idea
about the DMI specs, so I don't know how other values of dm->type
should be interpreted.  The function dmi_decode() only uses 0,1,2,3.
A simple cast to signed char fixed the problem for me:

	if (((signed char)dm->type) < last) break;

Again, my hardware is a Toshiba Portege 7020CT.  I think I did some
BIOS update when I first installed support for the Dock II docking
station, but I won't care to dig up bios version info unless you say
you need it.

Again, hope you can use this.


Lars Aronsson.
-- 
  Aronsson Datateknik
  Teknikringen 1e              tel +46-70-7891609     lars@aronsson.se
  SE-583 30 Linköping, Sweden  fax +46-13-211820    http://aronsson.se
