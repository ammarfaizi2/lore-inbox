Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262710AbVCDKkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbVCDKkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 05:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVCDKkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 05:40:52 -0500
Received: from smail4.alcatel.fr ([64.208.49.167]:56994 "EHLO
	smail4.alcatel.fr") by vger.kernel.org with ESMTP id S262710AbVCDKkM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 05:40:12 -0500
Message-ID: <42283AE5.9030700@linux-fr.org>
Date: Fri, 04 Mar 2005 11:39:33 +0100
From: Jean Delvare <khali@linux-fr.org>
User-Agent: Mozilla/5.0 (X11; U; SunOS sun4u; en-US; rv:1.8a5) Gecko/20041222
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?=22Fr=E9d=E9ric_L=2E_W=2E_Meunier=22?= 
	<2@pervalidus.net>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, khali@linux-fr.org
Subject: Re: radeonfb blanks my monitor
References: <Pine.LNX.4.62.0503022347070.311@darkstar.example.net>  <1109823010.5610.161.camel@gaston>  <Pine.LNX.4.62.0503030134200.311@darkstar.example.net> <1109825452.5611.163.camel@gaston> <Pine.LNX.4.62.0503031149280.311@darkstar.example.net>
In-Reply-To: <Pine.LNX.4.62.0503031149280.311@darkstar.example.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Alcanet-MTA-scanned-and-authorized: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frédéric, hi Benjamin,

> Mar  2 15:16:45 darkstar kernel: radeonfb: Reference=27.00 MHz 
> (RefDiv=12) Memory=325.00 Mhz, System=200.00 MHz
> Mar  2 15:16:45 darkstar kernel: radeonfb: PLL min 20000 max 40000
> Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: monid seems to be busy.
> Mar  2 15:16:45 darkstar kernel: radeonfb 0000:01:00.0: Failed to 
> register I2C bus monid.
> Mar  2 15:16:45 darkstar kernel: i2c-algo-bit.o: crt2 seems to be busy.
> Mar  2 15:16:46 darkstar kernel: radeonfb 0000:01:00.0: Failed to 
> register I2C bus crt2.
> Mar  2 15:16:46 darkstar kernel: Console: switching to colour frame 
> buffer device 90x25
> Mar  2 15:16:46 darkstar kernel: radeonfb (0000:01:00.0): ATI Radeon AP
> 
> Do the "seems to be busy." and/or "Failed to register I2C bus" indicate 
> a problem ?

The i2c-algo-bit driver has an optional bus check function. It can be 
used to detect stalled, disconnected or improperly configured busses. 
The check seems to be enabled in your case, which is kind of strange 
since it isn't by default.

Frédéric, can you check in /etc/modprobe.conf if you have a line like:
options i2c-algo-bit bit_test=1
If you do, please comment it out and see if it changes anything.

Benjamin, i2c-algo-bit with bit_test=1 may cause I2C bus creation to 
fail. As far as I can see, it is even the only way the bus creation 
function can return a negative value (which I consider a bug because 
there are other possible failure causes). I will test the effect of 
bit_test=1 on my two radeon systems this evening and see what happens. I 
will also work on a patch fixing the return value if it needs to be.

What I wanted to underline is the fact that it might be the first time 
bus registration ever fails, and although it looks like the radeonfb 
code handles the case, that code path had certainly not received much 
testing so far.

-- 
Jean Delvare

