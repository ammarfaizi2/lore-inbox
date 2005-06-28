Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261280AbVF1LAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVF1LAo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVF1LAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:00:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261293AbVF1LAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:00:25 -0400
Date: Tue, 28 Jun 2005 03:56:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: "d binderman" <dcb314@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: array subscript out of range
Message-Id: <20050628035638.41fd4004.akpm@osdl.org>
In-Reply-To: <BAY19-F255ACFD14A7CB3309260039CE10@phx.gbl>
References: <BAY19-F255ACFD14A7CB3309260039CE10@phx.gbl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"d binderman" <dcb314@hotmail.com> wrote:
>
> Hello there,
> 
> I just tried to compile the Linux Kernel version 2.6.11.12
> with the most excellent Intel C compiler. It said
> 
> drivers/media/video/bt819.c(239): warning #175: subscript out of range
>     init[0x19*2-1] = decoder->norm == 0 ? 115 : 93; /* Chroma burst delay */
>         ^
> 
> This is clearly broken code, since the init data is declared
> with 44 elements, but the index is for number 49.
> 
> Suggest code rework.

Was fixed.


From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>

Signed-off-by: Ronald S. Bultje <rbultje@ronald.bitfreak.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/media/video/bt819.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN drivers/media/video/bt819.c~bt819-array-indexing-fix drivers/media/video/bt819.c
--- 25/drivers/media/video/bt819.c~bt819-array-indexing-fix	2005-03-28 14:21:43.000000000 -0800
+++ 25-akpm/drivers/media/video/bt819.c	2005-03-28 14:21:44.000000000 -0800
@@ -236,7 +236,8 @@ bt819_init (struct i2c_client *client)
 	init[0x07 * 2 - 1] = timing->hactive & 0xff;
 	init[0x08 * 2 - 1] = timing->hscale >> 8;
 	init[0x09 * 2 - 1] = timing->hscale & 0xff;
-	init[0x19*2-1] = decoder->norm == 0 ? 115 : 93;	/* Chroma burst delay */
+	/* 0x15 in array is address 0x19 */
+	init[0x15 * 2 - 1] = (decoder->norm == 0) ? 115 : 93;	/* Chroma burst delay */
 	/* reset */
 	bt819_write(client, 0x1f, 0x00);
 	mdelay(1);
_

