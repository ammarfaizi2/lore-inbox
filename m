Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTJ0Jq1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbTJ0Jq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:46:26 -0500
Received: from smtp1.att.ne.jp ([165.76.15.137]:39632 "EHLO smtp1.att.ne.jp")
	by vger.kernel.org with ESMTP id S261486AbTJ0JqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:46:24 -0500
Message-ID: <3cbb01c39c6f$17608410$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Hans Reiser '" <reiser@namesys.com>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, <linux-kernel@vger.kernel.org>,
       <nikita@namesys.com>, "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
References: <785F348679A4D5119A0C009027DE33C105CDB39C@mcoexc04.mlm.maxtor.com>
Subject: Re: Blockbusting news, results end
Date: Mon, 27 Oct 2003 18:45:24 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Mudama wrote:

> If a drive wants to reallocate a block, but due to some temporary
> condition is unable to (vibration, excessive temperature, etc), odds are
> there's no way for that drive to "remember" that it needs to reassign that
> block, so if you reboot the drive or reset it or whatever, you're back at
> square 1.

Bingo.  This is why reallocation at the time of a failed read is also
necessary.  Yes the data are lost, yes the failure needs to be both logged
(once) and displayed to the user (once), yes if an application reads it
again before writing then it will be garbage or zeroes, but get the LBA
sector number moved to a place that is less likely to be unreliable.

Meanwhile software must still make up for defective firmware.

