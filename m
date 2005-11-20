Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbVKTBIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbVKTBIi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 20:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbVKTBIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 20:08:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:61668 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750943AbVKTBIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 20:08:38 -0500
Date: Sat, 19 Nov 2005 17:08:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] i386, nmi: signed vs unsigned mixup
Message-Id: <20051119170818.5e16afae.akpm@osdl.org>
In-Reply-To: <9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
References: <200511200010.33658.jesper.juhl@gmail.com>
	<20051119162805.47796de9.akpm@osdl.org>
	<9a8748490511191630r3ad3e24w4e6d21b3f3b0c3a7@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> > -ETOOTRIVIAL.  The code as-is works OK, and we have these sorts of things
>  > all over the tee.
>  >
>  Fair enough.
> 
>  Would a patch to clean this sort of stuff up in bulk all over be of
>  interrest or should I just leave it alone?

Such a patchset would be pretty intrusive and it's not exactly trivial - at
each site we need to decide whether we should be using signed or unsigned,
then change one or the other, then do a full-scope check to see what the
implications of that change are.

I think the two risks of signedness sloppiness are a) inadvertent or
premature overflow and b) comparisons, where the signed quantity went
negative.

Problem b) is more serious, and `gcc -Wsigned-compare' may be used to
identify possible problems.  There are quite a lot of places need checking,
iirc.

