Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUHJJtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUHJJtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUHJJtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:49:05 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:14227 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S263778AbUHJJsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:48:11 -0400
Date: Tue, 10 Aug 2004 11:48:11 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040810094811.GI10361@merlin.emma.line.org>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
	schilling@fokus.fraunhofer.de, axboe@suse.de
References: <1092082920.5761.266.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092082920.5761.266.camel@cube>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Aug 2004, Albert Cahalan wrote:

> Shall we rip the printk() calls out of the kernel? Many
> of them are weird. They might confuse the end users.
> 
> Joerg:
>    "WARNING: Cannot do mlockall(2).\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to lock memory.\n"
>    "         If the computer is not idle, the CD may be ruined.\n"
> 
> Joerg:
>    "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
>    "WARNING: This causes a high risk for buffer underruns.\n"
> Fixed:
>    "Warning: You don't have permission to hog the CPU.\n"

"hog" certainly is not the right word here, but let's not discuss
application warnings on word level here.

>    "         If the computer is not idle, the CD may be ruined.\n"

The warning still needs to contain a technical information that the end
user can report to the support or maintainer. Jörg's warning isn't all
too bad only the user may not know what a buffer underrun actually
means, so another line of explanation, a recommendation to retry with
increased (root) privileges and preferably another 10 s delay would iron
this out.

Note that while the burn-proof/just-link feature allows the drive to
pick up writing but it comes at a price, a few dozen pits/lands are
hosed for every time this feature gets used, so it's best to avoid
interrupting the write stream.

One of Jörg's goals appears to let his application do the best possible
job without such micro gaps, and that deserves all support he can get.

That the DMA, ide-scsi, interfaces and naming issues can't be settled is
sad and it appears as though the naming and it seems these issues cannot
be discussed separately for some reason.

-- 
Matthias Andree

NOTE YOU WILL NOT RECEIVE MY MAIL IF YOU'RE USING SPF!
Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
