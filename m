Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbUCNWqI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbUCNWqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:46:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.176]:15563 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261967AbUCNWqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:46:04 -0500
To: =?iso-8859-1?Q?Olaf_Hering?= <olh@suse.de>
Subject: Re: [PATCH] s390: update for altered page_state structure
From: =?iso-8859-1?Q?Arnd_Bergmann?= <arnd@arndb.de>
Cc: =?iso-8859-1?Q?Gerald_Schaefer?= <geraldsc@de.ibm.com>,
       <linux-kernel@vger.kernel.org>, <schwidefsky@de.ibm.com>
Message-Id: <26879984$10793028844054dae49e1381.69727422@config20.schlund.de>
X-Binford: 6100 (more power)
X-Originating-From: 26879984
X-Mailer: Webmail
X-Routing: DE
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Date: Sun, 14 Mar 2004 23:44:01 +0100
X-Provags-ID: kundenserver.de abuse@kundenserver.de ident:@172.23.4.147
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ChangeSet 1.1630, 2004/03/14 13:49:59-08:00, akpm@osdl.org
>
>	[PATCH] s390: update for altered page_state structure
>	
>	From: Olaf Hering <olh@suse.de>
>	
>	This patch is needed on s390.
>
>
> # This patch includes the following deltas:
> #	           ChangeSet	1.1629  -> 1.1630 
> #	arch/s390/appldata/appldata_mem.c	1.1     -> 1.2    
> #	include/linux/page-flags.h	1.44    -> 1.45   
> #
>
> arch/s390/appldata/appldata_mem.c |   15 +++++++++++----
> include/linux/page-flags.h        |    3 +++
> 2 files changed, 14 insertions(+), 4 deletions(-)
>
>
> diff -Nru a/arch/s390/appldata/appldata_mem.c b/arch/s390/appldata/appldata_mem.c
> --- a/arch/s390/appldata/appldata_mem.c	Sun Mar 14 14:12:59 2004
> +++ b/arch/s390/appldata/appldata_mem.c	Sun Mar 14 14:12:59 2004
> @@ -54,7 +54,9 @@
>  	u64 freeswap;		/* free swap space */
>  
>  // New in 2.6 -->
> -	u64 pgalloc;		/* page allocations */
> +	u64 pgalloc_high;	/* page allocations */
> +	u64 pgalloc_normal;
> +	u64 pgalloc_dma;
>  	u64 pgfault;		/* page faults (major+minor) */
>  	u64 pgmajfault;		/* page faults (major only) */
>  // <-- New in 2.6
> ...

Sorry, this does not look like the right fix. The structure is
effectively ABI, because it is accessed as binary data by the
VM hypervisor. If changes to it can't be avoided, the structure
version needs to be changed as well and all documentation and
VM applications using it must be updated.

In this specific case, it should be simple enough to just leave
the pgalloc field in place and write the sum of the real kernel
values (high+normal+dma) to it.

Gerald, can you please look into this?

      Arnd <><
