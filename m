Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261295AbULSOIY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbULSOIY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 09:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbULSOIY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 09:08:24 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20490 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261298AbULSOIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 09:08:09 -0500
Date: Sun, 19 Dec 2004 15:08:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jim Nelson <james4765@verizon.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] ip2: fix compile warnings
Message-ID: <20041219140805.GT21288@stusta.de>
References: <20041217214735.7127.91238.40236@localhost.localdomain> <20041218021457.GK21288@stusta.de> <41C3A108.7080602@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C3A108.7080602@verizon.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2004 at 10:16:24PM -0500, Jim Nelson wrote:
> 
> How about doing something like this:
> 
> #ifdef ENABLE_DSSNOW
> #define DSSNOW_ENABLED 1
> #else
> #define DSSNOW_ENABLED 0
> #endif
> 
> -blah-
> 
> static int ip2_tiocmget(struct tty_struct *tty, struct file *file)
> {
> 	i2ChanStrPtr pCh = DevTable[tty->index];
> 
> 	if (pCh == NULL)
> 		return -ENODEV;
> 
> if (DSSNOW_ENABLED) {
> 	if (ip2_tiocmget_dssnow() == -EINTR) return -EINTR;
> 	}
> 
> 	return  ((pCh->dataSetOut & I2_RTS) ? TIOCM_RTS : 0)
> 	      | ((pCh->dataSetOut & I2_DTR) ? TIOCM_DTR : 0)
> 	      | ((pCh->dataSetIn  & I2_DCD) ? TIOCM_CAR : 0)
> 	      | ((pCh->dataSetIn  & I2_RI)  ? TIOCM_RNG : 0)
> 	      | ((pCh->dataSetIn  & I2_DSR) ? TIOCM_DSR : 0)
> 	      | ((pCh->dataSetIn  & I2_CTS) ? TIOCM_CTS : 0);
> }
> 
> /*
> 	FIXME - the following code is causing a NULL pointer dereference in
> 	2.3.51 in an interrupt handler.  It's suppose to prompt the board
> 	to return the DSS signal status immediately.  Why doesn't it do
> 	the same thing in 2.2.14?
> */
> 
> /*	This thing is still busted in the 1.2.12 driver on 2.4.x
> 	and even hoses the serial console so the oops can be trapped.
> 		/\/\|=mhw=|\/\/			*/
> 
> static int ip2_tiocmget_dssnow (void)
> {
>...

The real issue is the FIXME in the comment.

Such a patch would remove the warning but wouldn't fix the underlying 
real issue.

Fixing warnings is usually not a bad idea, but in this case I'd say the 
warning could stay until somebody fixes the real issue in the code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

