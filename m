Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268154AbUIGRqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268154AbUIGRqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 13:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268203AbUIGRqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 13:46:20 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:29624 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S268154AbUIGRp4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 13:45:56 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Christoph Hellwig <hch@lst.de>
Date: Tue, 7 Sep 2004 19:46:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [PATCH] mark install_page static
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
X-mailer: Pegasus Mail v3.50
Message-ID: <2E70CD2670F@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Sep 04 at 16:37, Christoph Hellwig wrote:
> Not used anywhere in modules and it really shouldn't either.

How are modules supposed to implement vma's populate method
without having install_page available?  And yes, there are
out of tree kernel modules which prefer fremap & populate & install_page
over creating several thousands of VMAs to get non-linear mappings.
                                            Thanks,
                                                Petr Vandrovec

> 
> --- 1.28/mm/fremap.c    2004-08-23 10:15:12 +02:00
> +++ edited/mm/fremap.c  2004-09-07 13:51:20 +02:00
> @@ -99,8 +99,6 @@
>     spin_unlock(&mm->page_table_lock);
>     return err;
>  }
> -EXPORT_SYMBOL(install_page);
> -
>  

