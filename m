Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWAPW46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWAPW46 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 17:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWAPW46
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 17:56:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8915 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751250AbWAPW45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 17:56:57 -0500
Subject: Re: [PATCH 1/4] SATA ACPI build (applies to 2.6.16-git9)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Erik Mouw <erik@harddisk-recovery.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       jgarzik <jgarzik@pobox.com>
In-Reply-To: <20060116224626.GS3945@suse.de>
References: <20060113224252.38d8890f.rdunlap@xenotime.net>
	 <20060116115607.GA18307@harddisk-recovery.nl>
	 <20060116140713.GB18307@harddisk-recovery.com>
	 <20060116224626.GS3945@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 16 Jan 2006 23:00:36 +0000
Message-Id: <1137452436.15553.93.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-01-16 at 23:46 +0100, Jens Axboe wrote:
> > If you really need this enabled to be able to use suspend/resume at
> > all, you could add a line like:
> > 
> >   It's safe to say Y. If you say N, you might get serious disk
> >   corruption when you suspend your machine.
> 
> That's simply not true. If you say N (if you could), you could risk
> having a non-responsive disk after resume. However, it would have been
> synced a suspend time so you wont corrupt anything.

If you do not execute the ACPI taskfiles for the device and you are
doing an ACPI suspend you are in completely undefined space. Whether it
eats your disk or not is a question of probabilities only. Yes its
unlikely but you are in undefined space so "won't corrupt anything"
indicates an inappropriate level of certainty.

Fortunately it is better than the old PATA layer where as far as I can
tell if the BIOS resume restores the BIOS HPA setup you may actually end
up doing more damage by running ACPI taskfiles as we don't appear to
restore enough drive state.

Alan


