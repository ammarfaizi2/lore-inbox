Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261722AbTJRQ5M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261723AbTJRQ5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:57:12 -0400
Received: from mcomail04.maxtor.com ([134.6.76.13]:52240 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S261722AbTJRQ5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:57:09 -0400
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB2EE@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'John Bradford'" <john@grabjohn.com>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Hans Reiser <reiser@namesys.com>, Wes Janzen <superchkn@sbcglobal.net>,
       linux-kernel@vger.kernel.org
Subject: RE: Blockbusting news, this is important (Re: Why are bad disk se
	ctors numbered strangely, and what happens to them?)
Date: Sat, 18 Oct 2003 10:54:25 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: John Bradford [mailto:john@grabjohn.com]
>
> Drive manufacturers could sell advanced firmware to data recovery
> companies for a price that would pay for itself after 3-4 data
> recovery jobs.  Given that you could then do far more advanced
> recovery then people could themselves, I am suprised this hasn't
> happened before.  Of course, free and open firmware would be nice in
> general, but that hasn't arrived yet.

To pay for itself it would have to cost multiple millions of dollars.  The
#1 constraint in an IDE drive is cost per gigabyte, since 99.9% of
purchasers don't look at anything else.  This means that we strip down
things like our electronics and internal mask ROMs to their minimum required
size.  Specialized code with extra features would inherently be larger,
which gives two choices:

1. burdon 60 million drives per year with the capability to run this
software
2. 1-off or 2-off or whatever for the few times a year that you get asked
for this

#1 is prohibitive from a cost perspective since the demand simply isn't that
high.  #2 is prohibitive because of the engineering and manufacturing
resources required to build a special product.

Plus, all data recovery would be on drives already sold...  Since every
drive optimizes itself as part of the manufacturing process to the exact
capabilities of the channel ASIC, heads they were manufactured with, etc,
the only way for these new recovery tools to work reliably would be to use
option #1 above, which I've already said isn't worth the cost.  I hear about
people swapping PCBs on disk drives to recover data when one fries... yes
this can work to some degree, but I absolutely wouldn't trust anything
written in a swapped-board setup.

The community of knowledgable users who could use such features and would be
willing to pay, say, $20 extra for the cost, is nothing next to the number
of users who go to Dell's website and say "this drive is 20GB more for $10
less, lets get this one!"

> Although, to be honest, except where performance is critical, remap on
> read is pointless.  It saves you from having to identify the bad block
> again when you write to it.  Generally, guaranteed remap on write is
> what I want.  What happens on read is less important if your data
> isn't intact.  I can see your point of view for not re-mapping on read
> given that advanced firmwares are not available, and the fact that it
> allows you to do some form of data recovery.  Overall, though, if it
> gets to the point where you have to start doing such data recovery,
> downtime is usually significant, and for some applications, having the
> data in a week's time may be little more than useless.  Predicting
> possible disk fauliures is a good idea.

Writes are destructive, and very often "fix" the problem on the media.  If
the write succeeds, and can be read by the disk, there's no point in
remapping.  It is only when you're unable to write to a specific area that
remap-on-write makes any sense.

We keep track of where we have trouble reading or writing, and use that to
reassign based on various criteria automatically.

Best data to use, I'd guess, for "predicting" failures, is the blown rev
counter in smart.  If you're blowing revs, you're having trouble getting the
data you want off or onto the drive.

--eric
