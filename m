Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUBUQcY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 11:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbUBUQcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 11:32:24 -0500
Received: from mail.shareable.org ([81.29.64.88]:37249 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261304AbUBUQcX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 11:32:23 -0500
Date: Sat, 21 Feb 2004 16:32:13 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: BOOT_CS
Message-ID: <20040221163213.GB15991@mail.shareable.org>
References: <c16rdh$gtk$1@terminus.zytor.com> <40375261.6030705@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40375261.6030705@greatcn.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> >(the jump and indirect branch aren't guaranteed to have the
> >proper effects, although technically neither should be required due to
> >the %cr0 write):
>
> 
> IMHO, why bother to re-reload %cs again?
> 
> In setup.S, %cs is reloaded already. The enable paging code maps the
> address identically, so %cs already contains the proper selector.

It's to flush the instruction prefetch queue: that's one of the side
effects of ljmp.

I recall an Intel manual that said ljmp is required when switching
between real and protected modes, to flush the prefetch queue.

Unfortunately I don't remember what that manual said about just setting PG.

I'd guess that current generation CPUs don't care about ljmp when
changing modes, but older ones certainly do.

-- Jamie
