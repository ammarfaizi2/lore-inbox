Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWHNXPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWHNXPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 19:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWHNXPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 19:15:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:29703 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965052AbWHNXP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 19:15:29 -0400
Date: Tue, 15 Aug 2006 01:15:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: patrick.boettcher@desy.de, v4l-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: drivers/media/dvb/dvb-usb/dibusb-mb.c: NULL dereference
Message-ID: <20060814231528.GY3543@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following "we dereference d->fe only 
when we know it's NULL" bug:

<--  snip  -->

...
static int dibusb_dib3000mb_frontend_attach(struct dvb_usb_device *d)
{
...
        if ((d->fe = dib3000mb_attach(&demod_cfg,&d->i2c_adap,&st->ops)) == NULL) {
                d->fe->ops.tuner_ops.init = dvb_usb_tuner_init_i2c;
                d->fe->ops.tuner_ops.set_params = dvb_usb_tuner_set_params_i2c;
                return -ENODEV;
        }
...

<--  snip  -->

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

