Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVBAOuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVBAOuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 09:50:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVBAOuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 09:50:13 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:64724 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S262029AbVBAOuA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 09:50:00 -0500
Date: Tue, 1 Feb 2005 15:43:24 +0100 (CET)
To: adobriyan@mail.ru
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <QQhCmClW.1107269004.3606060.khali@localhost>
In-Reply-To: <w2Am1HDp.1107265957.3006340.khali@localhost>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Aurelien Jarno" <aurelien@aurel32.net>, "Greg KH" <greg@kroah.com>,
       "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting myself:

> To me, the only acceptable simplification is
> the initialization of "last_updated" to something which ensures that
> the first update attempt will succeed - providing we actually can do
> that.

On second thought, we obviously cannot, because jiffies wrap, so there is
no single initial value of "last_updated", either relative or
absolute, which can ensure this condition to be true. I think we are
stuck we this "valid" flag, or at least with the concept thereof.
Possibly we can use "last_updated" itself as a flag if we absolutely
want to get rid of "valid". "last_updated == 0" would mean the same
as "valid == 0" did. The probability of "last_updated" to become 0
again after init time is obviously thin, and it wouldn't really hurt if
it did (it would simply allow an extra update to happen). That said,
this makes the code somewhat trickier.

What could (and should) be done anyway is to use time_after() or
something equivalent for the jiffies checks, instead of direct
coparison, in all hardware monitoring drivers.

Thanks,
--
Jean Delvare
