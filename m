Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267826AbUJMTs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267826AbUJMTs3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 15:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJMTs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 15:48:29 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:388 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S269758AbUJMTd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 15:33:26 -0400
Date: Wed, 13 Oct 2004 23:32:47 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org,
       linux-alpha@vger.kernel.org
Subject: Re: 2.4.27, alpha arch, make bootimage and make bootpfile fails
Message-ID: <20041013233247.A11663@jurassic.park.msu.ru>
References: <20041012173344.GA21846@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041012173344.GA21846@gamma.logic.tuwien.ac.at>; from preining@logic.at on Tue, Oct 12, 2004 at 07:33:44PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 07:33:44PM +0200, Norbert Preining wrote:
> When doing this on our alpha the
> 	make bootimage
> and the 
> 	make bootpfile
> both bail out with:
...
> /usr/src/linux-2.4.27/arch/alpha/lib/lib.a -o bootloader
> /usr/src/linux-2.4.27/lib/lib.a(vsprintf.o): In function `vsnprintf':
> vsprintf.o(.text+0xcd4): undefined reference to `printk'

Thanks for the report. The appended patch should fix that.

Ivan.

--- 2.4/arch/alpha/boot/bootloader.lds	Tue Jul  3 01:40:14 2001
+++ linux/arch/alpha/boot/bootloader.lds	Wed Oct 13 23:18:50 2004
@@ -1,5 +1,6 @@
 OUTPUT_FORMAT("elf64-alpha")
 ENTRY(__start)
+printk = srm_printk;
 SECTIONS
 {
   . = 0x20000000;
