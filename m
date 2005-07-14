Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263132AbVGNT7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263132AbVGNT7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 15:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbVGNT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 15:58:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62135 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263105AbVGNTzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 15:55:00 -0400
Date: Thu, 14 Jul 2005 20:54:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: ericvh@gmail.com
Cc: linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc2-mm2 2/7] v9fs: VFS file, dentry, and directory operations (2.0.2)
Message-ID: <20050714195458.GA22856@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, ericvh@gmail.com,
	linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
	akpm@osdl.org, linux-fsdevel@vger.kernel.org
References: <200507141830.j6EIUiRZ023607@ms-smtp-03-eri0.texas.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507141830.j6EIUiRZ023607@ms-smtp-03-eri0.texas.rr.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -383,9 +379,10 @@ v9fs_file_write(struct file *filp, const
>  		return -ENOMEM;
>  
>  	ret = copy_from_user(buffer, data, count);
> -	if (ret)
> +	if (ret) {
>  		dprintk(DEBUG_ERROR, "Problem copying from user\n");
> -	else
> +		return -EFAULT;
> +	} else
>  		ret = v9fs_write(filp, buffer, count, offset);
>  
>  	kfree(buffer);

Aren't you leaking buffer in the error case?  Also we Linux people really
hate an else clause when the if block contains a return statement ;-)

