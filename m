Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274885AbTGaW5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274886AbTGaW5l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:57:41 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:23514 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S274885AbTGaW52 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:57:28 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 1 Aug 2003 00:57:05 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Any reason why install_page and zap_page_range are not 
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <8D6237B7B88@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jul 03 at 15:16, Andrew Morton wrote:
> "Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:
> >   And second missing thing is zap_page_range - we need way to tell
> > that specified page is not mapped anywhere (mostly for debugging
> > purposes). At worst install_page with PROT_NONE protection can be 
> > used for that, but it seems natural that if there should be no page 
> > there, we should just put nothing to the pagetables instead of some 
> > fake page. And for large ranges doing one 200MB zap_page_range is
> > much faster than doing 50000 install_pages.
> 
> zap_page_range() sounds like an odd thing to be exporting.  If we had an

Currently we are doing an identity do_mmap_pgoff() over the region to 
flush page tables currently. It works very nice with 2.6.x kernels. 
Unfortunately 2.4.x do not merge regions this mmap split back together :-( 
Fortunately we can just remap whole original region to merge VMAs back 
together when we think that there is too many VMAs around.

> in-kernel module which needed it then OK.  Do you have plans in that
> direction?

Probably not, we are happy with distributing modules together with
product, so while module has to support wide range of kernels, it
can support only one version of our product... It looks like that it
is better this way for both us (we can do incompatible changes) and 
for customers too (they do not have to use latest kernels).

Thanks for exporting install_page. 
                                                Best regards,
                                                    Petr Vandrovec
                                                    

