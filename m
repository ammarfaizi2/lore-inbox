Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265216AbUBIWZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUBIWZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:25:40 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:27884 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S265216AbUBIWZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:25:38 -0500
From: Bernd Schubert <bernd-schubert@web.de>
To: roychris <roychris@free.fr>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Mon, 9 Feb 2004 23:25:34 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, r31@rnbhq.org
References: <20040208215935.GA13280@ucw.cz> <20040208233052.GA17570@ucw.cz> <40278077.5070409@free.fr>
In-Reply-To: <40278077.5070409@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402092325.34895.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 February 2004 13:43, roychris wrote:
> I resolved this problem. It's the fault of the multiplexing on i8042.
> You must pass i8042_nomux=1 to the kernel for 2.4.X or 2.6.0 or you must
> modify
> linux-2.6.x/drivers/input/serio/i8042.c by quoting many lines if > 2.6.0
> because nomux doesn't work :
>
>
> /*      if (!i8042_noaux && !i8042_check_aux(&i8042_aux_values)) {
>                 if (!i8042_nomux && !i8042_check_mux(&i8042_aux_values))
>                         for (i = 0; i < 4; i++) {
>                                 i8042_init_mux_values(i8042_mux_values +
> i, i804
> 2_mux_port + i, i);
>                                 i8042_port_register(i8042_mux_values +
> i, i8042_
> mux_port + i);
>                         }
>                 else
> */
>              i8042_port_register(&i8042_aux_values, &i8042_aux_port);
> //      }
>

Hello Roychris,

on 2.4.25-rc1 the i8042_nomux=1 option causes the following:
- on a single read on /proc/apm the mouse still jumps
- several/few reads make the mouse to stop and only to work after a few 
seconds
- a fast endless read makes the mouse to stop at all and never work again

Commenting out the lines in 2.6.2-rc2 causes the mouse not to work at all. No 
error messages, nothing in the logs.

Do you have a Thinkpad R31 and it workes there for you?

Thanks a lot for your help,
	Bernd
