Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTDCTMI 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263489AbTDCTJx 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:09:53 -0500
Received: from dp.samba.org ([66.70.73.150]:29859 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263485AbTDCTJT 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:09:19 -0500
Date: Fri, 4 Apr 2003 05:17:50 +1000
From: Anton Blanchard <anton@samba.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: riel@redhat.com, linux-kernel@vger.kernel.org, linux390@de.ibm.com
Subject: Re: gcc-3.2 breaks rmap on s390x
Message-ID: <20030403191750.GE27733@krispykreme>
References: <20030403131054.B25676@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030403131054.B25676@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the following patch seems to fix my rmap problems on s390x.
> 
> --- linux-2.4.20-2.1.24.z1/include/linux/mm.h	2003-03-27 21:30:09.000000000 -0500
> +++ linux-2.4.20-2.1.24.z2/include/linux/mm.h	2003-04-02 20:26:11.000000000 -0500
> @@ -376,8 +376,10 @@
>  	 */
>  #ifdef CONFIG_SMP
>  	while (test_and_set_bit(PG_chainlock, &page->flags)) {
> -		while (test_bit(PG_chainlock, &page->flags))
> +		while (test_bit(PG_chainlock, &page->flags)) {
>  			cpu_relax();
> +			barrier();
> +		}
>  	}
>  #endif
>  }

cpu_relax() should be a gcc barrier. Its this way on all architectures in
2.5.

Anton
