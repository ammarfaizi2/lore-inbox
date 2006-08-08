Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030186AbWHHQeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030186AbWHHQeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 12:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWHHQeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 12:34:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20638 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030186AbWHHQeY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 12:34:24 -0400
Date: Tue, 8 Aug 2006 09:34:00 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Kprobes: Make kprobe modules more portable
Message-ID: <20060808093400.5f023ea6@localhost.localdomain>
In-Reply-To: <20060808162421.GA28647@infradead.org>
References: <20060807115537.GA15253@in.ibm.com>
	<20060808162421.GA28647@infradead.org>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2006 17:24:21 +0100
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Aug 07, 2006 at 05:25:37PM +0530, Ananth N Mavinakayanahalli wrote:
> > From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
> > 
> > This patch introduces KPROBE_ADDR, a macro that abstracts out the
> > architecture-specific artefacts of getting the correct text address
> > given a symbol. While we are at it, also introduce the symbol_name field
> > in struct kprobe to allow for users to just specify the address to be
> > probed in terms of the kernel symbol. In-kernel kprobes infrastructure
> > decodes the actual text address to probe. The symbol resolution happens
> > only if the kprobe.addr isn't explicitly specified.
> 
> This looks good.  A few issues are left:
> 
>  - the KPROBE_ADDR macro is all uppercase and not exactly very descriptive.
>  - the symbol name variant should be the default, and no one outside
>    kprobes.c should know about the KPROBE_ADDR macro
>  - we should return EINVAL instead of silently discarding things if people
>    specify a symbol and an address.
>  - we should have and offset into the symbol specified
> 
> The updated patch below does that, aswell as updating the only inkernel
> kprobes user (tcp_probe.c) to the new interface (*) and removing the now
> obsolete kallsysms_lookup_name export.
> 
> (*) tcp_probe.c shows very well how horrible the old interface was, as it's
>     not portable to ppc64 as-is

Okay, does this makes kprobe's the first reflective kernel interface.
Watch out or it end up like JNI!
