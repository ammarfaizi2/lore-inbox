Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWERTLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWERTLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 15:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbWERTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 15:11:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:470 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751382AbWERTLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 15:11:14 -0400
Date: Thu, 18 May 2006 12:10:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix magic sysrq on strange keyboards
Message-Id: <20060518121057.3d79779b.akpm@osdl.org>
In-Reply-To: <20060518102354.GA1715@elf.ucw.cz>
References: <20060518102354.GA1715@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Magic sysrq fails to work on many keyboards, particulary most of
>  notebook keyboards. This should help...
> 
>  The idea is quite simple: Discard the SysRq break code if Alt is still
>  being held down. This way the broken keyboard can send the break code
>  (or the user with a normal keyboard can release the SysRq key) and the
>  kernel waits until the next key is pressed or the Alt key is released.
> 
>  From: Fredrik Roubert <roubert@df.lth.se>
>  Signed-off-by: Pavel Machek <pavel@suse.cz>
> 

What kernel are you patching here?


>  index 5d84839..4602cf3 100644
>  --- a/drivers/char/keyboard.c
>  +++ b/drivers/char/keyboard.c
>  @@ -149,7 +149,8 @@ unsigned char kbd_sysrq_xlate[KEY_MAX + 
>           "\206\207\210\211\212\000\000789-456+1"         /* 0x40 - 0x4f */
>           "230\177\000\000\213\214\000\000\000\000\000\000\000\000\000\000" /* 0x50 - 0x5f */
>           "\r\000/";                                      /* 0x60 - 0x6f */
>  -static int was_sysrq;
>  +static int sysrq_down;
>  +static int sysrq_alt_use;

bix:/usr/src/linux-2.6.17-rc4> grep was_sysrq drivers/char/sysrq.c
bix:/usr/src/linux-2.6.17-rc4> 

