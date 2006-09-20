Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWITWPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWITWPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 18:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWITWPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 18:15:06 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7314 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932367AbWITWPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 18:15:05 -0400
Subject: Re: Flushing writes to PCI devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 20 Sep 2006 23:39:16 +0100
Message-Id: <1158791956.11109.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-20 am 14:28 -0400, ysgrifennodd Alan Stern:
> I've heard that to insure proper synchronization it's necessary to flush
> MMIO writes (writel, writew, writeb) to PCI devices by reading from the
> same area.  Is this equally true for I/O-space writes (inl, inw, inb)? 

writel/writew/writeb may be posted and delayed until a read from that
device. The outb/outw/outl operations are not posted but are
synchronous.

There may be posting in action both ways (your read may force not only
the write to complete but pending writes the other end). That usually
doesn't matter but very occasionally requires care.

> What about configuration space writes (pci_write_config_dword etc.)?

Usually this is entirely synchronous to PCI bus activity and main
memory. Occasionally chipsets get it slightly wrong
