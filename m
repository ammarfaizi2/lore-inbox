Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268392AbUI2Nc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268392AbUI2Nc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268407AbUI2Nc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:32:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16911 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S268392AbUI2NcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:32:06 -0400
Date: Wed, 29 Sep 2004 14:31:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>,
       "Feldman, Scott" <scott.feldman@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
Message-ID: <20040929143159.A16537@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Fulghum <paulkf@microgate.com>,
	"Feldman, Scott" <scott.feldman@intel.com>,
	"Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF6375@orsmsx402.amr.corp.intel.com> <1096427180.6003.49.camel@at2.pipehead.org> <1096460004.15905.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096460004.15905.9.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 29, 2004 at 01:13:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 01:13:26PM +0100, Alan Cox wrote:
> We have a fundamental API design problem going back to
> day one. The API IMHO should really be
> 
> 	struct irq *irq;
> 	irq = allocate_irq(5, ...)
> 	enable_irq(irq);
> 
> That would fix
> - Drivers failing to load/init under freak low memory situations
> - How to cleanly report irqs (because each irq can now have ->name)
> - How to tell which shared irq users are disabled/enabled for the irq
>   poll/recovery code I posted (and is testing in -mm).
> 
> Unfortunately it would require changes to rather a lot of code.

I suggested something like this a while back on the linux-arch list
but it didn't particularly have a good reception from the other
arch maintainers.  If there's interest in it, I could dig it out.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
