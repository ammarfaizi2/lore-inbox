Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbULRDDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbULRDDx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 22:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbULRDDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 22:03:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5586 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262832AbULRDCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 22:02:35 -0500
Date: Sat, 18 Dec 2004 03:02:33 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: James Nelson <james4765@verizon.net>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [KJ] [PATCH] generic_serial: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
Message-ID: <20041218030233.GV7113@parcelfarce.linux.theplanet.co.uk>
References: <20041218002600.19176.34205.85406@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041218002600.19176.34205.85406@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 06:25:39PM -0600, James Nelson wrote:
>  
> +static spinlock_t driver_lock = SPIN_LOCK_UNLOCKED;
> +

It can't be static.  The drivers are going to have to use it in their
interrupt routines to synchronise with the generic_serial code.

It'd be much better to convert the drivers that use generic_serial
to use serial_core instead.  I'd recommend not touching this unless you
have the hardware concerned.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
