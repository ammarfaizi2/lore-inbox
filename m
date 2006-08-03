Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWHCVQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWHCVQP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWHCVQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:16:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:41555 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932161AbWHCVQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:16:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=gjZQ+oVzICLtr4Jax5qZST7SCaAipQnfOQMp8YjHuMYGsnCvai29KYK8TP8XuhOGV6e+P9sFuKPwqI24CARdgoVdqSHzvxpc3I2gj3IuERKP2DBhRhEI6fmVqbGcaEOcMVzx5XNuEyqIWY+bw1Snq8k+FQAQo4ThBxLAbWKuAqE=
Date: Fri, 4 Aug 2006 01:16:09 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Armin Schindler <mac@melware.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eicon: fix define conflict with ptrace
Message-ID: <20060803211609.GC6828@martell.zuzino.mipt.ru>
References: <20060803203411.GB6828@martell.zuzino.mipt.ru> <1154639399.23655.129.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1154639399.23655.129.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 10:09:59PM +0100, Alan Cox wrote:
> Ar Gwe, 2006-08-04 am 00:34 +0400, ysgrifennodd Alexey Dobriyan:
> > * MODE_MASK is unused in eicon driver.
> > * Conflicts with a ptrace stuff on arm.
> >
> > drivers/isdn/hardware/eicon/divasync.h:259:1: warning: "MODE_MASK" redefined
> > include2/asm/ptrace.h:48:1: warning: this is the location of the previous definition

> NAK. You need to fix all the code expecting to use the MODE_MASK with a
> value of 0x00000080

OK, I understood. However, judging by tiny amount of indentation¹ this
define should be used when messing with "Flag" field

	unsigned long Flag;     /* |31-Type-16|15-Mask-0| */

of struct (typedef, actually) called "isdnProps". Other defines nearby
are unused also. More, "isdnProps" which is typedef holding this field in
turn, is also unused.

¹ Even less than GNU.

