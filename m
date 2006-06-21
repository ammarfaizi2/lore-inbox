Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWFUWEX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWFUWEX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWFUWEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:04:23 -0400
Received: from [81.2.110.250] ([81.2.110.250]:27010 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1030326AbWFUWEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:04:21 -0400
Subject: Re: [PATCH -mm 2/6] cpu_relax(): ide_wait_stat()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060621205942.GB22516@rhlx01.fht-esslingen.de>
References: <20060621205942.GB22516@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 23:19:41 +0100
Message-Id: <1150928381.15275.136.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 22:59 +0200, ysgrifennodd Andreas Mohr:
> Add cpu_relax() to drivers/ide/ide-iops.c/ide_wait_stat().

You don't need cpu_relax() when the loop contains a reference to
external memory busses. The CPU will stall on the inb() anyway, and when
this occurs processors with multiple-threads will do the right thing
implicitly. If you could look at the instruction stream it would look
something like

dec count
jump out if zero
inb
read request to the bus
[stall]
then to the PCI bridge
[stall]
then eventually to the device
[Huge mindbogglingly relativley long period of time stalled]
answer finally arrives back over the PCI bus
compare
...


Same comment for floppy. Rest look ok

Perhaps this needs documenting however.

Alan

