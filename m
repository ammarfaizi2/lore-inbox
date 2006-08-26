Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422864AbWHZCBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbWHZCBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 22:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422915AbWHZCBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 22:01:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:32018 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1422864AbWHZCBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 22:01:25 -0400
Date: Sat, 26 Aug 2006 04:01:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: drivers/char/synclink_gt.c: chars don't have more than 8 bits
Message-ID: <20060826020123.GB4765@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The GNU C compiler (SVN version) spotted the following buggy code in 
drivers/char/synclink_gt.c:

<--  snip  -->

...
static void rx_async(struct slgt_info *info)
{
...
        unsigned char *p;
        unsigned char status;
...
                        if ((status = *(p+1) & (BIT9 + BIT8))) {
                                if (status & BIT9)
                                        icount->parity++;
                                else if (status & BIT8)
                                        icount->frame++;
                                /* discard char if tty control flags say so */
                                if (status & info->ignore_status_mask)
                                        continue;
                                if (status & BIT9)
                                        stat = TTY_PARITY;
                                else if (status & BIT8)
                                        stat = TTY_FRAME;
                        }
...

<--  snip  -->

Since there are no bits 8 or 9 in a char this code is currently
dead code.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

