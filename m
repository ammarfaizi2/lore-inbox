Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266928AbSKOXxr>; Fri, 15 Nov 2002 18:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbSKOXxr>; Fri, 15 Nov 2002 18:53:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:2445 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266928AbSKOXxq>;
	Fri, 15 Nov 2002 18:53:46 -0500
Message-ID: <3DD58A9E.2580F85D@digeo.com>
Date: Fri, 15 Nov 2002 16:00:30 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>, James Morris <jmorris@intercode.com.au>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.47-mm3
References: <200211161015.56003.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2002 00:00:30.0952 (UTC) FILETIME=[2D9DA680:01C28D03]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
(yuk)

> I dont have anything crypto enabled in the config
> 
> In file included from include/net/xfrm.h:6,
>                  from net/core/skbuff.c:61:
> include/linux/crypto.h: In function `crypto_tfm_alg_modname':
> include/linux/crypto.h:202: dereferencing pointer to incomplete type
> include/linux/crypto.h:205: warning: control reaches end of non-void function
> make[2]: *** [net/core/skbuff.o] Error 1
> make[1]: *** [net/core] Error 2
> make: *** [net] Error 2

Looks like you have CONFIG_MODULES=n, but crypto_tfm_alg_modname()
is unconditionally accessing module->name.

Suggest you enable modules, and set all your drivers to "y".
