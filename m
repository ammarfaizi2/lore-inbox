Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269485AbUICEyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269485AbUICEyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269499AbUICEyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:54:17 -0400
Received: from main.gmane.org ([80.91.224.249]:50577 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269485AbUICEyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:54:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: [PATCH 2.6.8.1 0/2] leds: new class for led devices
Date: Fri, 03 Sep 2004 13:54:04 +0900
Message-ID: <ch8tdd$1uf$1@sea.gmane.org>
References: <1094157190l.4235l.2l@hydra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: j110113.ppp.asahi-net.or.jp
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: bg, en, ja, ru, de
In-Reply-To: <1094157190l.4235l.2l@hydra>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Lenz wrote:
> This is an attempt to provide an alternative to the current arm  
> specific led interface.  This arm interface does not integrate well  
> with the device model and sysfs.
I am just curious, but what specific hardware devices can be controlled with this?

[snip]

> function : a read/write attribute that sets the current function of  
> this led.  The available options are
> 
>  timer : the led blinks on and off on a timer
>  idle : the led turns off when the system is idle and on when not idle
>  power : the led represents the current power state
>  user : the led is controlled by user space

Please put the power comment in the source too, e.g. :

+enum led_functions {
+	leds_user = 0,	/* user has control of this led through sysfs */
+	leds_timer,	/* led blinks on a timer */
+	leds_idle,	/* led is on when the system is not idle */
+	leds_power,	/* led is on when ?????????????????????? */
+};

To be honest, I don't get the meaning of any of the led_functions except leds_user...

> light : a read/write attribute that allows userspace to see the current  
> status of the led.  If function="user" then writing to this attribute  
> will change the led on or off.  If function != "user" then writing has  
> no effect.
>  light is an integer, where 0 means off, 1 means on first color, 2  
> means on second color, etc.  (for example, if color="green/blue" then  
> light=1 means turn led on to green and if light=2 means turn led on to  
> blue.

Is something like max_colors or num_colors necessary?
Might be handy for changing to the "last" color or something,
but it may as well be done by userspace app.


-- 
 || ~~~~~~~~~~~~~~~~~~~~~~ ||
(  ) http://ThinRope.net/ (  )
 || ______________________ ||

