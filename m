Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266550AbRGIJgJ>; Mon, 9 Jul 2001 05:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbRGIJf6>; Mon, 9 Jul 2001 05:35:58 -0400
Received: from smtp.alcove.fr ([212.155.209.139]:26633 "EHLO smtp.alcove.fr")
	by vger.kernel.org with ESMTP id <S266997AbRGIJfm>;
	Mon, 9 Jul 2001 05:35:42 -0400
To: rjd@xyzzy.clara.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: linux-2.4.7-pre3/drivers/char/sonypi.c would hang some non-Sony notebooks
In-Reply-To: <20010708174639.A7477@xyzzy.clara.co.uk>
In-Reply-To: <200107081026.DAA22119@baldur.yggdrasil.com> <20010708174639.A7477@xyzzy.clara.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15JXRa-0001Xb-00@come.alcove-fr>
From: Stelian Pop <stelian@alcove.fr>
Date: Mon, 09 Jul 2001 11:35:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In alcove.lists.linux.kernel, you wrote:

> > 	Yes, although that is a task that is never complete.  So, I
> > would recommend that we adopt a simple test that should work into the
> > stock kernels with the expectation that the test will probably be
> > refined in the future.  Perhaps we could check the Cardbus bridge.
> > Does "lspci -v" on your Sony Vaio indicate that its cardbus bridge
> > have a subsystem vendor ID of Sony?
> 
> OK. lspic -v shows
> 
>   CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
>   Subsystem: Sony Corporation: Unknown device 8082
> 
> Class 0x0607, vendor 0x1180, dev 0x0x0475, subv 0x104D, subd 0x8082
> 
> I guess that's a pretty safe signature if the other VAIO lap and
> palmtops have it.

Except for the subsystem's device ID. My C1VE shows for the cardbus
bridge:
	Class 0607: 1180:0475 (rev 80)
	Subsystem: 104d:80b1

I guess we'd better test for (class,vendor,dev,subsys vendor,ANY).

A much better solution would be using the DMI tables, but the 
implementation is not so immediate due to design problems (IMHO). See
my other post below.

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
