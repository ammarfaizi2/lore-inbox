Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTJQX3W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 19:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTJQX3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 19:29:06 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:55527 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261235AbTJQX27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 19:28:59 -0400
To: John Bradford <john@grabjohn.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
	<200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
	<33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
	<20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net>
	<3F8BBC08.6030901@namesys.com>
	<11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60>
	<20031017102436.GB10185@bitwizard.nl>
	<200310171049.h9HAnBbO000594@81-2-122-30.bradfords.org.uk>
	<m3zng0yun9.fsf@defiant.pm.waw.pl>
	<200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 18 Oct 2003 01:28:53 +0200
In-Reply-To: <200310171935.h9HJZaLm002335@81-2-122-30.bradfords.org.uk>
Message-ID: <m37k33igui.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

> I said an _additional_ bit.  I am assuming that N-1 reads returned the
> same, (bad), data, which was identified as bad.  Read N encountered
> one too many flipped bits and returned a false positive.  Perfectly
> possible, and arguably more likely than all of the existing incorrect
> bits flipping back, resulting in the correct data being read back, in
> some cases.

In some cases, theoretically, yes. But I've never got anything like that
in practice.

BTW: Hard drives apparently use more sophisticated algorithms,
involving measuring head signal level even when there is no problem
reading the data, and eventually remapping a sector on read before the
information is lost.

> Tell this to the drive manufacturers.  They are the ones who can sell
> you a specialist firmware if you want to do data recovery, not me.

Maybe. But, you know, it's Linux and I don't want to pay for additional
software just to use disks already paid for. Especially when it's all
working fine now.

> Your argument is flawed - how can you claim the current situation is
> sane when at least some drive manufactuers don't publish simple facts
> such as what happens when defective blocks are encountered on reads
> and on writes?

Do you think you can make them publish such things? It would be great.

> If a system got in to a state as extreme as that, I'd generally take
> the hole system down.  Electromagnatic interference that affects one
> drive immediately noticably may well be affecting other components in
> subtle ways - possible _silent_ data corruption in other words.

Possibly. Possibly the machine will immediately freeze. But data on
disk platters will probably be ok, and you'll be able to read it
when the conditions are back in specs.

> Yes.  Or more specifically, I wouldn't trust that data without
> verifying it.  It's easy to ignore such problems and say that
> everything is probably OK, and maybe 99% of the time you would be
> right, but so what?  What about that 1%?

That's not 1% - rather something like 10^-17 or so.
See the specs.
And we have CRCs all over the place - damaged .gnumeric file will
probably fail gunzip stage.
BTW: the probability of silently corrupting, say, (D)RAM contents is
much much higher than that of corrupting HDD data. Even if you use
ECC RAM.

> > Do you really not value your data enough to mark it as inaccessible?
> 
> Not sure what you mean - in what context?

Remapping a sector on read without actually copying the data makes
it inaccessible. Unless you have manufacturer-provided software, of
course, but I haven't seen any.

> Data recovery is always a last resort.  On the other hand, backing up
> data daily can still result in 23 hours of lost data, so I consider
> early detection of faulty disks very important.  Mirroring brings it's
> own problems to consider - more devices to possibly fail, and if they
> are connected to the same controller, a serious fault with any one
> could usually theoretically destroy all of them.

It all depends on requirements. If you need 100% uninterrupted service
you can use mirrored servers, possibly installed in different locations.
This will fix potential problems, while remapping on failed read will
not.
-- 
Krzysztof Halasa, B*FH
