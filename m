Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262276AbUK3TZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbUK3TZr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 14:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUK3TZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 14:25:47 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:21949 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262277AbUK3TZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 14:25:13 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Arjan van de Ven <arjan@infradead.org>
Date: Tue, 30 Nov 2004 20:29:08 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: 2.6.10-rc2-mm4
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
X-mailer: Pegasus Mail v3.50
Message-ID: <22DA85F23E4@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Nov 04 at 19:25, Arjan van de Ven wrote:
> On Tue, 2004-11-30 at 10:21 -0800, Andrew Morton wrote:
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Tue, 2004-11-30 at 09:50 -0800, Andrew Morton wrote:
> > > > http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/
> > > > 
> > > > - x86_64 supports a fourth VM zone: ZONE_DMA32.  This may affect memory
> > > >   reclaim, but shouldn't.
> > > what is the purpose of such a zone ??
> > 
> > For pages which have a physical address <4G.  I assume this was motivated
> > by the lack of an IOMMU on ia32e?
> 
> but there's the swiommu for those... so that can't be it
> realistically....
> 
> Is there code using the zone GFP mask yet ??

If this is going to stay, I have one possible user.  VMware's vmmon needs
to allocate two pages from memory below 4GB so it can use these pages
for code and page table root while switching from long mode to legacy
mode and back.  After switch code can use PAE mode and access any memory
it wants, but as CR3 is 32bit only in legacy mode, and paging has to be
disabled while switching between modes, these two pages needs to be in
low 4GB.

Currently vmmon uses GFP_DMA for this allocation - which unnecessarily
limits memory available for this operation to 16MB, although any page
from low 4GB suffices.
                                            Best regards,
                                                    Petr Vandrovec

