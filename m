Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUKBTdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUKBTdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbUKBTdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:33:07 -0500
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:57104 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262003AbUKBTbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:31:25 -0500
Date: Tue, 2 Nov 2004 20:31:22 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Justin Thiessen <jthiessen@penguincomputing.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: adm1026 driver port for kernel 2.6.X - [REVISED DRIVER]
Message-Id: <20041102203122.7e7a8366.khali@linux-fr.org>
In-Reply-To: <20041102164642.GA16378@penguincomputing.com>
References: <20041025210057.GB19053@penguincomputing.com>
	<GNXY8AG6.1098776962.4770080.khali@gcu.info>
	<20041029191229.GB803@penguincomputing.com>
	<20041102164642.GA16378@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0beta1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi justin,

> As discussed in previous messages, control over the pwm output is
> provided via:
> 
> pwm1                  {0-255}
> pwm1_auto_pwm_min     {0-255}

What exactly does this value represent again? (See below too.)

> pwm1_enable           {0-2}  (off, manual, automatic fan control)
> 
> Access to the DAC is provided via:
> 
> analog_out            {0-2500} (millivolts)
> 
> No way is currently provided to turn on DAC-mediated automatic fan
> control. See my previous email in this thread for the reasons why.

On a side note, MBM lists the ADM1026 as being used on only two
motherboard models, one being yours. Considering this and the fact that
nobody ever requested us to port the adm1026 driver to Linux 2.6, I
would conclude that the motherboard you use is possibly the only one
worth supporting. Do not bother with anything that you don't personally
need. We can still add it later on request.

> Control over automatic fan "on" temperatures are provided by:
> 
> temp[1-3]_auto_point1_temp     {-128000 - 127000}
> 
> Hardware-determined hysteresis and range values are revealed in:
> 
> temp[1-3]_auto_point1_temp_hyst   {-6000}

Hysteresis temperatures have to be absolute temperatures as per
interface standard.

> temp[1-3]_auto_point2_temp        {temp[1-3]_auto_point1_temp + 20000}

I'm a bit surprised not to see temp[1-3]_auto_point[1-2]_pwm. Trip
points are supposed to be (temp, pwm) pairs. Doesn't pwm1_auto_pwm_min
above correspond to one or more of these?

> Failsafe critical temperatures at which the fans go to maximum speed
> are controled via:
> 
> temp_crit_enable       {0-1}  (off, on)
> temp[1-3]_crit         {-128000 - 127000}

Granted it's not part of the standard yet, but you would have three
files temp[1-3]_crit_enable if we stick to our chip-indenpendent
interface logic. Either make 1 read-write and [2-3] read-only, or make
all read-write and each one changes the three values.

> These values override any values set for the pwm-mediated automatic
> fan control.

Doesn't this mean that you could integrate these in the auto-pwm
interface as point3?

> Thanks to all for the feedback.

You're welcome. Sorry to ask questions about the proposed interface
again, I just want things to be as clean and logical as possible.

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/
