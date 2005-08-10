Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965049AbVHJJtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVHJJtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 05:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHJJtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 05:49:08 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:52930 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932551AbVHJJtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 05:49:07 -0400
Date: Wed, 10 Aug 2005 11:48:26 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Alexander Nyberg <alexn@telia.com>,
       Christoph Lameter <christoph@lameter.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [SLAB] __builtin_return_address use without FRAME_POINTER causes boot failure
Message-ID: <20050810094826.GA16911@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0508081353170.28612@graphe.net> <42F7D08E.9070508@colorfullife.com> <20050808215353.GA26384@localhost.localdomain> <42F8E243.2060505@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42F8E243.2060505@colorfullife.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 August 2005 19:05:07 +0200, Manfred Spraul wrote:
> Alexander Nyberg wrote:
> 
> >My fault, I introduced a debugging patch (i think i cc'ed you on it)
> >which used __builtin_return_address([12]) to save traces of who the
> >caller of an object is.
> >
> Ups. I still have your original mail in my inbox.
> The correct way is check the whole stack and store all pointers that are 
> in kernel_text_address(). See store_stack_info() in mm/slab.c.

Ugly.  Wouldn't make a difference on i386, but other architectures
actually don't need to play function-guessing games.  Maybe we could
create an architecture-provided function like
void *get_next_stack_function(void* last_function);

For asm-generic, this would do the i386 style stack guessing, while
other architectures can walk a stack frame for it.

[ Yes, I realize that noone cares enough to actually do it, including
me, but it still would be nice. ]

Jörn

-- 
You can take my soul, but not my lack of enthusiasm.
-- Wally
