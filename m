Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVDLMDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVDLMDf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbVDLLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:32:22 -0400
Received: from sophia.inria.fr ([138.96.64.20]:39565 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id S262342AbVDLLL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:11:27 -0400
Message-ID: <425BACC2.9020709@yahoo.fr>
Date: Tue, 12 Apr 2005 13:10:58 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-joystick@atrey.karlin.mff.cuni.cz
Subject: snd-ens1371 (alsa) & joystick woes
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (sophia.inria.fr [138.96.64.20]); Tue, 12 Apr 2005 13:11:01 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 From 2.6.11 to 2.6.12-rc2, there are some changes in the joystick behaviour
that I don't think are expected. It's a simple joystick using analog.ko 
plugged
on a sound board using snd-ens1371. So here we go:

With 2.6.11:
$ jstest /dev/input/js0
Joystick (Analog 3-axis 4-button joystick) has 3 axes and 4 buttons. 
Driver version is 2.1.0.
Testing ... (interrupt to exit)
Axes:  0: 32767  1:-32767  2:-32767 Buttons:  0:off  1:off  2:off  3:off

Works ok, button0 is the one that serves as a gun trigger. All buttons
work as expected when I use them.

$ jstest --event /dev/input/js0
Joystick (Analog 3-axis 4-button joystick) has 3 axes and 4 buttons. 
Driver version is 2.1.0.
Testing ... (interrupt to exit)
# ...
Event: type 1, time 201830, number 0, value 0
Event: type 1, time 202082, number 0, value 1
Event: type 1, time 202229, number 0, value 0
Event: type 1, time 202355, number 0, value 1
# ...

I repeatedly press the button0, works OK.

Now with 2.6.12-rc2:

$ jstest /dev/input/js0
Joystick (Analog 3-axis 4-button joystick) has 3 axes and 5 buttons. 
Driver version is 2.1.0.
Testing ... (interrupt to exit)
Axes:  0:     0  1:     0  2:-31874 Buttons:  0:off  1:off  2:off  
3:off  4:off

Huh, now it says it has 5 buttons. The button0 is disabled, and hitting
the gun trigger (button0 in 2.6.11) changes the button4. Others buttons
work as expected.


$ jstest --event /dev/input/js0
Joystick (Analog 3-axis 4-button joystick) has 3 axes and 5 buttons. 
Driver version is 2.1.0.
Testing ... (interrupt to exit)
# ...
Event: type 1, time -147737, number 4, value 0
Event: type 1, time -147170, number 4, value 1
Event: type 1, time -146991, number 4, value 0
Event: type 1, time -146834, number 4, value 1
Event: type 1, time -146676, number 4, value 0
Event: type 1, time -146529, number 4, value 1
Event: type 1, time -146361, number 4, value 0
Event: type 1, time -146193, number 4, value 1
Event: type 1, time -146004, number 4, value 0
Event: type 1, time -145836, number 4, value 1
Event: type 1, time -145710, number 4, value 0
Event: type 1, time -145385, number 4, value 1
Event: type 1, time -145269, number 4, value 0
# ...

Still playing with the gun trigger, the negative time must be the jiffies
initialisation to -300*HZ, but the number 4 seems wrong.

Thanks.

-- 
Guillaume

