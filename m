Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262251AbUKKP7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbUKKP7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 10:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUKKP7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 10:59:00 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39891 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262251AbUKKP66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 10:58:58 -0500
Subject: Nasty log spamming problem in ide proc changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       torvalds@osdl.org
In-Reply-To: <200411012006.iA1K6HR7010518@hera.kernel.org>
References: <200411012006.iA1K6HR7010518@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100184927.22254.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 11 Nov 2004 14:55:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-11-01 at 17:18, Linux Kernel Mailing List wrote:
> ChangeSet 1.2424.1.2, 2004/11/01 18:18:35+01:00, bzolnier@trik.(none)
> 
> 	[ide] obsolete /proc/ide/hd?/settings
> 	
> 	Majority of these settings is also available through ioctls.
> 	We will deal with the rest during deprecation period.

Unfortunately while these changes are definitely a good thing.

>  
> +	printk(KERN_WARNING "Warning: /proc/ide/hd?/settings interface is "
> +			    "obsolete, and will be removed soon!\n");
> +

The above should be rate limited or on the write case moved to after
the capable() check. A program polling these settings now makes a nasty
noise and wipes the logs. A user can also do it intentionally.


