Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbULREPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbULREPu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 23:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbULREPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 23:15:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29653 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262833AbULREPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 23:15:45 -0500
Date: Sat, 18 Dec 2004 04:15:43 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: James Nelson <james4765@verizon.net>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [KJ] [PATCH] lcd: replace cli()/sti() with spin_lock_irqsave()/spin_unlock_irqrestore()
Message-ID: <20041218041543.GW7113@parcelfarce.linux.theplanet.co.uk>
References: <20041217235927.17998.75228.61750@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041217235927.17998.75228.61750@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 05:59:05PM -0600, James Nelson wrote:
> Remove the cli()/sti() calls in drivers/char/lcd.c

I'm not sure why anyone would bother ...

config COBALT_LCD
        bool "Support for Cobalt LCD"
        depends on MIPS_COBALT

those machines are never SMP.

However, looking at the driver, it doesn't seem to generate interrupts,
so I don't see what good disabling interrupts would do.  I think we can
simply remove the save_flags/cli/restore_flags from this driver.  It needs
a fair chunk of work though -- should be converted to use writeb instead of

                                        *((volatile unsigned char *)
                                          burn_addr) =
                 (volatile unsigned char) rom[index];

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
