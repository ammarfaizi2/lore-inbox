Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751761AbWFVHLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWFVHLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 03:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWFVHLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 03:11:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7814 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751761AbWFVHLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 03:11:21 -0400
Date: Thu, 22 Jun 2006 00:11:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: alesan@manoweb.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: [PATCH] cardbus: revert IO window limit
Message-Id: <20060622001104.9e42fc54.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 09:48:05 +0300 (EEST)
Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch reverts commit 4196c3af25d98204216a5d6c37ad2cb303a1f2bf "cardbus:
> limit IO windows to 256 bytes" which breaks Alessio Sangalli's machine boot
> when APM support is enabled. See http://lkml.org/lkml/2006/6/16/33 for
> description of the problem.
> 
> Cc: Alessio Sangalli <alesan@manoweb.com>
> Cc: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
> ---
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 28ce3a7..657be94 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -40,7 +40,7 @@ #define ROUND_UP(x, a)		(((x) + (a) - 1)
>   * FIXME: IO should be max 256 bytes.  However, since we may
>   * have a P2P bridge below a cardbus bridge, we need 4K.
>   */
> -#define CARDBUS_IO_SIZE		(256)
> +#define CARDBUS_IO_SIZE		(4*1024)
>  #define CARDBUS_MEM_SIZE	(32*1024*1024)
>  
>  static void __devinit

There is something bad happening in there.  Presumably, this patch will
break the ThinkPad 600x series machines again though.

It'd be nice if this was related to
http://bugzilla.kernel.org/show_bug.cgi?id=6725, but I guess not.

Didn't all this stuff work in 2.4?
