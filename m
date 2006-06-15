Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWFPAzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWFPAzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 20:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWFPAzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 20:55:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:59095 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750820AbWFPAzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 20:55:44 -0400
Subject: Re: [UBUNTU:acpi/ec] Use semaphore instead of spinlock
From: Arjan van de Ven <arjan@infradead.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Voluspa <lista1@comhem.se>, linux-kernel@vger.kernel.org,
       akpm <akpm@osdl.org>, len.brown@intel.com
In-Reply-To: <4490B48E.5060304@oracle.com>
References: <20060615010850.3d375fa9.lista1@comhem.se>
	 <4490B48E.5060304@oracle.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 17:40:59 +0200
Message-Id: <1150386059.2987.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-14 at 18:14 -0700, Randy Dunlap wrote:
> updated version:
> 
> From: Ben Collins <bcollins@ubuntu.com>
> 
> [UBUNTU:acpi/ec] Use semaphore instead of spinlock to get rid of missed
> interrupts on ACPI EC (embedded controller)


that is odd.

first of all this should use a mutex not a semaphore.

Second, if this isn't used in irq context, then just dropping the
"_irqsave" from the spinlocks should be enough to actually get rid of
the missed interrupts.... and if it is used there then I highly question
your use of semaphores etc...

