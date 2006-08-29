Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965260AbWH2SlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965260AbWH2SlB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 14:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965261AbWH2SlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 14:41:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2962 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965260AbWH2SlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 14:41:00 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829112030.a2a8c763.akpm@osdl.org> 
References: <20060829112030.a2a8c763.akpm@osdl.org>  <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/2] NOMMU: Set BDI capabilities for /dev/mem and /dev/kmem 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 29 Aug 2006 19:39:54 +0100
Message-ID: <1082.1156876794@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> #else
> #define get_unmapped_area_mem NULL
> #endif

Blech.

Of course, I could just declare the new symbols weak, and stick
get_unmapped_area_mem() and mem_bdi in their own file which would be
conditional on !CONFIG_MMU.

> This changes behaviour, doesn't it?

Yes.

>  But only for !CONFIG_MMU kernels?

Yes.  For the moment, nothing in MMU world actually looks at these
capabilities, though perhaps they should.

> Perhaps some additional commentary around this is needed.

Perhaps... or perhaps it should have different capabilities if there's an MMU.

Is doing a private mapping of /dev/mem a valid thing to do anyway, even if
there is an MMU?

David
