Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270501AbUJTT5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270501AbUJTT5l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270491AbUJTT5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:57:40 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15589 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S270489AbUJTTzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:55:16 -0400
Date: Wed, 20 Oct 2004 20:54:52 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andi Kleen <ak@suse.de>
cc: Mikael Starvik <mikael.starvik@axis.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 PageAnon bug
In-Reply-To: <p738ya1yytw.fsf@verdi.suse.de>
Message-ID: <Pine.LNX.4.44.0410202044120.9603-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Oct 2004, Andi Kleen wrote:
> Hugh Dickins <hugh@veritas.com> writes:
>  
> > But what does "aligned(2)" or "aligned(4)" do on 64-bit machines -
> > any danger of it aligning stupidly?  I think not, but know little.
> 
> It will align stupidly. 

I was imagining not in this case, where the i_data follows immediately
after the struct address_space *i_mapping.  But let's not rely on that.

> This means on x86-64 i don't care too much because the misalignment
> penalty on K8 is only 1 cycle and not that much worse on P4, but 
> others may care more.

I would care: not so much the penalty, as the danger of surprise.

Would __attribute__((aligned((sizeof(long))))) seem better to you?

Do you think it would be better on the declaration of struct
address_space itself, than on the struct address_space i_data?

Thanks for the feedback,
Hugh

