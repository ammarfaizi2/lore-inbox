Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbTJHPbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 11:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTJHPbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 11:31:49 -0400
Received: from ausadmmsrr501.aus.amer.dell.com ([143.166.83.88]:41743 "HELO
	AUSADMMSRR501.aus.amer.dell.com") by vger.kernel.org with SMTP
	id S261667AbTJHPbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 11:31:47 -0400
X-Server-Uuid: ff595059-9672-488a-bf38-b4dee96ef25b
Message-ID: <1065627088.21242.32.camel@localhost.localdomain>
From: Matt_Domsch@Dell.com
To: hugh@veritas.com
cc: riel@redhat.com, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: [PATCH] page->flags corruption fix
Date: Wed, 8 Oct 2003 10:31:29 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 139AF2533584476-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-08 at 09:49, Hugh Dickins wrote:
> On Tue, 7 Oct 2003, Rik van Riel wrote:
> 
> > In the "better safe than sorry" category. Thanks go out to
> > Matt Domsch and Robert Hentosh. A similar fix went into the
> > 2.6 kernel. Please apply.
> 
> Seven atomic ops in a row, isn't that rather inefficient?

Not all arches have atomic_set_mask() and atomic_clear_mask().
asm-arm
asm-arm26
asm-h8300
asm-i386
asm-m68k
asm-m68knommu
asm-ppc
asm-s390
asm-sh
asm-v850
asm-x86_64

do.


> The 2.6 version clears those PG_flags all together in one
> non-atomic op - but elsewhere, in prep_new_page.
>
> Is there an actual test case for why 2.4 now needs this change?

There definitely is when RMAP is present - we've reproduced it
repeatedly in our labs.

We've seen a similar failure with the RHEL2.1 kernel w/o RMAP patches
too.  So we fully believe it's possible in stock 2.4.x.

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

