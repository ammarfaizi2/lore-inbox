Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbREUUT4>; Mon, 21 May 2001 16:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261684AbREUUTg>; Mon, 21 May 2001 16:19:36 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:11282 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S261682AbREUUTc>; Mon, 21 May 2001 16:19:32 -0400
Date: Mon, 21 May 2001 14:19:07 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile fails an Alpha: include/asm/pci.h included from arch/alpha/kernel/setup.c
Message-ID: <20010521141907.A8950@mail.harddata.com>
In-Reply-To: <20010521171854.A4121@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010521171854.A4121@lug-owl.de>; from jbglaw@lug-owl.de on Mon, May 21, 2001 at 05:18:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2001 at 05:18:55PM +0200, Jan-Benedict Glaw wrote:
> 
> Kernel 2.4.5-pre[34] don't compile on Alpha:
> 
....

>     152         struct pci_controller *hose = pdev->sysdata;
                                                 ^^^

This is the problem (a type for 'pdev' is not defined).
And this is a possible fix:


--- linux-2.4.4ac/include/asm-alpha/pci.h~	Sat May 19 16:43:11 2001
+++ linux-2.4.4ac/include/asm-alpha/pci.h	Sat May 19 17:23:56 2001
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <asm/scatterlist.h>
 #include <asm/machvec.h>
+#include <linux/pci.h>
 
 /*
  * The following structure is used to manage multiple PCI busses.

The patch is for 2.4.4-ac11, so offsets are possibly slightly different,
but probably not. :-)

  Michal
