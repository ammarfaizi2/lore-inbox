Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262635AbVCXQ4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262635AbVCXQ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 11:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbVCXQ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 11:56:16 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:39631 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262635AbVCXQ4O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 11:56:14 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
Date: Thu, 24 Mar 2005 08:54:45 -0800
User-Agent: KMail/1.7.2
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
References: <1111645464.5569.15.camel@gaston>
In-Reply-To: <1111645464.5569.15.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240854.45741.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 23, 2005 10:24 pm, Benjamin Herrenschmidt wrote:
> While experimenting with framebuffer access performances, we noticed a
> very significant improvement in write access to it when not setting
> the "guarded" bit on the MMU mappings. This bit basically says that
> reads and writes won't have side effects (it allows speculation). It
> appears that it also disables write combining.

Doesn't pgprot_writecombine imply non-guarded, so can't you use it instead?  
Either way, you'll probably want to fix fbmem.c as well and turn off 
_PAGE_GUARDED?

Maybe it's time for a more generic call to support this stuff, both for 
in-kernel mappings and ones that we export to userspace.

Jesse
