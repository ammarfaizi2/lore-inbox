Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965541AbWKDUG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965541AbWKDUG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965607AbWKDUG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:06:57 -0500
Received: from hosting.zipcon.net ([209.221.136.3]:42406 "EHLO
	hosting.zipcon.net") by vger.kernel.org with ESMTP id S965541AbWKDUG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:06:56 -0500
Message-ID: <454CF2DD.40803@beezmo.com>
Date: Sat, 04 Nov 2006 12:06:53 -0800
From: William D Waddington <william.waddington@beezmo.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IRQ: ease out-of-tree migration to new irq_handler prototype
References: <454CDC11.5030708@beezmo.com> <20061104190357.GA4971@martell.zuzino.mipt.ru>
In-Reply-To: <20061104190357.GA4971@martell.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hosting.zipcon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - beezmo.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> On Sat, Nov 04, 2006 at 10:29:37AM -0800, William D Waddington wrote:
> 
>>Ease out-of-tree driver migration to new irq_handler prototype.
>>Define empty 3rd argument macro for use in multi kernel version
>>out-of-tree drivers going forward.  Backportable drives can do:
>>
>>(in a header)
>>#ifndef __PT_REGS
>># define __PT_REGS , struct pt_regs *regs
>>#endif
> 
> 
> Backportable drivers should check kernel version themselves and define
> __PT_REGS themselves.

I think I provided too much information :(  It would be sufficiently
helpful to just #define __PT_REGS <nothing> in  interrupt.h to make
things easier for low-life out-of-tree maintainers.  There isn't any
need to actualy detect version.  Just detect __PT_REGS already defined.

The "in a header" above referred to the driver's header - #ifdefs in
executable code really looks nasty IMHO.

The "#define __PT_REGS , ..." comment below was intended to be a
"helpful" note to driver writers.  Like I said, TMI.

>>(in code body)
>>static irqreturn_t irq_handler(int irq, void *dev_id __PT_REGS)
> 
> 
>>+/*
>>+ * Irq handler migration helper - empty 3rd argument
>>+ * #define __PT_REGS , struct pt_regs *regs
>>+ * for older kernel versions
>>+ */
>>+
>>+#define __PT_REGS

How should I tidy this up - if it is acceptable at all?  I'm a
total noob struggling with a 1-line patch.

Bill
-- 
--------------------------------------------
William D Waddington
Bainbridge Island, WA, USA
william.waddington@beezmo.com
--------------------------------------------
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch
