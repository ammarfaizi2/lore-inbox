Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281022AbRKTLPG>; Tue, 20 Nov 2001 06:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281023AbRKTLO5>; Tue, 20 Nov 2001 06:14:57 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:27147 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S281022AbRKTLOp>;
	Tue, 20 Nov 2001 06:14:45 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Dan Merillat <harik@chaos.ao.net>
Date: Tue, 20 Nov 2001 12:14:08 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: radeonfb bug: text ends up scrolling in the middle of t
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <9B5C5851B1E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Nov 01 at 23:38, Dan Merillat wrote:
> > they'll shed some light on the problem.
> 
> Yes, yes.  The boot messages are normal, and typing 'reset' once I login 
> restores normal console.  The code that sets up a scrolling window below tux
> is well, missing the mark.
> 
> Tux looks like he's about 5 lines high, so lines 1-3 are tux, 4 is the one
> line of scroll, 5 is his feet, and 6-30 is the previous kernel boot
> messages.

It is known problem. At least known to me. After reboot and typing 'reset'
type 'dmesg' and then look for 'Console: switching to colour frame buffer 
device...'. Above that message you'll find couple of radeon messages - 
and you have to remove all printed during register_framebuffer() from
driver source - it looks to me like that '#if 1'-ed code in radeon_write_code
is suspect.

You must not do any output during register framebuffer. If you'll output
one line, I believe that it will still work, but if you'll do more, 
kernel output is catched in upper Tux window instead of in the bottom half 
of screen. And if you'll print really much of info during 
register_framebuffer, kernel will die...
                                            Best regards,
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
