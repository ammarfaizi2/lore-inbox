Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWGZTZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWGZTZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 15:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWGZTZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 15:25:18 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:274 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751766AbWGZTZR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 15:25:17 -0400
Date: Wed, 26 Jul 2006 21:25:27 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI bus is hidden behind transparent bridge
Message-Id: <20060726212527.5c9f4253.khali@linux-fr.org>
In-Reply-To: <20060725220832.GA8214@phoenix>
References: <20060725215639.GB8113@phoenix>
	<20060725220832.GA8214@phoenix>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> Since I upgraded my kernel back around 2.6.16, I stopped seeing my SMBus
> adapter on the PCI bus, and thus could not get readings from the LM90
> sensor chip on my laptop.  After trying the pci=assign-busses parameter,
> the error messages about transparent busses go away, but I still can't
> access the SMBus controller (it uses the i2c-i801 module, in case that
> helps).

Caused by this change:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=ce007ea59729d627f62bb5fa8c1a81e25653a0ad

Long story short, the quirk unhiding the Intel 82801 SMBus can cause
major trouble on resume. Thus it was disabled when suspend support is
included in the kernel. You have to disable ACPI sleep states if you
want it back.

-- 
Jean Delvare
