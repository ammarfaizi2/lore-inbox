Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTFQUQl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTFQUQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:16:41 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:52614 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S264922AbTFQUQk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:16:40 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: James Simmons <jsimmons@infradead.org>
Date: Tue, 17 Jun 2003 22:29:58 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: FRAMEBUFFER (and console)
Cc: linux-kernel@vger.kernel.org, spyro@f2s.com
X-mailer: Pegasus Mail v3.50
Message-ID: <4B38D4B6A6E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 03 at 21:03, James Simmons wrote:
> > My framebuffer (and therefore system console, by definition) come up
> > rather late.
> > 
> > It seems the console doesnt care to check for drivers comming up after a
> > certain time, and thus I get no output despite the driver working.
> 
> The reason for this is because the framebuffers most often depend on the 
> bus being set up. Usually this happening later in the boot process. What 
> are trying to do? Retrieve the earlier printk messages. Do you have 
> DUMMY_CONSOLE set to Y. I believe the data is transfered from dummycon to 
> fbcon after fbcon is initialized. If you having problems with that try 
> increasing the size of dummycon's "screen". See dummycon.c for more 
> details.

Maybe he just enabled vga16 + XXXfb. First vga16 comes up, and start
painting characters. Few microseconds after that XXXfb (for example
matroxfb) comes up, registers itself as /dev/fb1 and reprograms hardware
to non-VGA mode. 

>From that point on vga16fb paints characters to unmapped memory, and
there is only black on screen.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                

