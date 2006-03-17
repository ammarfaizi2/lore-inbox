Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752534AbWCQGGL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbWCQGGL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 01:06:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbWCQGGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 01:06:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752534AbWCQGGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 01:06:09 -0500
Date: Thu, 16 Mar 2006 22:03:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 007 of 13] md: Core of raid5 resize process
Message-Id: <20060316220322.0cfa80bf.akpm@osdl.org>
In-Reply-To: <1060317044755.16096@suse.de>
References: <20060317154017.15880.patches@notabene>
	<1060317044755.16096@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown <neilb@suse.de> wrote:
>
> @@ -4539,7 +4543,9 @@ static void md_do_sync(mddev_t *mddev)
>   		 */
>   		max_sectors = mddev->resync_max_sectors;
>   		mddev->resync_mismatches = 0;
>  -	} else
>  +	} else if (test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery))
>  +		max_sectors = mddev->size << 1;
>  +	else
>   		/* recovery follows the physical size of devices */
>   		max_sectors = mddev->size << 1;
>   

This change is a no-op.   Intentional?
