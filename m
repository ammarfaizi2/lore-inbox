Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263568AbUDYVdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUDYVdt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 17:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbUDYVds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 17:33:48 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56079 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263568AbUDYVdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 17:33:45 -0400
Date: Sun, 25 Apr 2004 22:33:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Bob Tracy <rct@gherkin.frus.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (round 3 - the charm?)
Message-ID: <20040425223341.C13748@flint.arm.linux.org.uk>
Mail-Followup-To: Bob Tracy <rct@gherkin.frus.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040425083611.B18033@flint.arm.linux.org.uk> <20040425212634.18513DBDB@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040425212634.18513DBDB@gherkin.frus.com>; from rct@gherkin.frus.com on Sun, Apr 25, 2004 at 04:26:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2004 at 04:26:34PM -0500, Bob Tracy wrote:
> Russell King wrote:
> > Hmm, so what happens if you're in the middle of a transaction, and
> > you receive a CS_EVENT_CARD_RESET.  What happens to the command in
> > progress ?
> 
> Candidly, I don't know.  A fair question to ask in return is, under
> what circumstances might a PCMCIA driver see a CS_EVENT_CARD_RESET?

When the user issues "cardctl reset"

> None of the existing PCMCIA SCSI drivers I saw do anything other than
> reset the hardware: evidently the assumption is there's no command in
> progress at that point, or we don't care.  The nsp_cs driver toggles a
> stop flag in the per-instance data to indicate the host is accepting
> I/O: the flag is set to block I/O upon receipt of a suspend, physical
> reset, or card removal event.  The card reset code in the nsp_cs driver,
> as in mine, is a subset of (fall-through case for) the resume logic.
> 
> Given the above, I'm tempted to believe the mid and/or upper driver
> layers are handling the "command in progress" issue, but I haven't
> delved into that code deeply enough to know.

>From the brief look I had, it didn't look like it - I suspect things
will go gaga if someone ever invoked "cardctl reset".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
