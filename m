Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316695AbSG3VlM>; Tue, 30 Jul 2002 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSG3VlL>; Tue, 30 Jul 2002 17:41:11 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33036 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316684AbSG3Vkd>;
	Tue, 30 Jul 2002 17:40:33 -0400
Message-ID: <3D47089C.6030504@mandrakesoft.com>
Date: Tue, 30 Jul 2002 17:43:56 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [patch] disable READA
References: <3D47043E.413E9803@zip.com.au>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> There's a bug in bread() which can cause it to misinterpret a
> failed READA request as an IO error on SMP.


> --- 2.4.19-rc3/drivers/block/ll_rw_blk.c~no-readahead	Tue Jul 30 14:18:17 2002
> +++ 2.4.19-rc3-akpm/drivers/block/ll_rw_blk.c	Tue Jul 30 14:19:52 2002
> @@ -841,7 +841,9 @@ static int __make_request(request_queue_
>  	rw_ahead = 0;	/* normal case; gets changed below for READA */
>  	switch (rw) {
>  		case READA:
> +#if 0	/* bread() misinterprets failed READA attempts as IO errors on SMP */
>  			rw_ahead = 1;
> +#endif



If the problem is only on SMP, then that should be #ifndef CONFIG_SMP...

	Jeff



