Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263555AbUDYV0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263555AbUDYV0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 17:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUDYV0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 17:26:37 -0400
Received: from gherkin.frus.com ([192.158.254.49]:61590 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S263101AbUDYV0f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 17:26:35 -0400
Subject: Re: [PATCH] sym53c500_cs PCMCIA SCSI driver (round 3 - the charm?)
In-Reply-To: <20040425083611.B18033@flint.arm.linux.org.uk> "from Russell King
 at Apr 25, 2004 08:36:11 am"
To: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Sun, 25 Apr 2004 16:26:34 -0500 (CDT)
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040425212634.18513DBDB@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> Hmm, so what happens if you're in the middle of a transaction, and
> you receive a CS_EVENT_CARD_RESET.  What happens to the command in
> progress ?

Candidly, I don't know.  A fair question to ask in return is, under
what circumstances might a PCMCIA driver see a CS_EVENT_CARD_RESET?

None of the existing PCMCIA SCSI drivers I saw do anything other than
reset the hardware: evidently the assumption is there's no command in
progress at that point, or we don't care.  The nsp_cs driver toggles a
stop flag in the per-instance data to indicate the host is accepting
I/O: the flag is set to block I/O upon receipt of a suspend, physical
reset, or card removal event.  The card reset code in the nsp_cs driver,
as in mine, is a subset of (fall-through case for) the resume logic.

Given the above, I'm tempted to believe the mid and/or upper driver
layers are handling the "command in progress" issue, but I haven't
delved into that code deeply enough to know.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
