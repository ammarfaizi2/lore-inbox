Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVGLPzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVGLPzI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 11:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbVGLPzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 11:55:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15570 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261472AbVGLPzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 11:55:00 -0400
Message-ID: <42D3E69B.7090704@redhat.com>
Date: Tue, 12 Jul 2005 11:49:47 -0400
From: Wendy Cheng <wcheng@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [PATCH] Add ENOSYS into sys_io_cancel
References: <42D2C34C.4040406@redhat.com> <20050712014845.GA11916@kvack.org>
In-Reply-To: <20050712014845.GA11916@kvack.org>
Content-Type: multipart/mixed;
 boundary="------------010604070806010003040607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010604070806010003040607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin LaHaise wrote:

>Also, please cc linux-aio@kvack.org on future aio patches.  
>  
>
Didn't realize the patch was sent to linux-kernel (that I don't 
subscribe) instead of linux-aio - revised patch attached. Thanks for the 
help .... Wendy

>On Mon, Jul 11, 2005 at 03:06:52PM -0400, Wendy Cheng wrote:
>
>Note that other than few exceptions, most of the current filesystem 
>and/or drivers do not have aio cancel specifically defined 
>(kiob->ki_cancel field is mostly NULL). However, sys_io_cancel system 
>call universally sets return code to -EGAIN. This gives applications a 
>wrong impression that this call is implemented but just never works. We 
>have customer inquires about this issue.
>
>Upload a trivial patch to address this confusion.
>
>  
>


--------------010604070806010003040607
Content-Type: text/plain;
 name="aio.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="aio.patch"

Signed-off-by: S. Wendy Cheng <wcheng@redhat.com>

--- linux-2.6.12/fs/aio.c	2005-06-17 15:48:29.000000000 -0400
+++ linux/fs/aio.c	2005-07-12 11:26:08.503256160 -0400
@@ -1660,7 +1660,7 @@ asmlinkage long sys_io_cancel(aio_contex
 				ret = -EFAULT;
 		}
 	} else
-		printk(KERN_DEBUG "iocb has no cancel operation\n");
+		ret = -ENOSYS;
 
 	put_ioctx(ctx);
 

--------------010604070806010003040607--
