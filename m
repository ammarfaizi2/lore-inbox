Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTJ0Ruq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 12:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263454AbTJ0Rup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 12:50:45 -0500
Received: from mcomail03.maxtor.com ([134.6.76.14]:5646 "EHLO
	mcomail03.maxtor.com") by vger.kernel.org with ESMTP
	id S263452AbTJ0Ruo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 12:50:44 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB3B1@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: RE: Blockbusting news, results end
Date: Mon, 27 Oct 2003 10:50:43 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>-----Original Message-----
>> If a drive wants to reallocate a block, but due to some temporary
>> condition is unable to (vibration, excessive temperature, 
>> etc), odds are there's no way for that drive to "remember" that
>> it needs to reassign that block, so if you reboot the drive or
>> reset it or whatever, you're back at square 1.
> 
> Bingo.  This is why reallocation at the time of a failed read is also
> necessary.  Yes the data are lost, yes the failure needs to 
> be both logged (once) and displayed to the user (once), yes if an 
> application reads it again before writing then it will be garbage
> or zeroes, but get the LBA sector number moved to a place that is
> less likely to be unreliable.
> 
> Meanwhile software must still make up for defective firmware.
> 

Reallocating on a failed read doesn't always make sense.  Some huge
percentage of the errors on the media are caused by poor writes due to
various transient conditions (temperature, shock events, etc), and are not
actual media defects that prevent writing there in the future.  If we get an
ECC error, the only thing we can "reallocate" is the stuff with the error in
it, in which case you're no closer to getting a good block of data than you
were prior to the reallocation.

If you try to write to that LBA, it should detect that you're writing to a
marginal area, and do some amount of tests to make sure that the new write
can be read.

Also, your term "defective firmware" is getting annoying.  What, exactly,
should a drive that knows it cannot access the media due to severe
environmental conditions do in firmware to remember its problems between
power cycles?

--eric
