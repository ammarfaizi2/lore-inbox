Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTJZSdu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 13:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTJZSdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 13:33:49 -0500
Received: from mcomail04.maxtor.com ([134.6.76.13]:65289 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S263394AbTJZSds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 13:33:48 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB39B@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results get worse
Date: Sun, 26 Oct 2003 11:33:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Norman Diamond [mailto:ndiamond@wta.att.ne.jp]
>
> 
> 4.  When writing ZEROES to the bad sector, the drive reports SUCCESS.
> But it lies.  Subsequent attempts to read still fail.  
> Subsequent writing of
> zeroes appears to succeed again.  Subsequent attempts to read 
> still fail.

*That* is the fundamental problem with the drive.  If it knows it has had
trouble with that block in the past, and it gets a new write, it should know
that is a troublesome area and verify that it was able to put the new block
in the old location.

If it can verify that, then there's no need to reallocate it at all, since
the write most likely cured whatever was wrong.

If it can't verify it, then it should need to reallocate and verify at the
new location.

> They said that they warranty Toshiba disk drives for 1 year.  So
> if a customer buys a Toshiba disk drive with firmware that 
> was defective on the day of purchase and defective on the dates
> of design and manufacture, but if the customer doesn't detect
> the defective firmware until 366 days later, the customer still
> gets shafted.

In theory, I don't see the problem with this.

It isn't realistic for a vendor to warranty a product forever, and this is
why OEMs do large qualifications on drives themselves before they purchase a
single unit, since they know they'll bear the brunt of the support headache
if the product fails.

That being said, there are three options:

1. Pay a premium for longer warranty.  I know this is available in both IDE
and SCSI, not sure if it is available in notebook drives.

2. Do qualification tests yourself during the first year of operation.
Hi/low temperature/humidity/air pressure, random command generator, and make
sure the drive never miscompares or has a hard error it can't "fix".
(Writing a zero and reading non-zero is a miscompare)

3. Look at what products are being shipped in large volume from OEMs, and
buy the same product yourself.  Dell or HP or IBM can't afford to ship
products that don't have the lowest in-the-field failure rates, so buying
what they buy would make sense since they'll run their own tests like #2.


--eric
