Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135490AbREHVhl>; Tue, 8 May 2001 17:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbREHVhb>; Tue, 8 May 2001 17:37:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62213 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135490AbREHVh0>; Tue, 8 May 2001 17:37:26 -0400
Subject: Re: pci_pool_free from IRQ
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Tue, 8 May 2001 22:39:56 +0100 (BST)
Cc: zaitcev@redhat.com (Pete Zaitcev), david-b@pacbell.net,
        johannes@erdfelt.com, rmk@arm.linux.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <200105082108.f48L8X1154536@saturn.cs.uml.edu> from "Albert D. Cahalan" at May 08, 2001 05:08:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14xFD5-0000hh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This sure makes life difficult. Device removal events can be called
> from interrupt context according to Documentation/pci.txt. This is
> certainly a place where one might want to call pci_consistent_free.

None of our device code supports interrupt based device removal. In fact
many drivers use vmalloc directly so will hit the same problem the
pci_consistent_free hits on the ARM.

I suspect we should fix the documentation (and if need be the code) to reflect
the fact that you have to be completely out of your tree to handle device 
removal in the irq handler
