Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSBDT1C>; Mon, 4 Feb 2002 14:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSBDT0x>; Mon, 4 Feb 2002 14:26:53 -0500
Received: from 205-158-62-44.outblaze.com ([205.158.62.44]:52446 "EHLO
	mta1-3.us4.outblaze.com") by vger.kernel.org with ESMTP
	id <S286590AbSBDT0o>; Mon, 4 Feb 2002 14:26:44 -0500
Message-ID: <20020204192638.59181.qmail@mail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Thomas Hood" <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 04 Feb 2002 14:26:37 -0500
Subject: Re: modular floppy broken in 2.5.3
X-Originating-Ip: 128.220.212.195
X-Originating-Server: ws1-10.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunther Mayer wrote:
> PNPNIOS is right to reserve PNP0C01 as
> "used". Else there will be hangs when
> drivers poke in io space (e.g. laptops
> tend to have special hardware which
> doesn't like to be touched).
> [...]
> The BIOS probably wants to tell you there
> is a superio chip at 0x3f0

The floppy controller commonly uses io ports
0x3f2-0x3f5 and 0x3f7.  0x3f0-0x3f1 were used
by the floppy controller on the PC AT (only).
The latter two ports are now frequently used
for superio chips or other motherboard
devices, as the BIOS will report.  PnPBIOS
is acting properly in reserving the ports.

Since the floppy driver does not use ioports
0x3f0-0x3f1 it should not reserve them.

The issue was previously discussed in this
thread:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100516032204531&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=100495936122982&w=2
and the conclusion, I believe, was that the
floppy driver should be patched so as not to
reserve 0x3f0 and 0x3f1.  Someone even 
submitted a patch.

> PNPBIOS should not reserve 3f0/3f1
> as a _workaround_ for this BIOS bug.

The correct solution is to modify the floppy
driver.

Until that happens, use the "pnpbios=no-res"
option, which prevents pnpbios from reserving
any ioports.

--
Thomas Hood

-- 

_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Win a ski trip!
http://www.nowcode.com/register.asp?affiliate=1net2phone3a


