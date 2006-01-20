Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750992AbWATOFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbWATOFs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbWATOFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:05:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41374 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750991AbWATOFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:05:47 -0500
Date: Fri, 20 Jan 2006 09:05:32 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc1-mm2
Message-ID: <20060120140532.GC22184@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060120031555.7b6d65b7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060120031555.7b6d65b7.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 03:15:55AM -0800, Andrew Morton wrote:

 > - drivers/i2c/busses/scx200_acb.c doesn't compile on architectures which
 >   don't have asm/msr.h.

It shouldn't be offered on other arches, it's an arch specific driver.
Make it behave like the other SCx200 bits in that dir, and hide away
from non-x86.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6/drivers/i2c/busses/Kconfig~	2006-01-20 09:03:47.000000000 -0500
+++ linux-2.6/drivers/i2c/busses/Kconfig	2006-01-20 09:04:39.000000000 -0500
@@ -389,7 +389,7 @@ config SCx200_I2C_SDA
 
 config SCx200_ACB
 	tristate "NatSemi SCx200 ACCESS.bus"
-	depends on I2C && PCI
+	depends on SCx200 && I2C && PCI
 	help
 	  Enable the use of the ACCESS.bus controllers of a SCx200 processor.
 
