Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292937AbSCDWRk>; Mon, 4 Mar 2002 17:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292938AbSCDWRb>; Mon, 4 Mar 2002 17:17:31 -0500
Received: from 64-166-72-137.ayrnetworks.com ([64.166.72.137]:17024 "EHLO 
	ayrnetworks.com") by vger.kernel.org with ESMTP id <S292937AbSCDWRM>;
	Mon, 4 Mar 2002 17:17:12 -0500
Date: Mon, 4 Mar 2002 14:17:10 -0800
From: William Jhun <wjhun@ayrnetworks.com>
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ide_free_irq()
Message-ID: <20020304141709.C1247@ayrnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple patch. The current drivers/ide/ide.c calls free_irq() instead of
ide_free_irq(). We depend on these alternate routines to deal with our
semi-broken hardware, but since ide-probe.c calls ide_reqest_irq(), it
seems logical that this should also be ide_free_irq().

Thanks,
Will Jhun

*** drivers/ide/ide.c.orig	Mon Feb 25 11:37:57 2002
--- drivers/ide/ide.c	Mon Mar  4 14:05:41 2002
***************
*** 2115,2121 ****
  		g = g->next;
  	} while (g != hwgroup->hwif);
  	if (irq_count == 1)
! 		free_irq(hwif->irq, hwgroup);
  
  	/*
  	 * Note that we only release the standard ports,
--- 2115,2121 ----
  		g = g->next;
  	} while (g != hwgroup->hwif);
  	if (irq_count == 1)
! 		ide_free_irq(hwif->irq, hwgroup);
  
  	/*
  	 * Note that we only release the standard ports,
