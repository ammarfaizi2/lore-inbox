Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWDYDR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWDYDR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWDYDR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:17:27 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:44260 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751011AbWDYDR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:17:27 -0400
Subject: Re: [PATCH] Profile likely/unlikely macros
From: Daniel Walker <dwalker@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hzhong@gmail.com
In-Reply-To: <20060424200657.0af43d6a.akpm@osdl.org>
References: <200604250257.k3P2vlEb012502@dwalker1.mvista.com>
	 <20060424200657.0af43d6a.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 20:17:25 -0700
Message-Id: <1145935045.3674.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 20:06 -0700, Andrew Morton wrote:
> Daniel Walker <dwalker@mvista.com> wrote:
> >
> >  +	if (likeliness->type & LIKELY_UNSEEN) {
> >  +		if (atomic_dec_and_test(&likely_lock)) {
> >  +			if (likeliness->type & LIKELY_UNSEEN) {
> >  +				likeliness->type &= (~LIKELY_UNSEEN);
> >  +				likeliness->next = likeliness_head;
> >  +				likeliness_head = likeliness;
> >  +			}
> >  +		}
> >  +		atomic_inc(&likely_lock);
> 
> hm, good enough I guess.  It does need a comment explaining why we
> don't just do spin_lock().
> 
> It'd be a bit saner to do
> 
> 	if (!test_and_set_bit(&foo, 0)) {
> 		...
> 		clear_bit(&foo, 0);
> 	}

Ok .. Also a mistaken "define" in the compiler.h .. I'll fix that as
well ..


Daniel


