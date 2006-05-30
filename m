Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWE3Bdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWE3Bdt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 21:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWE3Bcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 21:32:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12225 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932109AbWE3BcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 21:32:01 -0400
Date: Mon, 29 May 2006 18:36:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch 52/61] lock validator: special locking: af_unix
Message-Id: <20060529183608.19308b7c.akpm@osdl.org>
In-Reply-To: <20060529212719.GZ3155@elte.hu>
References: <20060529212109.GA2058@elte.hu>
	<20060529212719.GZ3155@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 23:27:19 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> teach special (recursive) locking code to the lock validator. Has no
> effect on non-lockdep kernels.
> 
> (includes workaround for sk_receive_queue.lock, which is currently
> treated globally by the lock validator, but which be switched to
> per-address-family locking rules.)
> 
> ...
>
>  
> -			spin_lock(&sk->sk_receive_queue.lock);
> +			spin_lock_bh(&sk->sk_receive_queue.lock);

Again, a bit of a show-stopper.  Will the real fix be far off?
