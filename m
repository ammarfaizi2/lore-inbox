Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVEXCcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVEXCcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 22:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVEXCcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 22:32:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:41910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261303AbVEXCc2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 22:32:28 -0400
Date: Mon, 23 May 2005 19:31:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       davem@davemloft.net, jmorris@redhat.com
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
Message-Id: <20050523193116.62844826.akpm@osdl.org>
In-Reply-To: <20050524022106.GA29081@gondor.apana.org.au>
References: <200505232300.j4NN07lE012726@hera.kernel.org>
	<20050523162806.0e70ae4f.akpm@osdl.org>
	<20050524022106.GA29081@gondor.apana.org.au>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Perhaps we should code this into the crypto API instead? For instance,
>  we can have a tfm flag that says whether we can sleep or not.

Are you sure it's actually needed? Have significant scheduling latencies
actually been observed?

Bear in mind that anyone who cares a lot about latency will be running
CONFIG_PREEMPT kernels, in which case the whole thing is redundant anyway. 
I generally take the position that if we're going to put a scheduling point
into a non-premept kernel then it'd better be for a pretty bad latency
point - more than 10 milliseconds, say.

