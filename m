Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWH3Jvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWH3Jvl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWH3Jvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:51:41 -0400
Received: from cantor2.suse.de ([195.135.220.15]:11453 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750829AbWH3Jvk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:51:40 -0400
To: Willy Tarreau <w@1wt.eu>
Cc: Riley@Williams.Name, davej@redhat.com, pageexec@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] exception processing in early boot
References: <20060830063932.GB289@1wt.eu>
From: Andi Kleen <ak@suse.de>
Date: 30 Aug 2006 11:51:39 +0200
In-Reply-To: <20060830063932.GB289@1wt.eu>
Message-ID: <p73y7t65z6c.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> Hi,
> 
> PaX Team has sent me this patch for inclusion. Basically, during early
> boot on x86, the exception handler does not make a special case for
> exceptions which push an error code onto the stack, leading to a return
> to a wrong address. Two patches were proposed, one which would add a
> special case for all exceptions using the return code, and this one. The
> former was of no use in its form because the return from the exception
> handler would get back to the faulting exception, causing it to loop.
> 
> This one should be better as it effectively hangs the system using HLT
> to prevent CPU from burning.

Looks good.

[I'm glad this particular ward in x86 was fixed in x86-64 ...]

> 
> If nobody has any objections, I will merge it. In this case, I would also
> like someone to check if 2.6 needs it and to port it in this case.

I don't think you should merge anything like this before 2.6 does. Otherwise
we just end up with the mad situation again that an old release has 
more bugs fixed or more features than the new release.

-Andi
