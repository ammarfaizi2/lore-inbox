Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTJ3U5y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 15:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTJ3U5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 15:57:53 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:20374 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262817AbTJ3U5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 15:57:51 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: davidm@hpl.hp.com, David Mosberger <davidm@napali.hpl.hp.com>,
       "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Date: Thu, 30 Oct 2003 13:57:17 -0700
User-Agent: KMail/1.5.3
Cc: <davidm@hpl.hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F36EB@scsmsx401.sc.intel.com> <16281.42485.151214.829243@napali.hpl.hp.com>
In-Reply-To: <16281.42485.151214.829243@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310301357.17124.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 October 2003 4:21 pm, David Mosberger wrote:
> >>>>> On Fri, 24 Oct 2003 15:16:59 -0700, "Luck, Tony" <tony.luck@intel.com> said:
>   >> Different arches behave differently, though.  In the case of ia64,
>   >> it'a always safe to prefetch (even with lfetch.fault).
> 
>   Tony> Not quite always ... this was how I found the efi trim.bottom
>   Tony> bug, since Linux had allocated a pgd at 0xa00000-16k, and the
>   Tony> lfetch that reached out beyond the end of the page to the
>   Tony> uncacheable address 0xa00000 took an MCA.
> 
> But don't confuse cause and effect!  The MCA was caused by a bad TLB
> entry.  The lfetch only triggered the latent bug (as might have a
> instruction-prefetch).

I'm assuming that the EFI memory map trim fixes prevent the bad
TLB entry, and hence, the prefetching patch is not required by ia64
in 2.4.  Tony, let me know if otherwise.

Bjorn

