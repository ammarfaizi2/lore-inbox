Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269646AbTGaVEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269659AbTGaVD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:03:59 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:29652 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S269646AbTGaVD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:03:57 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2003 23:03:30 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Any reason why install_page and zap_page_range are not exported?
X-mailer: Pegasus Mail v3.50
Message-ID: <8D43EFF35A6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  in one of my projects I found that what we were doing in 2.2.x/2.4.x
with strange hacks to mmap & nopage methods to get non-linear
mappings from some device can be done in 2.[56].x with remap_file_pages. 

  Only two things are missing: install_page is not exported for modules,
so it is not possible to create own vma's populate function, as
there is no way how to put some page into pagetables. Or at least
I did not found such - even if I'll copy install_page's code to the
module, I'll just run to the other non-exported symbols :-(

  And second missing thing is zap_page_range - we need way to tell
that specified page is not mapped anywhere (mostly for debugging
purposes). At worst install_page with PROT_NONE protection can be 
used for that, but it seems natural that if there should be no page 
there, we should just put nothing to the pagetables instead of some 
fake page. And for large ranges doing one 200MB zap_page_range is
much faster than doing 50000 install_pages.

  Is it intentional that these functions are not exported for modules,
or is it just case that nobody needed such functions yet?
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            

