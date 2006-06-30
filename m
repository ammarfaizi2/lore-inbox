Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751829AbWF3SAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829AbWF3SAh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 14:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWF3SAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 14:00:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55479 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751837AbWF3SAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 14:00:35 -0400
Date: Fri, 30 Jun 2006 11:00:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: andi@rhlx01.fht-esslingen.de, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] ide_end_drive_cmd(): avoid instruction pipeline
 stall
Message-Id: <20060630110018.f45b40e2.akpm@osdl.org>
In-Reply-To: <1151688416.31392.66.camel@localhost.localdomain>
References: <20060630161351.GA17434@rhlx01.fht-esslingen.de>
	<1151688416.31392.66.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 18:26:56 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> Ar Gwe, 2006-06-30 am 18:13 +0200, ysgrifennodd Andreas Mohr:
> > Use an independently-formatted "unsigned int" for data instead of a
> > restrictive "u16" to avoid instruction fetch pipeline stalls
> > probably caused by the byte calculations later.
> 
> drivers/ide is on its way out.

Like sound/oss ;)

> I'm also curious that this shows up given
> that the inw() is going to cause a PCI sequence and stall the CPU
> entirely for ages anyway.

I guess because he was profiling for IFU_MEM_STALL, not for wall-time.

> NAK because
> 1. This is a gcc problem
> 2. Not everyone is using an intel x86-32 box which has such problems
> 3. IDE is in life-support mode and the relatives are already planning
> the flowers.

Well.  If the patch breaks anything we can dine on hats for a month.  Seems
pretty inoffensive to me.

