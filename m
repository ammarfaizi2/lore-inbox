Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUHDMek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUHDMek (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 08:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUHDMek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 08:34:40 -0400
Received: from reserv6.univ-lille1.fr ([193.49.225.20]:17842 "EHLO
	reserv6.univ-lille1.fr") by vger.kernel.org with ESMTP
	id S261252AbUHDMei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 08:34:38 -0400
Message-ID: <4110D70E.2070706@lifl.fr>
Date: Wed, 04 Aug 2004 14:31:10 +0200
From: Alexandre Courbot <Alexandre.Courbot@lifl.fr>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040701)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug with 2.6 serial driver when in UART 8250 mode
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-USTL-MailScanner-Information: Please contact the ISP for more information
X-USTL-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody,

For communicating with a serial device of ours we need to disable the 
UART buffer (the device at the other end doesn't have a serial buffer at 
all and therefore we can't use hardware control flow efficiently). The 
only way to do this with Linux seems to pass the UART in 8250 mode, 
which doesn't use the buffer:

# setserial /dev/ttyS0 uart 8250

We did that with success with 2.4 kernel series. Since most of our 
machines are using 2.6, we tried to do the same on them, but noticed 
something wrong: only one byte upon 16 is being sent. For instance, if I

$ echo -n "qwertyuiopasdfgh" > /dev/ttyS0

My device only receives the 'h', while with a 2.4 kernel it receives the 
entire string.

So I think that for some reason, the UART buffer is not deactivated 
while switching it to 8250 mode, and that the driver only sends the last 
byte it contains when the interrupt is triggered.

I've tried to look at the code but unfortunately only lost myself 
without being able to even identify the right source file to look at. 
Sorry about that. :/

Could someone have a look at this or point me to the right section of 
code so I do it myself?

Thanks,
Alex.
PS: please CC replies as I'm not subscribed to the list.
-- 
Alexandre Courbot
PhD Student - LIFL/RD2P
http://www.lifl.fr/~courbot/
