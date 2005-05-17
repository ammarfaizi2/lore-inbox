Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVEQHt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVEQHt5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 03:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbVEQHt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 03:49:57 -0400
Received: from zone4.gcu-squad.org ([213.91.10.50]:38881 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261356AbVEQHtm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 03:49:42 -0400
Date: Tue, 17 May 2005 09:41:55 +0200 (CEST)
To: fishor@gmx.net
Subject: Re: clean up and warnings patch for 2.6.12-rc4-mm1 i2c-chip
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <ozwFbjSm.1116315715.7725280.khali@localhost>
In-Reply-To: <200505170841.20079.fishor@gmx.net>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey,

> with module w83627hf  i found useful due  detection return -ENODEV
> because I can see in commandline if it's some thing wrong. If it's not
> correct, there is a bug in the w83627hf and some other drivers.
>
> int w83627hf_detect(struct i2c_adapter *adapter, int address,
>                    int kind)
> {
>         int val;
>         struct i2c_client *new_client;
>         struct w83627hf_data *data;
>         int err = 0;
>         const char *client_name = "";
>
>         if (!i2c_is_isa_adapter(adapter)) {
>                 err = -ENODEV;
>                 goto ERROR0;
>         }

This is actually not correct if you consider the i2c_detect() design, but
happens to cause no problem in this specific case - and, ironically,
might even speed up the detection loop.

The way i2c_detect() works for now, it will stop probing a given adapter
as soon as one address probed on that bus returned an error. As it
happens that i2c_is_isa_adapter(adapter) is either true or false for all
addresses of a given adapter, skipping to the next adapter directly when
the bus type (isa or not) doesn't match actually makes sense.

At any rate, I have plans to rework the way ISA hardware monitoring chips
are handled, so this code is likely to be gone in a near future anyway
(providing I can actually find the time to work on this... sigh). Things
should be much clearer after that.

Thanks,
--
Jean Delvare
