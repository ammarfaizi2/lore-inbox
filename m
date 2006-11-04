Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753587AbWKDTEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbWKDTEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 14:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753594AbWKDTEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 14:04:05 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:43208 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1753587AbWKDTEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 14:04:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=oaC4wO2fzOQpL10FqThAzFPnJjHAqZ1a+ANnlmpQmjnQfj9krLoF/sbm4OR3k02yeq3EOqHoOeuOjjWbdlzVgRlOobSUsT6kX7TygaOv+4R9WqJq8HYpoaIqOwAgV6QHuSAXCqxDEOKTGuxRkIy6F2tjU31UHxiDiSOCcpRn9Ac=
Date: Sat, 4 Nov 2006 22:03:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: William D Waddington <william.waddington@beezmo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IRQ: ease out-of-tree migration to new irq_handler prototype
Message-ID: <20061104190357.GA4971@martell.zuzino.mipt.ru>
References: <454CDC11.5030708@beezmo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454CDC11.5030708@beezmo.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2006 at 10:29:37AM -0800, William D Waddington wrote:
> Ease out-of-tree driver migration to new irq_handler prototype.
> Define empty 3rd argument macro for use in multi kernel version
> out-of-tree drivers going forward.  Backportable drives can do:
>
> (in a header)
> #ifndef __PT_REGS
> # define __PT_REGS , struct pt_regs *regs
> #endif

Backportable drivers should check kernel version themselves and define
__PT_REGS themselves.

> (in code body)
> static irqreturn_t irq_handler(int irq, void *dev_id __PT_REGS)

> +/*
> + * Irq handler migration helper - empty 3rd argument
> + * #define __PT_REGS , struct pt_regs *regs
> + * for older kernel versions
> + */
> +
> +#define __PT_REGS

