Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVBOUgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVBOUgE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 15:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVBOUcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 15:32:41 -0500
Received: from mail.suse.de ([195.135.220.2]:20654 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261777AbVBOUaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 15:30:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pty is losing bytes
References: <jebramy75q.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I decided to be JOHN TRAVOLTA instead!!
Date: Tue, 15 Feb 2005 21:30:06 +0100
In-Reply-To: <Pine.LNX.4.58.0502151053060.5570@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 15 Feb 2005 11:08:07 -0800 (PST)")
Message-ID: <je1xbhy3ap.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> I think it may be a n_tty line discipline bug, brought on by the fact that
> the PTY buffering is now 4kB rather than 2kB. 4kB is also the
> N_TTY_BUF_SIZE, and if n_tty has some off-by-one error, that would explain 
> it.

I've also seen more than one byte missing.  For example when sending a big
chunk of bytes down the pty via an Emacs *shell* buffer up to 16 bytes are
missing somewhere in the middle.

> Does the problem go away if you change the default value of "chunk" (in 
> drivers/char/tty_io.c:do_tty_write) from 4096 to 2048?

Yes, that helps.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
