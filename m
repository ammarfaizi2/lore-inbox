Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVBAL5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVBAL5H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 06:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVBAL5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 06:57:07 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:18907 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261996AbVBAL5D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 06:57:03 -0500
Date: Tue, 1 Feb 2005 12:49:20 +0100 (CET)
To: adobriyan@mail.ru, aurelien@aurel32.net
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <VJ70nUPw.1107258560.0805790.khali@localhost>
In-Reply-To: <200502011420.17466.adobriyan@mail.ru>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Greg KH" <greg@kroah.com>, "LKML" <linux-kernel@vger.kernel.org>,
       "LM Sensors" <sensors@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

> Maybe you should call sis5595_update_device() in initialization function
> and get rid of "value" field. It's sole purpose to fill "struct sis5595"
> when it's known that "last_updated" field contains crap.

I assume you meant "valid" field.

Doesn't work. If you discard the "valid" field and call the update
function at init time, you cannot be sure that the update function will
actually do something. It all depends on the jiffies value relative to
last_updated (0 at this point). This is exactly what "valid" is there
for.

An alternative is to add a parameter to the update function, that would
force the update to happen regardless of time consideration. This
doesn't really change anything though, you simply remove a structure
member and replace it with a function parameter. How does it help?

Third possibility would be to initialize "last_updated" to anything
less than jiffies-(HZ+HZ/2) at init time, so as to be sure that the next
update will occur. Is it doable? Or maybe if we initialize
"last_updated" to the max possible jiffies count, it'll have the same
effect. But is it doable?

At any rate, the exact same issue exists in every over existing hardware
monitoring driver. If we change our mind we'll do it for all drivers,
not only this new one (sis5595), so Aurelien's patch is fine with me.

Thanks,
--
Jean Delvare
