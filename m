Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267000AbRGIJns>; Mon, 9 Jul 2001 05:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266999AbRGIJni>; Mon, 9 Jul 2001 05:43:38 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:22540 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S267000AbRGIJnY>;
	Mon, 9 Jul 2001 05:43:24 -0400
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
In-Reply-To: <m15JCAJ-000P07C@amadeus.home.nl>
In-Reply-To: <m15JCAJ-000P07C@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15JXZa-0001YZ-00@come.alcove-fr>
From: Stelian Pop <stelian@alcove.fr>
Date: Mon, 09 Jul 2001 11:43:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In alcove.lists.linux.kernel, you wrote:
> 
> > I guess this'll still pickup Sony desktops.
> > Perhaps we need a survey of lspci -nv results for sony and non-sony
> > machines ?
> 
> The DMI table might be bettur up to this job instead...

Is seems so, my DMI tables contain some strings that we could
use to trigger up this laptop recognision (obtained after enabling
dmi_printk in the source):
	DMI table at 0x000DC010.
	BIOS Vendor: Phoenix Technologies LTD
	BIOS Version: R0204P1
	BIOS Release: 09/12/00
	System Vendor: Sony Corporation    .
	Product Name: PCG-C1VE(FR)        .
	Version 01                  .
	Serial Number 28316054-5120966    .
	Board Vendor: Sony Corporation    .
	Board Name: PCG-C1VE(FR)        .

But it doesn't seem to me like the dmi routines (arch/i386/kernel/dmi_scan.c)
were designed to be used from outside this scope.

I could implement this in two different ways:
	- add a callback in this file which will initialise
	  a global var we could test in the driver.

	or

	- export the dmi_ident tab and maybe some check routines/macros
	  to the rest of the kernel, giving each driver the possibility
	  to access this info.

What does the audience think ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
