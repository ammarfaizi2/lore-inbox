Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUIMAbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUIMAbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUIMAbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 20:31:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:53951 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264389AbUIMAbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 20:31:17 -0400
Date: Sun, 12 Sep 2004 17:30:18 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: alan@lxorguk.ukuu.org.uk, drivers@neukum.org, marcelo.tosatti@cyclades.com,
       sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH][2.4.28-pre3] USB drivers gcc-3.4 fixes
Message-Id: <20040912173018.44b9902f@lembas.zaitcev.lan>
In-Reply-To: <200409121129.i8CBT5Bo015222@harpo.it.uu.se>
References: <200409121129.i8CBT5Bo015222@harpo.it.uu.se>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004 13:29:05 +0200 (MEST)
Mikael Pettersson <mikpe@csd.uu.se> wrote:

> This patch fixes gcc-3.4 cast-as-lvalue warnings in the 2.4.28-pre3
> kernel's USB drivers. The audio.c and uss720.c changes are backports
> from the 2.6 kernel. The hpusbscsi.c and microtek.c changes are new,
> since the 2.6 code is different.

> +++ linux-2.4.28-pre3/drivers/usb/audio.c	2004-09-12 01:56:20.000000000 +0200
> @@ -609,7 +609,7 @@
>  		size -= pgrem;
> -		(char *)buffer += pgrem;
> +		buffer += pgrem;

I'm pretty sure it's done that way on purpose. There were compilers which
did not allow any arithmetics on void*, and it had to be cast to char*.
So perhaps it's correct for 2.6, which requires gcc 3 anyway, but I have
my doubts about applicability of this to 2.4.

-- Pete
