Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932376AbWJDEa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932376AbWJDEa4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 00:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWJDEa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 00:30:56 -0400
Received: from gw.goop.org ([64.81.55.164]:36482 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932376AbWJDEaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 00:30:55 -0400
Message-ID: <452338FC.6000802@goop.org>
Date: Tue, 03 Oct 2006 21:30:52 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4/5] Generic BUG for powerpc
References: <20061003201618.974094245@goop.org> >	  <20061003201812.313852083@goop.org>> <1159923244.31312.21.camel@localhost.localdomain>
In-Reply-To: <1159923244.31312.21.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> I posted a patch a few weeks back to use __builtin_trap(), which gives
> GCC the hint that it's not going to return.
>   

Ah, interesting.  I'd been looking for it, and, yep, completely 
undocumented.  It even generates the right instruction on x86.  
Unfortunately, your asm sequence isn't correct, since there's no 
guarantee that the asm and the builtin_trap will be adjacent (though its 
hard to see what might be interposed in this case, since it would be 
dead code).  If only gcc labels-as-values worked properly...

> (http://patchwork.ozlabs.org/linuxppc/patch?id=7047)
>
> Unfortunately this generated some negative feedback from some of our
> crackhead ... er wonderful colleagues who want to be able to step over
> BUGs in some circumstances.
> (http://ozlabs.org/pipermail/linuxppc-dev/2006-September/026161.html)
>
> I think they conceeded that it could be configurable, but I wasn't sure
> it was worth the trouble.
>   

Hm, not really.  Well, it can be an arch-by-arch decision.

    J
