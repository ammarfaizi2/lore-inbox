Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269378AbUIIJTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269378AbUIIJTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 05:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269379AbUIIJTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 05:19:18 -0400
Received: from [195.23.16.24] ([195.23.16.24]:11460 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S269378AbUIIJTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 05:19:08 -0400
Message-ID: <4140200B.9060408@grupopie.com>
Date: Thu, 09 Sep 2004 10:19:07 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What File System supports Application XIP
References: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
In-Reply-To: <009901c4964a$be2468e0$8b1a13ac@realtek.com.tw>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.51; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

colin wrote:
> 
> Hi there,
> We are developing embedded Linux system. Performance is our consideration.
> We hope some applications can run as fast as possible,
> and are think if they can be put in a filesystem image, which resides in
> RAM, and run in XIP (eXecute In Place)  manners.
> I know that Cramfs has supported Application XIP. Is there any other FS that
> also supports it? Ramdisk? Ramfs? Romfs?

Obvisously cramfs can not support XIP, because the "in-place" image
is compressed (unless you have a processor that can execute compressed
code :)

AFAIK only tmpfs supports XIP because it works on a higher level
without using block devices underneath. Ramdisks are simply RAM
block devices that behave like any other block device.

You can have a compressed image in flash (for instance), decompress
everything into a tmpfs and execute from there.

I'm not sure, however, that this will be such a performance gain.

If you use cramfs (for instance) then the kernel will uncompress
and run only the pages that are needed, and they will be cached in
page cache so that they will be available again when needed. This
way you only waste the RAM you actually need, and can still drop
old pages if the application needs more RAM.

Just my two cents,

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
