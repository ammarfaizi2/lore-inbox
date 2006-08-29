Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbWH2TcS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbWH2TcS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 15:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWH2TcS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 15:32:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47552 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751196AbWH2TcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 15:32:17 -0400
Date: Tue, 29 Aug 2006 12:28:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/2] NOMMU: Set BDI capabilities for /dev/mem and
 /dev/kmem
Message-Id: <20060829122851.690e5219.akpm@osdl.org>
In-Reply-To: <1082.1156876794@warthog.cambridge.redhat.com>
References: <20060829112030.a2a8c763.akpm@osdl.org>
	<20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com>
	<1082.1156876794@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 19:39:54 +0100
David Howells <dhowells@redhat.com> wrote:

> Andrew Morton <akpm@osdl.org> wrote:
> 
> > #else
> > #define get_unmapped_area_mem NULL
> > #endif
> 
> Blech.
> 
> Of course, I could just declare the new symbols weak, and stick
> get_unmapped_area_mem() and mem_bdi in their own file which would be
> conditional on !CONFIG_MMU.

Or you could use the approach I suggested, like wot everyone else does.

> > This changes behaviour, doesn't it?
> 
> Yes.
> 
> >  But only for !CONFIG_MMU kernels?
> 
> Yes.  For the moment, nothing in MMU world actually looks at these
> capabilities, though perhaps they should.
> 
> > Perhaps some additional commentary around this is needed.
> 
> Perhaps... or perhaps it should have different capabilities if there's an MMU.
> 
> Is doing a private mapping of /dev/mem a valid thing to do anyway, even if
> there is an MMU?

It would be strange, I guess.  But the important thing is to not change
behaviour.
