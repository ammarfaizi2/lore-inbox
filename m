Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWCGDUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWCGDUs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 22:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbWCGDUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 22:20:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2211 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751080AbWCGDUs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 22:20:48 -0500
Date: Mon, 6 Mar 2006 19:20:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Mike Christie <michaelc@cs.wisc.edu>
cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, markhe@nextd.demon.co.uk, andrea@suse.de,
       James.Bottomley@steeleye.com, axboe@suse.de, penberg@cs.helsinki.fi
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
In-Reply-To: <440CFABF.5040403@cs.wisc.edu>
Message-ID: <Pine.LNX.4.64.0603061917330.3573@g5.osdl.org>
References: <200603060117.16484.jesper.juhl@gmail.com> 
 <9a8748490603061253u5e4d7561vd4e566f5798a5f4@mail.gmail.com> 
 <9a8748490603061256h794c5af9wa6fbb616e8ddbd89@mail.gmail.com> 
 <Pine.LNX.4.64.0603061306300.13139@g5.osdl.org> 
 <9a8748490603061354vaa53c72na161d26065b9302e@mail.gmail.com> 
 <Pine.LNX.4.64.0603061402410.13139@g5.osdl.org>  <Pine.LNX.4.64.0603061423160.13139@g5.osdl.org>
  <Pine.LNX.4.64.0603061445350.13139@g5.osdl.org> 
 <9a8748490603061501r387291f0ha10e9e9fe3c9e060@mail.gmail.com> 
 <20060306150612.51f48efa.akpm@osdl.org> <9a8748490603061524j616bf6b3i1b6ab5354bcfe1a9@mail.gmail.com>
 <440CFABF.5040403@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Mar 2006, Mike Christie wrote:
> -       buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
> +       buffer = kzalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
>         if (!buffer)
>                 return -ENOMEM;
> 
> -       memset(&cgc, 0, sizeof(struct packet_command));
...
> -       buffer = kmalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
> +       buffer = kzalloc(32, GFP_KERNEL | SR_GFP_DMA(cd));
>         if (!buffer)
>                 return -ENOMEM;
> 
> -       memset(&cgc, 0, sizeof(struct packet_command));

> When someone converted the *buffer* allocation to kzalloc they
> also removed the the memset for the *packet_cmmand* struct.
> 
> The
> 
> memset(&cgc, 0, sizeof(struct packet_command));
> 
> should be added back I think.

Good eyes. I bet that's it.

		Linus
