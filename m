Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269272AbRGaMW7>; Tue, 31 Jul 2001 08:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269275AbRGaMWt>; Tue, 31 Jul 2001 08:22:49 -0400
Received: from foobar.isg.de ([62.96.243.63]:21770 "HELO mail.isg.de")
	by vger.kernel.org with SMTP id <S269272AbRGaMWq>;
	Tue, 31 Jul 2001 08:22:46 -0400
Message-ID: <3B66A318.1E530A35@isg.de>
Date: Tue, 31 Jul 2001 14:22:48 +0200
From: Thomas Mischke <thomas.mischke@isg.de>
Organization: IS Innovative Software AG
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: de-DE, de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Tulip and Interrupt mitigation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

the tulip driver (as of 2.4.7, maybe earlyer versions too) has code in
tulip_interrupt to switch to interrupt mitigation on heavy network load.
The problem is: I have heavy network load, my system (Athlon 900 MHz
with 1 GB) spends 100% of the time in the interrupt, but it does not
switch to mitigation.

If I force the card to mitigation (by changing the code of tulip driver)
I don't loose any packets and get 20% idle time. Great!

I don't use CONFIG_NET_HW_FLOWCONTROL because sometimes my network goes
down for about 5 seconds. This does not happen without
CONFIG_NET_HW_FLOWCONTROL.

The problem seems to be the following: Mitigation is switched on if we
receive (or send) a lot of packets during a single interrupt. But this
never happens. During an interrupt I receive or send about 5 packets, so
no mitigation is started. But the interrupt is called very quickly after
leaving again, seeing another 5 packets and so on.

My tulip cards use 21143 chips.

Thanks in advance,


Thomas Mischke
