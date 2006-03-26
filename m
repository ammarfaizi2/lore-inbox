Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWCZTCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWCZTCW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 14:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWCZTCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 14:02:22 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40925 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932116AbWCZTCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 14:02:21 -0500
Subject: Re: kernel BUG at arch/i386/mm/highmem.c:63! kunmap_atomic
From: Arjan van de Ven <arjan@infradead.org>
To: Anil kumar <anils_r@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060326174556.45649.qmail@web32404.mail.mud.yahoo.com>
References: <20060326174556.45649.qmail@web32404.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 21:02:19 +0200
Message-Id: <1143399739.3055.24.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 09:45 -0800, Anil kumar wrote:
> 
> Hi,
> 
> I get the following kernel panic,
> 
> kernel BUG at arch/i386/mm/highmem.c:63!
> EIP:    0060:[<c011af5a>]    Tainted: PF     VLI
> EFLAGS: 00010006   (2.6.11-1.1369_FC4smp)
> EIP is at kunmap_atomic+0x35/0x5f
> 
> The following is the code, I am using in my driver:
> 
> kmap_atomic code:
> 
> int hr_km_type = (in_interrupt())? KM_IRQ0: KM_USER0;
>          pDataBuffer = kmap_atomic(cur_seg->page,
> hr_km_type) + cur_seg->offset;
>          if(pDataBuffer == NULL) {
>             return (ENOMEM);
>          }
> 

this is buggy; your irq handler may run with interrupts on for example

I fear the worst for your code ;) I would suggest getting more people to
review it (for example on kernel-newbies list or the kernel-mentors
list) before using it in production ;)

