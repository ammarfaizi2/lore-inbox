Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWEIPPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWEIPPT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 11:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWEIPPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 11:15:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13719 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932395AbWEIPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 11:15:18 -0400
Date: Tue, 9 May 2006 16:15:16 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 03/35] Add Xen interface header files
Message-ID: <20060509151516.GA16332@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
	Ian Pratt <ian.pratt@xensource.com>,
	Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
References: <20060509084945.373541000@sous-sol.org> <20060509085147.903310000@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509085147.903310000@sous-sol.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> ---
>  include/xen/interface/arch-x86_32.h   |  197 +++++++++++++++

that kind of stuff needs to go to asm/

>  include/xen/interface/event_channel.h |  205 +++++++++++++++

instead of interface please use something shorter, we'll see this
all over the includes statements.  intf for example.

> +#ifdef __XEN__
> +#define __DEFINE_GUEST_HANDLE(name, type) \
> +    typedef struct { type *p; } __guest_handle_ ## name
> +#else
> +#define __DEFINE_GUEST_HANDLE(name, type) \
> +    typedef type * __guest_handle_ ## name
> +#endif

please get rid of all these stupid typedefs

> +#ifndef __ASSEMBLY__
> +/* Guest handles for primitive C types. */
> +__DEFINE_GUEST_HANDLE(uchar, unsigned char);
> +__DEFINE_GUEST_HANDLE(uint,  unsigned int);
> +__DEFINE_GUEST_HANDLE(ulong, unsigned long);

don't use uchar/uint/ulong types ever.  And in things like
hypervisor/kernel interfaces always use __u* types.

