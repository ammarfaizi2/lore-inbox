Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162122AbWKPAew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162122AbWKPAew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 19:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162120AbWKPAew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 19:34:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5069 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1162117AbWKPAev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 19:34:51 -0500
Date: Wed, 15 Nov 2006 16:33:24 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: divy <divy@chelsio.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxgb3: Chelsio T3 1G/10G ethernet device driver
Message-ID: <20061115163324.16263201@freekitty>
In-Reply-To: <455BACB8.4010902@chelsio.com>
References: <455BACB8.4010902@chelsio.com>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 16:11:36 -0800
divy <divy@chelsio.com> wrote:

> Hi,
> 
> This patch adds support for the latest Chelsio adapter, T3.
> 
> Since some files are bigger than the 40kB advertized in the submit
> guidelines, a monolithic patch against 2.6.19-rc5 is posted at the
> following URL: http://service.chelsio.com/kernel.org/cxgb3.patch.bz2
> 
> Please advise on any other form you would like to see the code.
> 
> We wish this patch to be considered for inclusion in 2.6.20. This driver
> will be required by the Chelsio T3 RDMA driver which will be posted for
> review asap.
> 
> Cheers,
> Divy
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


This took me an afternoon, so I don't see why Chelsio didn't do it.

    Port of Chelsio's 2.2.0 version driver from:
        http://service.chelsio.com/drivers/linux/t210/cxgb2toe-2.2.0.tar.gz
    
    De-vendorized:
        - removed all TCP Offload Engine support because those changes
          will not be accepted in mainline kernel.
        - new files run through Lindent
        - removed code that was '#ifdef' for older kernel versions
        - fix for 2.6.19 irq
        - replace usage of TSC with ktime
        - remove /proc trace debug stuff
        - remove dead code
        - incorporate GSO, etc.
        - get rid of FILE_IDENT() macro
        - fix sparse warnings by adding __iomem and __user

Also, I kept as many of the filenames and device names the same since
it is really just an extension of existing driver.

I'm testing it now.

-- 
Stephen Hemminger <shemminger@osdl.org>
