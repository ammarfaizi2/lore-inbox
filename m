Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262283AbVAUGnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbVAUGnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbVAUGnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:43:55 -0500
Received: from smtp-105-friday.noc.nerim.net ([62.4.17.105]:55307 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262283AbVAUGnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:43:42 -0500
Date: Fri, 21 Jan 2005 07:46:24 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Nicolas Pitre <nico@cam.org>
Cc: LM Sensors <sensors@Stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>, Jonas Munsin <jmunsin@iki.fi>,
       Simone Piunno <pioppo@ferrara.linux.it>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <20050121074624.3db5af6a.khali@linux-fr.org>
In-Reply-To: <Pine.LNX.4.61.0501201536240.5315@localhost.localdomain>
References: <s62KuN6T.1106238493.8706410.khali@localhost>
	<Pine.LNX.4.61.0501201536240.5315@localhost.localdomain>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

> I confirm that 0x7f is full speed.

So at least the polarity bit is correct, and Gigabyte isn't to blame.

> > Once you know if the polarity is correct, you can try different
> > values of PWM between 0x00 and 0x7F and see how exactly your fan
> > reacts to them.
> 
> That's where things get really really interesting.  As mentioned
> above 0x7f drives the fan full speed (2596 RPM).  Now lowering that
> value slows the CPU fan gradually down to a certain point.  With a
> value of 0x3f the fan turns at 1041 RPM.  But below 0x3f the fan
> starts speeding up again to reach a peak of 2280 RPM with a value
> of 0x31, then it slows  down again toward 0 RPM as the register
> value is decreased down to 0.
> 
> Bit 3 of register 0x14, when set, only modifies the curve so the
> first minimum is instead reached at 0x30 then the peak occurs at 0x1d
> before dropping to 0.
> 
> Changing the PWM base clock select has no effect.

Wow! Unexpected, to say the least. First time I see such a behavior.

Could it be that your CPU fan isn't a simple passive device but one of
these high-tech models with an embedded thermal sensor and automatic
speed adjustment? This would possibly interact with the motherboard PWM
capability and could explain the strange speed curve your obtained.

I would also like you to try a similar test with your case fan. Enable
"smart guardian" mode for this one (by writing 0x73 to register 0x13),
then scan the 0x7f-0x00 range (register 0x16) like you did for your CPU
fan. I wonder if you will obtain the same kind of result or a standard
linear curve.

(Note that PWM2 might not be wired at all on your motherboard, so don't
be surprised if the case fan speed doesn't change at all.)

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
