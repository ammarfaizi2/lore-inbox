Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263128AbUD0Esp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUD0Esp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 00:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUD0Esp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 00:48:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:46750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263128AbUD0Esm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 00:48:42 -0400
Date: Mon, 26 Apr 2004 21:47:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: apw@shadowen.org, agl@us.ibm.com, mbligh@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: put_page() tries to handle hugepages but fails
Message-Id: <20040426214757.2c7d8ed5.akpm@osdl.org>
In-Reply-To: <20040427043652.GF514@zax>
References: <20040423081856.GJ9243@zax>
	<20040423013437.1f2b8fc6.akpm@osdl.org>
	<20040427043652.GF514@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson <david@gibson.dropbear.id.au> wrote:
>
> +		if (put_page_testzero(page))
>  +			free_huge_page(page);

Well yes, but this is assuming that compound pages are always hugetlb pages.

It's true at present, but it doesn't have to always be true.  The cost of
the destructor is zilch, so why not?

Please review the changes which went into 2.6.6-rc2-mm2.

