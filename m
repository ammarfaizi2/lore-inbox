Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751123AbWCVIzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbWCVIzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWCVIzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:55:15 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:59402 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751123AbWCVIzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:55:13 -0500
Message-ID: <442110F0.9090805@vmware.com>
Date: Wed, 22 Mar 2006 00:55:12 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 19/35] subarch support for control register accesses
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063754.391952000@sorel.sous-sol.org>
In-Reply-To: <20060322063754.391952000@sorel.sous-sol.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> +#define read_cr4_safe() ({			      \
> +	unsigned int __dummy;			      \
> +	/* This could fault if %cr4 does not exist */ \
> +	__asm__("1: movl %%cr4, %0		\n"   \
> +		"2:				\n"   \
> +		".section __ex_table,\"a\"	\n"   \
> +		".long 1b,2b			\n"   \
> +		".previous			\n"   \
> +		: "=r" (__dummy): "0" (0));	      \
> +	__dummy;				      \
> +})

I think you'll find trap and emulate quite sufficient for this one.

> +#define stts() write_cr0(8 | read_cr0())
>   

Nit: You shouldn't need to redefine stts() in the subarch.
