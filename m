Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264979AbUGGIB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264979AbUGGIB7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 04:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264966AbUGGIB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 04:01:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:9667 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264965AbUGGIBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 04:01:54 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: CONFIG_SLAB_DEBUG and NUMA API
Date: Wed, 7 Jul 2004 10:10:59 +0200
User-Agent: KMail/1.5
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
References: <20040706063149.GA37299@muc.de> <20040705234945.1f920d1b.akpm@osdl.org> <20040706210331.GA29417@muc.de>
In-Reply-To: <20040706210331.GA29417@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407071011.00016.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 of July 2004 23:03, Andi Kleen wrote:
> On Mon, Jul 05, 2004 at 11:49:45PM -0700, Andrew Morton wrote:
> > Andi Kleen <ak@muc.de> wrote:
> > > I tested 2.6.7-mm6 with NUMA on with CONFIG_SLAB_DEBUG and I didn't see
> > > any oopses. Do you have a recipe to reproduce them?
> >
> > Still happens here.  Booting SLES9.1 with the attached config.
>
> [...]
>
> Here's a patch. The problem was that the kernel exit would allocate
> memory to send exit signals after the local mempolicy was already freed,
> but not zeroed.  When the allocator tried to grab more memory it would
> fall over.
>
> -Andi
>
> -------------------------------------------------------------
>
> Move the memory policy freeing to later in exit to make sure
> the last memory allocations don't use an uninitialized policy

It fixed the problems that I had reported on both 2.6.7-mm6 and 2.6.7-bk18.  
Thanks a lot,

rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
