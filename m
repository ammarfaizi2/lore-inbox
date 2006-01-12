Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWALAbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWALAbD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbWALAbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:31:01 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:51177 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964857AbWALAa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:30:56 -0500
Date: Thu, 12 Jan 2006 01:30:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@davemloft.net>
Cc: pavel@suse.cz, arjan@infradead.org, akpm@osdl.org, ak@suse.de,
       linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: 2.6.15-git7 oopses in ext3 during LTP runs
Message-ID: <20060112003058.GA2681@elte.hu>
References: <20060111130728.579ab429.akpm@osdl.org> <1137014875.2929.81.camel@laptopd505.fenrus.org> <20060111224013.GA8277@elf.ucw.cz> <20060111.144422.48199200.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111.144422.48199200.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David S. Miller <davem@davemloft.net> wrote:

> From: Pavel Machek <pavel@suse.cz>
> Date: Wed, 11 Jan 2006 23:40:13 +0100
> 
> > likely is the evil part here. What about this? Should make this bug
> > impossible to do....
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>
> 
> This doesn't let you do:
> 
>      if (likely(y) || unlikely(x))

hm, why not? It will expand to:

   if ((__builtin_expect(!!(y), 1)) || (__builtin_expect(!!(x), 0)))

which seems correct to me. Pavel only added extra parantheses, to make 
the simple case more readable.

	Ingo
