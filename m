Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUEAWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUEAWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUEAWC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:02:28 -0400
Received: from mail.convergence.de ([212.84.236.4]:35497 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262370AbUEAWC0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:02:26 -0400
Date: Sun, 2 May 2004 00:02:31 +0200
From: Johannes Stezenbach <js@convergence.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, linux-dvb-maintainer@linuxtv.org,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3: modular DVB tda1004x broken
Message-ID: <20040501220231.GA2846@convergence.de>
Mail-Followup-To: Johannes Stezenbach <js@convergence.de>,
	Adrian Bunk <bunk@fs.tum.de>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
	linux-dvb-maintainer@linuxtv.org,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0404271858290.10799@ppc970.osdl.org> <408F9BD8.8000203@eyal.emu.id.au> <20040501201342.GL2541@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040501201342.GL2541@fs.tum.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2004 at 10:13:42PM +0200, Adrian Bunk wrote:
> On Wed, Apr 28, 2004 at 09:56:08PM +1000, Eyal Lebedinsky wrote:
> >...
> > depmod says:
> > 
> > WARNING: 
> > /lib/modules/2.6.6-rc3/kernel/drivers/media/dvb/frontends/tda1004x.ko needs 
> > unknown symbol errno
> >...
> 
> Thanks for this report.
> 
> It seems the DVB updates broke this.
> 
> Please _undo_ the patch below.
...
> --- a/drivers/media/dvb/frontends/tda1004x.c	Tue Apr 27 18:37:15 2004
> +++ b/drivers/media/dvb/frontends/tda1004x.c	Tue Apr 27 18:37:15 2004
> @@ -188,7 +190,6 @@
>  static struct fwinfo tda10046h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x3c4f9,.fw_size = 24479} };
>  static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
>  
> -static int errno;
>  
>  
>  static int tda1004x_write_byte(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state, int reg, int data)

Indeed, errno is referenced by the __KERNEL_SYSCALLS__ cruft (still used for
firmware loading, request_firmware() depends on the patches that
Michael Hunold is working on for making DVB use the kernel I2C subsytem).
One more hint that this has to be done rsn...

I can't find the error report which motivated this patch so I cannot
come up with a different fix right now. Anyway, the patch must be
reverted.

Johannes
