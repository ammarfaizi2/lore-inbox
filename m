Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbUBWOS2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 09:18:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUBWOS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 09:18:28 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:19162 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261864AbUBWOS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 09:18:26 -0500
Date: Mon, 23 Feb 2004 15:18:15 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Flushing the Queue after PG REALLY a Necessity?
Message-ID: <20040223151815.GA403@zaniah>
References: <c16rdh$gtk$1@terminus.zytor.com> <4039D599.7060001@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4039D599.7060001@greatcn.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Feb 2004 at 18:27 +0000, Coywolf Qi Hunt wrote:

> H. Peter Anvin wrote:
> 
> >Anyone happen to know of any legitimate reason not to reload %cs in
> >head.S?  I think the following would be a lot cleaner, as well as a
> >lot safer (the jump and indirect branch aren't guaranteed to have the
> >proper effects, although technically neither should be required due to
> >the %cr0 write):

jump is sufficent when setting PG and required with cpu where cr0 write
does not serialize.

> Anyone happen to know of any legitimate reason to flush the prefetch
> queue after enabling paging?
> 
> I've read the intel manual volume 3 thoroughly. It only says that after
> entering protected mode, flushing is required, but never says
> specifically about whether to do flushing after enabling paging.
> 
> Furthermore the intel example code enables protected mode and paging at
> the same time. So does FreeBSD. There's really no more references to check.
> 
>  From the cpu's internal view, flushing for PE is to flush the prefetch
> queue as well as re-load the %cs, since the protected mode is just about
> to begin. But no reason to flushing for PG, since linux maps the
> addresses *identically*.
> 
> If no any reason, please remove the after paging flushing queue code,
> two near jump.

See IA32 vol 3  7.4 and 18.27.3

Anyway this code is known to work on dozen of intel/non intel processor,
how can you know if changing this code will not break an obscure clone ?

regards,
Phil

