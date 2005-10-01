Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVJASPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVJASPy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVJASPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:15:54 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:32271 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1750764AbVJASPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:15:53 -0400
Date: Sat, 1 Oct 2005 20:16:11 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <lm-sensors@lm-sensors.org>
Subject: Re: 2.6.14-rc2-mm2
Message-Id: <20051001201611.41db4f71.khali@linux-fr.org>
In-Reply-To: <20050930010931.5beb174e@werewolf.able.es>
References: <20050929143732.59d22569.akpm@osdl.org>
	<20050930010931.5beb174e@werewolf.able.es>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi J.A.

> I still need this to make my sensors work. I collected it from the list, heard
> people say it was not the proper solution, but without this it still doesn't work.
> No sensors.

You could simply have disabled PNPACPI.

Nevertheless, I finally accepted a patch from Petr Vandrovec which will
solve the issue for both the w83627hf and the w83627ehf drivers. Now
you just have to wait for it to hit Andrew and Linus trees, in that
order.

> Another issue. Is there any divisor value for fans hardcoded intially ?

Depends on the chip, but the general answer is yes. Registers holding
the information have a power up default value. Older chips tend to
default to a divider of 2. More recent chip default to 8. However, it
is also possible that the BIOS is changing these values.

> I have 3 fans in my mobo, and 2 report 0 RPM until I put the divisor at 8

Because they are slow. The slower a fan, the higher the clock divider
must be.

Note that some drivers have the ability to automatically adjust the fan
clock dividers: adm9240, pc87360 and w83627ehf. Others could be
converted too, but not everyone seem to agree that this feature should
be implemented at all.

> This fans are two for the xeons, and one for the box. Strangely, the fans that
> are misread are the one for the board and one of the xeons ?

It all depends on the speed, not on what the fans are attached to.
Maybe one of the xeon fans is much faster than the other.

Note that I modified the w83627hf driver recently so that the hardware
monitoring chip will no more be reset by default at driver load time.
This might solve your problem if your BIOS is setting higher dividers
than the power up default.

> And more, my board has 2 more fan sensors, but the driver can only see 3. Any idea ?
> (Asus PC-DL Deluxe).

I think it was reported before. Some boards use multiplexing for fan
readings. This is undocumented, we couldn't guess how to switch the
lines. Switching fan tachometer lines is a nonsense anyway, so there is
no point in supporting it.

-- 
Jean Delvare
