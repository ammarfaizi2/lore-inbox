Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbTFYWA7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTFYWA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:00:59 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:38830 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S265093AbTFYWA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:00:56 -0400
Date: Wed, 25 Jun 2003 18:15:06 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Cc: Thijs <thijs@balpol.tudelft.nl>, alan@lxorguk.ukuu.org.uk
Subject: weird postfix mailspool corruption with 2.4.21-ac2+ (was Re: Linux 2.4.21-ac3)
Message-ID: <20030625181506.B9146@newbox.localdomain>
References: <2ltx.Us.17@gated-at.bofh.it> <3EFA0626.3060104@balpol.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EFA0626.3060104@balpol.tudelft.nl>; from thijs@balpol.tudelft.nl on Wed, Jun 25, 2003 at 10:29:26PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thijs on Wed 25/06 22:29 +0200:
> Since 2.4.21-ac2 i'm experiencing problems with Postfix on
> Debian Stable. Messages get corrupted while being handled
> by Postfix.

I thought I was crazy, I'm seeing this also.  I had to
switch my kernel back on our mail hub because postfix kept
doing this every time I boot the new kernel.  I tried to
figure out why but could not; the system *appears* to run
normally otherwise.  I was moving from 2.4.21-pre4-ac1
+gibbs-aic7xxx patches from that time, to 2.4.21-ac2
+gibbs-aic7xxx from 20030603, and I thought that might be it
(the AIC patches); are you running AIC adapters on your
system with the gibbs patches by any chance?

here's what I'm seeing on my mail hub getting a test message
from one of the exchangers:

Jun 24 05:07:54 lujuria postfix/smtpd[997]: connect from mx1.mydomain.tld[1.2.3.4]
Jun 24 05:07:54 lujuria postfix/nqmgr[983]: 7017833812: from=<someone@someother.tld>, size=347, nrcpt=1 (queue active)
Jun 24 05:07:54 lujuria postfix/nqmgr[983]: warning: active/7/0/7017833812: too many length bits, record type 255
Jun 24 05:07:54 lujuria postfix/nqmgr[983]: warning: 7017833812: envelope records out of order
Jun 24 05:07:54 lujuria postfix/nqmgr[983]: warning: saving corrupt file "7017833812" from queue "active" to queue "corrupt"
Jun 24 05:07:54 lujuria postfix/smtpd[997]: A6CF3339AA: client=mx1.mydomain.tld[1.2.3.4]
Jun 24 05:07:54 lujuria postfix/cleanup[991]: A6CF3339AA: message-id=<q$28m4t24a-frqgm---0t-84$dx$z@gq1.5axh>
Jun 24 05:07:54 lujuria postfix/smtpd[997]: disconnect from mx1.mydomain.tld[1.2.3.4]

this is system is RH8+updates with the mentioned kernels.
Very bizarre.

> All other programms seem to work fine, no other strange
> messages whatsoever...

yeah that's the weird part that had me scratching my head as
well.  The other poster said it happens for him on reiserfs,
and I'm on ext3, so that would seem to rule out
filesystems...

hmm looking at -ac2 log, looks like the following might be
possible:

    - Fix AF_UNIX dgram select problem
       + postfix uses lots of these, this sounds like the
         most likely candidate for sure

    - Revert problematic scsi change (fixes ppa/imm)
       + does it touch generic code?

    - Fix data direction for start stop scsi command
       + have no idea what this is

    - Add more unexpected apic filtering
       + I'm on SMP...don't know if this is related??

I don't see how it could be any of the other changes.
