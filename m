Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUCVPRS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 10:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUCVPRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 10:17:18 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:48047 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262041AbUCVPRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 10:17:16 -0500
Date: Mon, 22 Mar 2004 16:17:12 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jens Axboe <axboe@suse.de>
Cc: Heikki Tuuri <Heikki.Tuuri@innodb.com>, linux-kernel@vger.kernel.org
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040322151712.GB32519@merlin.emma.line.org>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Heikki Tuuri <Heikki.Tuuri@innodb.com>, linux-kernel@vger.kernel.org
References: <023001c4100e$c550cd10$155110ac@hebis> <20040322132307.GP1481@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040322132307.GP1481@suse.de>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe schrieb am 2004-03-22:

> There's no such thing as atomic writes bigger than a sector really, we
> just pretend there is. Timing usually makes this true.

If there is no such atomicity (except maybe in ext3fs data=journal or
the upcoming reiserfs4 - isn't there?), then nobody should claim so. If
the kernel cannot 100.00000000% guarantee the write is atomic, claiming
otherwise is plain fraud and nothing else.

Some people bet their whole business/company and hence a fair deal of
their belongings on a single data base, and making them believe facts
that simply aren't reality is dangerous. These people will have very
little understanding for sloppiness here. Linux has no obligation to be
fast or reliable, but it MUST PROPERLY AND TRUTHFULLY state what it can
guarantee and what it cannot guarantee.

> For bigger atomic writes, 2.4 SUSE kernel had some nasty hack (called
> blk-atomic) to prevent reordering by the io scheduler to avoid partial
> blocks from databases.

That does not make a write atomic if the scheduled blocks are still
written one at a time (and I believe tagged command queueing won't help
to unroll partial writes either).

If the hardware support is missing, it is prudent to say just that and
not make any bogus promises about platter inertia and "it usually
works". (who says that the filter curves adjust to the decreasing
platter speed and the electronics are sustained for long enough? how
about write verify and remapping broken blocks?)

So we only write one hardware block size atomically, usually 512 bytes
on ATA and SCSI disk drives (MO might do 2048 at a time, but why
introduce complexity).  That's a data point in this whole fsync()
discussion.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
