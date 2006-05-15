Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWEONpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWEONpg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 09:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWEONpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 09:45:36 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:19629 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S964908AbWEONpe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 09:45:34 -0400
Message-ID: <446885BE.4090404@ru.mvista.com>
Date: Mon, 15 May 2006 17:44:30 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide_dma_speed() fixes
References: <4463F4C8.9080608@ru.mvista.com> <20060514050548.5399e3f4.akpm@osdl.org>
In-Reply-To: <20060514050548.5399e3f4.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Andrew Morton wrote:

>>    ide_dma_speed() fails to actually honor the IDE drivers' mode support 
>> masks) because of the bogus checks -- thus, selecting the DMA transfer mode 
>> that the driver explicitly refuses to support is possible. Additionally, there 
>> is no check for validity of the UltraDMA mode data in the drive ID, and the 
>> function is misdocumented.

> drivers/ide/ide-lib.c: In function `ide_dma_speed':
> drivers/ide/ide-lib.c:86: warning: `ultra_mask' might be used uninitialized in this function

> Looks like a real bug to me - it depends up on the values of `mode' and
> id->field_value.

> Anyway, I'll drop it, please review and fix.  I assume that warning was
> occurring for you as well - please spend more time over these things. 
> Especially when working on IDE, where bugs are slow to show themselves and
> have particularly bad consequences.

    That's what gcc thinks. The code is 100% correct -- it will never reach 
the switch statement with mode > 0 (in which case ultra_mask isn't used) and 
ultra_mask unitialized. I may add an explicit initializer in the declaration 
if you like...

MBR, Sergei
