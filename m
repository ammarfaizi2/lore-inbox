Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263204AbUGICUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbUGICUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 22:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUGICUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 22:20:25 -0400
Received: from 234.69-93-232.reverse.theplanet.com ([69.93.232.234]:51875 "EHLO
	urbanisp01.urban-isp.net") by vger.kernel.org with ESMTP
	id S263204AbUGICUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 22:20:17 -0400
From: "Shai Fultheim" <shai@scalex86.org>
To: "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <mort@wildopensource.com>,
       <jes@wildopensource.com>
Subject: RE: [PATCH] PER_CPU [3/4] - PER_CPU-init_tss
Date: Thu, 8 Jul 2004 19:20:11 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040708190810.7940ee97.akpm@osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2142
Thread-Index: AcRlWbGjIsuDUcwGQBGexX6Ka8xGngAALtaA
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - urbanisp01.urban-isp.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Message-Id: <S263204AbUGICUR/20040709022017Z+15@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think you have to worry about this.

Ring 1 is never used by Linux so the ss1 and esp1 are NOT used for their real purpose in the task struct.  Instead, data is put
there to be used later for setting up sysenter/sysexit in the 'enable_sep_cpu' (arch/i386/kernel/sysenter.c) function.  So, the
initialization is really unimportant.

I suggest you'll 'grep' the kernel for esp1 (I did that). It has no other usage other than (as said) setting up the
sysenter/sysexit. 

Let me know if that’s helps.

Thanks !
 
-----------------
Shai Fultheim
Scalex86.org


> -----Original Message-----
> From: Andrew Morton [mailto:akpm@osdl.org]
> Sent: Thursday, July 08, 2004 19:08
> To: Shai Fultheim
> Cc: linux-kernel@vger.kernel.org; mort@wildopensource.com; jes@wildopensource.com
> Subject: Re: [PATCH] PER_CPU [3/4] - PER_CPU-init_tss
> 
> "Shai Fultheim" <shai@scalex86.org> wrote:
> >
> >  #define INIT_TSS  {							\
> >   	.esp0		= sizeof(init_stack) + (long)&init_stack,	\
> >   	.ss0		= __KERNEL_DS,					\
> >  -	.esp1		= sizeof(init_tss[0]) + (long)&init_tss[0],	\
> >   	.ss1		= __KERNEL_CS,					\
> >   	.ldt		= GDT_ENTRY_LDT,				\
> >   	.io_bitmap_base	= INVALID_IO_BITMAP_OFFSET,			\
> 
> Why this change?  Is it safe?
> 


