Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270413AbTGaW2E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270487AbTGaW2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:28:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:11719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270413AbTGaW2B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:28:01 -0400
Date: Thu, 31 Jul 2003 15:16:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any reason why install_page and zap_page_range are not
 exported?
Message-Id: <20030731151611.0dc69bf9.akpm@osdl.org>
In-Reply-To: <8D43EFF35A6@vcnet.vc.cvut.cz>
References: <8D43EFF35A6@vcnet.vc.cvut.cz>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Petr Vandrovec" <VANDROVE@vc.cvut.cz> wrote:
>
> Hi,
>   in one of my projects I found that what we were doing in 2.2.x/2.4.x
> with strange hacks to mmap & nopage methods to get non-linear
> mappings from some device can be done in 2.[56].x with remap_file_pages. 
> 
>   Only two things are missing: install_page is not exported for modules,
> so it is not possible to create own vma's populate function, as
> there is no way how to put some page into pagetables. Or at least
> I did not found such - even if I'll copy install_page's code to the
> module, I'll just run to the other non-exported symbols :-(

Agree, install_page() should be exported.  I'll submit a patch.

>   And second missing thing is zap_page_range - we need way to tell
> that specified page is not mapped anywhere (mostly for debugging
> purposes). At worst install_page with PROT_NONE protection can be 
> used for that, but it seems natural that if there should be no page 
> there, we should just put nothing to the pagetables instead of some 
> fake page. And for large ranges doing one 200MB zap_page_range is
> much faster than doing 50000 install_pages.

zap_page_range() sounds like an odd thing to be exporting.  If we had an
in-kernel module which needed it then OK.  Do you have plans in that
direction?
