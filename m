Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSLCObP>; Tue, 3 Dec 2002 09:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSLCObP>; Tue, 3 Dec 2002 09:31:15 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:37064 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S261486AbSLCObO>;
	Tue, 3 Dec 2002 09:31:14 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Lucio Maciel <abslucio@terra.com.br>
Date: Tue, 3 Dec 2002 15:38:28 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [TRIVIAL PATCH 2.5] Uninitialised timer in matroxfb_DAC
Cc: linux-kernel@vger.kernel.org,
       "rusty's trivial patch monkey" <trivial@rustcorp.com.au>
X-mailer: Pegasus Mail v3.50
Message-ID: <94678E2512F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  3 Dec 02 at 9:23, Lucio Maciel wrote:
> 
> Fix an Uninitialised timer in matroxfb_DAC1064.c
> > > Uninitialised timer!
> > > This is just a warning.  Your computer is OK
> > > function=0xc02a654c, data=0x0
> > > Call Trace:
> > >  [<c0123e7f>] check_timer_failed+0x63/0x65
> > >  [<c02a654c>] cursor_timer_handler+0x0/0x3c
> > >  [<c0123ec0>] add_timer+0x3f/0xa1
> > >  [<c02a68fa>] fbcon_startup+0x4b/0x4d
> > >  [<c023c400>] take_over_console+0x29/0x1c8
> > >  [<c02a5be8>] register_framebuffer+0xe9/0x16d
> > >  [<c02ad111>] initMatrox2+0x849/0xaba

But this warning is not caused by uninitialized timer in either
of matroxfb_DAC1064.c or matroxfb_Ti3026.c, it is caused by reverted
patch to drivers/video/fbcon.c (which was already posted here).

cursor.timer inside matrox_fb_info structure is initialized in 
drivers/video/matrox/matroxfb_base.c, in matroxfb_probe function.

So please drop these both patches, to matroxfb_DAC1064.c and
matroxfb_Ti3026.c. They do nothing good, they only cause
init_timer() to be invoked from timer handler itself, and besides that
it fixes nothing, I think that it is also really dangerous thing...

Is my code really so hard to read, that people find nonexistant
uninitialized timers in both ncpfs and matroxfb?
                                                    Best regards,
                                                        Petr Vandrovec
                                                        vandrove@vc.cvut.cz
                                                        
