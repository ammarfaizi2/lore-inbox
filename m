Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266001AbUEUUiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUEUUiv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265939AbUEUUiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:38:51 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:65292 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S266001AbUEUUic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:38:32 -0400
Date: Fri, 21 May 2004 17:33:20 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
To: Arthur Othieno <a.othieno@bluewin.ch>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] drivers/block/floppy.c: Premature blk_queue_max_sectors()
Message-ID: <20040521203320.GA1148@lorien.prodam>
Mail-Followup-To: Arthur Othieno <a.othieno@bluewin.ch>,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040521195934.GA17681@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040521195934.GA17681@mars>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Arthur,

Em Fri, May 21, 2004 at 09:59:34PM +0200, Arthur Othieno escreveu:

| We're prematurely pampering the request queue before
| checking whether it was indeed allocated successfully.
| 
| Against 2.6.6. Thanks.
| 
| 
|  floppy.c |    2 +-
|  1 files changed, 1 insertion(+), 1 deletion(-)
| 
| --- a/drivers/block/floppy.c	2004-05-20 23:48:04.000000000 +0200
| +++ b/drivers/block/floppy.c	2004-05-21 21:29:33.000000000 +0200
| @@ -4271,11 +4271,11 @@
|  		goto out;
|  
|  	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock);
| -	blk_queue_max_sectors(floppy_queue, 64);
|  	if (!floppy_queue) {
|  		err = -ENOMEM;
|  		goto fail_queue;
|  	}
| +	blk_queue_max_sectors(floppy_queue, 64);
|  
|  	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
|  			    floppy_find, NULL, NULL);

 I and Randy did a (long) audit for floppy init sometime ago. It includes
your change. :-)

 I think the patch will be in next -mm.

-- 
Luiz Fernando N. Capitulino
<http://www.telecentros.sp.gov.br>
