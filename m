Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUI2AsU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUI2AsU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 20:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268121AbUI2Aqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 20:46:55 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:4233 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268119AbUI2Aqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 20:46:35 -0400
Subject: Re: IDE Hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: Suresh Grandhi <Sureshg@ami.com>,
       "'linux-ide@vger.kernel.org'" <linux-ide@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <200409282338.10456.bzolnier@elka.pw.edu.pl>
References: <8CCBDD5583C50E4196F012E79439B45C069657DB@atl-ms1.megatrends.com>
	 <200409282338.10456.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096407955.14083.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 28 Sep 2004 22:45:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-09-28 at 22:38, Bartlomiej Zolnierkiewicz wrote:
> No and such workaround won't work anyway because
> re-register operation is nothing else but unregister+register.

If you grab the 2.6.8.1-ac patch you can do IDE controller hotplugging
and a few other things but not yet drive hotplugging. 2.4 can do drive
hotplug although you need a small -ac patch if you see wrong disk
geometry data.

For new controllers (ie SATA ones) use Jeff Garzik's serial ATA layer as
that is a lot cleaner and the SCSI layer already has a good basic
understanding of hotplug management.

> Any help/support is appreciated.

Except for the dynamic stuff I consider the problem solved. Its up to
you when and what you merge and I understand why you want to get stuff
like sysfs there. 

For drive level hotplug its actually a lot easier and I guess that is
the case most users care about. The changes done for 2.6 clean up stuff
like suspend mean the nasties in 2.4 for sequencing have gone away. No
refcounting needed since the block and fs layer are doing it all for
you. TTY layer, revoke(), and some other current critical bonfires first
before I can help with that however.

Alan

