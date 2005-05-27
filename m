Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262657AbVE0XLi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbVE0XLi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 19:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262655AbVE0XLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 19:11:37 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:8126 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262646AbVE0XLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 19:11:34 -0400
Subject: Re: [PATCH] fix ide-scsi EH locking
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <42978EF1.5000703@pobox.com>
References: <42978EF1.5000703@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1117235334.29624.251.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 28 May 2005 00:09:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-05-27 at 22:19, Jeff Garzik wrote:
> Patch untested, but at least the code isn't obviously wrong now...

The abort code check of cmd->serial_number is the only thing I can see
that needs care and that looks safe by the time we hit eh_abort because
the mid level has quiesced the request queue.

eh_reset is whacking on requests but they are the IDE layer requests so
I suspect you want to simply drop the scsi locks for the eh functions
much earlier and use spin_lock_irqsave/restore on the ide lock ?

