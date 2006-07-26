Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWGZLA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWGZLA0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 07:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWGZLA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 07:00:26 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:45344 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751332AbWGZLAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 07:00:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S7L8zqdfnTby5eTeHWZwggpQSjP27EilR0r9CVFMRD2DJuM4TmisytfLe/R3M0eygK3IiLoY9fzLxLUUeAdN+QgU0Jhxd8VLK2JHUSbQNGCE9dc8r5hsy70TSK1nxfLysC962ARr5Vm3iXOVJK/Hkf+wtYWgnwi1wcA4HeMXthc=
Message-ID: <6e0cfd1d0607260400r731489a1tfd9e6c5a197fb0bd@mail.gmail.com>
Date: Wed, 26 Jul 2006 13:00:23 +0200
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Rik van Riel" <riel@redhat.com>
Subject: Re: [PATCH] mm: inactive-clean list
Cc: "Peter Zijlstra" <a.p.zijlstra@chello.nl>, linux-mm <linux-mm@kvack.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44C30E33.2090402@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1153167857.31891.78.camel@lappy> <44C30E33.2090402@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/06, Rik van Riel <riel@redhat.com> wrote:
> Peter Zijlstra wrote:
> > This patch implements the inactive_clean list spoken of during the VM summit.
> > The LRU tail pages will be unmapped and ready to free, but not freeed.
> > This gives reclaim an extra chance.
>
> This patch makes it possible to implement Martin Schwidefsky's
> hypervisor-based fast page reclaiming for architectures without
> millicode - ie. Xen, UML and all other non-s390 architectures.

Hmm, I wonder how the inactive clean list helps in regard to the fast
host reclaim
scheme. In particular since the memory pressure that triggers the
reclaim is in the
host, not in the guest. So all pages might be on the active list but
the host still
wants to be able to discard pages.

-- 
blue skies,
  Martin
