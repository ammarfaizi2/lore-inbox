Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbUKKLWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbUKKLWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbUKKLUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:20:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:58256 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262216AbUKKLNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:13:32 -0500
Date: Thu, 11 Nov 2004 03:13:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Brice.Goglin@ens-lyon.org
Cc: Brice.Goglin@ens-lyon.fr, linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm5
Message-Id: <20041111031319.72135a68.akpm@osdl.org>
In-Reply-To: <419342D9.6060009@ens-lyon.fr>
References: <20041111012333.1b529478.akpm@osdl.org>
	<419342D9.6060009@ens-lyon.fr>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.fr> wrote:
>
>     LD      .tmp_vmlinux1
>  drivers/built-in.o(.text+0x1c5a4): In function `fbcon_set_font':
>  : undefined reference to `crc32_le'

I guess we do it this way:


--- 25/drivers/video/console/Kconfig~fbdev-fix-for-using-16-pixel-wide-font-in-fb-console-config-fix	2004-11-11 03:11:32.464948904 -0800
+++ 25-akpm/drivers/video/console/Kconfig	2004-11-11 03:12:00.013760848 -0800
@@ -105,6 +105,7 @@ config DUMMY_CONSOLE
 config FRAMEBUFFER_CONSOLE
 	tristate "Framebuffer Console support"
 	depends on FB
+	select CRC32
 
 config FONTS
 	bool "Select compiled-in fonts"
_

