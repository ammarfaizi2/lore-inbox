Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262573AbVDYKUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbVDYKUG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 06:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbVDYKUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 06:20:06 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:24811 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262573AbVDYKUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 06:20:02 -0400
Date: Mon, 25 Apr 2005 12:16:26 +0200
From: Jens Axboe <axboe@suse.de>
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 7/7] uml ubd: handle readonly status
Message-ID: <20050425101625.GD1671@suse.de>
References: <20050424181924.EAFCB55D06@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424181924.EAFCB55D06@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24 2005, blaisorblade@yahoo.it wrote:
> @@ -1099,6 +1104,7 @@ static int prepare_request(struct reques
>  	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
>  		printk("Write attempted on readonly ubd device %s\n", 
>  		       disk->disk_name);
> +		WARN_ON(1); /* This should be impossible now */
>  		end_request(req, 0);
>  		return(1);
>  	}

I don't think that's a sound change. The WARN_ON() is strictly only
really useful for when you need the stack trace for something
interesting. As the io happens async, you will get a boring trace that
doesn't contain any valuable information.

-- 
Jens Axboe

