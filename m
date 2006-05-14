Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWENMJC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWENMJC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 08:09:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWENMJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 08:09:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37860 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751404AbWENMJA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 08:09:00 -0400
Date: Sun, 14 May 2006 05:05:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide_dma_speed() fixes
Message-Id: <20060514050548.5399e3f4.akpm@osdl.org>
In-Reply-To: <4463F4C8.9080608@ru.mvista.com>
References: <4463F4C8.9080608@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergei Shtylyov <sshtylyov@ru.mvista.com> wrote:
>
>     ide_dma_speed() fails to actually honor the IDE drivers' mode support 
>  masks) because of the bogus checks -- thus, selecting the DMA transfer mode 
>  that the driver explicitly refuses to support is possible. Additionally, there 
>  is no check for validity of the UltraDMA mode data in the drive ID, and the 
>  function is misdocumented.

drivers/ide/ide-lib.c: In function `ide_dma_speed':
drivers/ide/ide-lib.c:86: warning: `ultra_mask' might be used uninitialized in this function

Looks like a real bug to me - it depends up on the values of `mode' and
id->field_value.

Anyway, I'll drop it, please review and fix.  I assume that warning was
occurring for you as well - please spend more time over these things. 
Especially when working on IDE, where bugs are slow to show themselves and
have particularly bad consequences.
