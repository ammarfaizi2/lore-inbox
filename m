Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262835AbSJWEqK>; Wed, 23 Oct 2002 00:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSJWEqK>; Wed, 23 Oct 2002 00:46:10 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.131]:49621 "EHLO
	moutvdom.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262835AbSJWEqK>; Wed, 23 Oct 2002 00:46:10 -0400
Date: Wed, 23 Oct 2002 06:51:50 +0200 (MEST)
From: Armin Schindler <mac@melware.de>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: module_init in interrupt context ?
In-Reply-To: <20021022220737.GA32539@debill.org>
Message-ID: <Pine.LNX.4.31.0210230640250.6294-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.4.19 I noticed that calls from module_init()
may be done in interrupt context. I didn't have a problem here
before 2.4.17.

E.g. in module_init() I use pci_module_init() for my driver
(I don't have HOTPLUG enabled), the when the .probe function is called
and the card is detected I create a proc entry for this new
found device, but most of the time create_proc_entry causes
BUG(), because it is called from interrupt context.

What and where is the reason for that ?
Shall the pci_module function be interrupt-save, or
all functions called from module_init() ?

Thanks,
Armin


