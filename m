Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262948AbTJQKuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 06:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTJQKuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 06:50:35 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:2010 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262948AbTJQKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 06:50:33 -0400
Subject: Re: [Linux-fbdev-devel] Re: FBDEV 2.6.0-test7 updates.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031017100412.GA1639@casa.fluido.as>
References: <20031015162056.018737f1.akpm@osdl.org>
	 <Pine.LNX.4.44.0310160022210.13660-100000@phoenix.infradead.org>
	 <20031016091918.GA1002@casa.fluido.as> <1066298431.1407.119.camel@gaston>
	 <20031016101905.GA7454@casa.fluido.as> <1066300935.646.136.camel@gaston>
	 <20031017100412.GA1639@casa.fluido.as>
Content-Type: text/plain
Message-Id: <1066387778.661.226.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 17 Oct 2003 12:49:38 +0200
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: benh@kernel.crashing.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok. I got the code (it is mvista, not mivsta...). My card is
> recognized without modifications:

Good.

> Then, when changing to 1280x1024, with command
> 
> /usr/sbin/fbset  -depth 32 1280x1024-60
> 
> the actual console changes correctly, but when switching to other VCs,
> the monitor again complains saying it gets bad frequencies: 103.1 kHz
> horizontal and 197.8 Hz vertical.

Not sure what's up here. The driver is quite passive regarding
the mode for other VCs, it sort of expect the fbcon layer do pick up
the default mode and use it for other consoles. I'm not sure what's
wrong here.

In a more general way, I really lack the ability to change the console
size with fbset like I could do with 2.4. I don't know if James revived
that feature in his latest patches though. The stty thing isn't very
reliable imho. Especially on monitors that don't like the standard
modedb.

> And on a similar topic, could you write a couple of examples about how
> to use the parameters included in radeon_base.c? I am thinking
> especially of the "mirror" and "monitor_layout" parameters, that I
> believe would allow me to use the two or three video outputs of the
> card independently. I currently read

I have to see what I'll do of these parameters first. For now, the
driver only really use the first head. I haven't yet implemented support
for the second one, though it's on my list of things to do.

> 0 ATI Radeon Yd 
> 
> in /proc/fb. I should read two or three lines there, I believe...

Well... /proc is evil :)

