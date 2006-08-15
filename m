Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030335AbWHOOvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030335AbWHOOvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWHOOvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:51:36 -0400
Received: from znsun1.ifh.de ([141.34.1.16]:24817 "EHLO znsun1.ifh.de")
	by vger.kernel.org with ESMTP id S1030336AbWHOOvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:51:35 -0400
Date: Tue, 15 Aug 2006 16:43:23 +0200 (CEST)
From: Patrick Boettcher <patrick.boettcher@desy.de>
X-X-Sender: pboettch@pub2.ifh.de
To: Adrian Bunk <bunk@stusta.de>
Cc: v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       linux-kernel@vger.kernel.org
Subject: Re: drivers/media/dvb/dvb-usb/dibusb-mb.c: NULL dereference
In-Reply-To: <20060814231528.GY3543@stusta.de>
Message-ID: <Pine.LNX.4.64.0608151635360.30902@pub2.ifh.de>
References: <20060814231528.GY3543@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, 15 Aug 2006, Adrian Bunk wrote:

> The Coverity checker spotted the following "we dereference d->fe only 
> when we know it's NULL" bug:
> 
> <--  snip  -->
> 
> ...
> static int dibusb_dib3000mb_frontend_attach(struct dvb_usb_device *d)
> {
> ...
>         if ((d->fe = dib3000mb_attach(&demod_cfg,&d->i2c_adap,&st->ops)) == NULL) {
>                 d->fe->ops.tuner_ops.init = dvb_usb_tuner_init_i2c;
>                 d->fe->ops.tuner_ops.set_params = dvb_usb_tuner_set_params_i2c;
>                 return -ENODEV;
>         }
> ...
> 
> <--  snip  -->

Oops, this one was introduced in rev 3124 of the v4l-dvb repository when 
adding tuner_ops.

Mauro, can you please pull from http://linuxtv.org/hg/~pb/v4l-dvb to get 
the fix.

For the others: the changeset is here: 

http://linuxtv.org/hg/~pb/v4l-dvb?cmd=changeset;node=ac1c589c56fc018f14fdf74c274d8438a8566b69;style=raw

regards,
Patrick.

--
  Mail: patrick.boettcher@desy.de
  WWW:  http://www.wi-bw.tfh-wildau.de/~pboettch/
