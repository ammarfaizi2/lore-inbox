Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbWCVVpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWCVVpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 16:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932804AbWCVVpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 16:45:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:63874 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751271AbWCVVpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 16:45:39 -0500
Date: Wed, 22 Mar 2006 13:45:56 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 19/35] subarch support for control register accesses
Message-ID: <20060322214556.GK15997@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063754.391952000@sorel.sous-sol.org> <442110F0.9090805@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442110F0.9090805@vmware.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Chris Wright wrote:
> >+#define read_cr4_safe() ({			      \
> >+	unsigned int __dummy;			      \
> >+	/* This could fault if %cr4 does not exist */ \
> >+	__asm__("1: movl %%cr4, %0		\n"   \
> >+		"2:				\n"   \
> >+		".section __ex_table,\"a\"	\n"   \
> >+		".long 1b,2b			\n"   \
> >+		".previous			\n"   \
> >+		: "=r" (__dummy): "0" (0));	      \
> >+	__dummy;				      \
> >+})
> 
> I think you'll find trap and emulate quite sufficient for this one.

Heh ;-)

> >+#define stts() write_cr0(8 | read_cr0())
> >  
> 
> Nit: You shouldn't need to redefine stts() in the subarch.

Yes, you're right, better to keep things consolidated.
