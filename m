Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261947AbVATVTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbVATVTo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 16:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261956AbVATVTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 16:19:44 -0500
Received: from modemcable240.48-200-24.mc.videotron.ca ([24.200.48.240]:43911
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261947AbVATVTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 16:19:42 -0500
Date: Thu, 20 Jan 2005 16:19:12 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@localhost.localdomain
To: Jean Delvare <khali@linux-fr.org>
cc: LM Sensors <sensors@Stimpy.netroedge.com>,
       lkml <linux-kernel@vger.kernel.org>, Jonas Munsin <jmunsin@iki.fi>,
       Simone Piunno <pioppo@ferrara.linux.it>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
In-Reply-To: <s62KuN6T.1106238493.8706410.khali@localhost>
Message-ID: <Pine.LNX.4.61.0501201536240.5315@localhost.localdomain>
References: <s62KuN6T.1106238493.8706410.khali@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2005, Jean Delvare wrote:

> > In the mean time I'm willing to try out things
> > with isaset if you can suggest basic tests (easier than upgrading kernel
> > for the time being).
> 
> The best test I can think of is to switch your CPU fan to manual PWM
> mode. To do that, write 0x40 to register 0x15. CPU fan should go to half
> speed. Write 0x7F and if should go to full speed, except if the polarity
> is not correct in which case 0x00 will do (and 0x7F will stop the fan
> completely so you don't want to keep it that way).

I confirm that 0x7f is full speed.

> Once you know if the polarity is correct, you can try different values of
> PWM between 0x00 and 0x7F and see how exactly your fan reacts to them.

That's where things get really really interesting.  As mentioned above 
0x7f drives the fan full speed (2596 RPM).  Now lowering that value 
slows the CPU fan gradually down to a certain point.  With a value of 
0x3f the fan turns at 1041 RPM.  But below 0x3f the fan starts speeding 
up again to reach a peak of 2280 RPM with a value of 0x31, then it slows 
down again toward 0 RPM as the register value is decreased down to 0.

Bit 3 of register 0x14, when set, only modifies the curve so the first 
minimum is instead reached at 0x30 then the peak occurs at 0x1d before 
dropping to 0.

Changing the PWM base clock select has no effect.


Nicolas
