Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVCBRVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVCBRVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVCBRUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:20:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:54950 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262379AbVCBRR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:17:56 -0500
Date: Wed, 2 Mar 2005 09:17:39 -0800
From: Greg KH <greg@kroah.com>
To: Mickey Stein <yekkim@pacbell.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [Patch] gcc 4 errors out on i2c.h (2.6.11)
Message-ID: <20050302171739.GA2563@kroah.com>
References: <4225D9E0.40005@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4225D9E0.40005@pacbell.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 07:21:04AM -0800, Mickey Stein wrote:
> I've noticed no problems with today's new 2.6.11 in the i2c realm on 
> gcc3.x, but the last couple of weeks of gcc 4.x cvs give this:
> 
> Error msgs building i2c modules on 2.6.11 using gcc 4:
> ------------
> In file included from drivers/i2c/i2c-core.c:29:
> include/linux/i2c.h:58: error: array type has incomplete element type
> include/linux/i2c.h:197: error: array type has incomplete element type
> drivers/i2c/i2c-core.c: In function ?i2c_transfer?:
> drivers/i2c/i2c-core.c:594: error: type of formal parameter 2 is incomplete
> drivers/i2c/i2c-core.c: In function ?i2c_master_send?:
> drivers/i2c/i2c-core.c:620: error: type of formal parameter 2 is incomplete
> drivers/i2c/i2c-core.c: In function ?i2c_master_recv?:
> drivers/i2c/i2c-core.c:649: error: type of formal parameter 2 is incomplete
> make[2]: *** [drivers/i2c/i2c-core.o] Error 1
> make[1]: *** [drivers/i2c] Error 2
> make: *** [drivers] Error 2
> -------------
> 
> I'm not clear on whether the mainstream kernel is "supposed" to compile 
> error-free with the current state of
> gcc 4 cvs. If not, then disregard. I tested this patch applied against 
> today's 2.6.11 with gcc 3.x & 4.x
> by enabling all i2c module switches and building.
> 
> A thread discussing this can be found by following the link below:
> 
> http://gcc.gnu.org/ml/gcc/2005-02/msg00053.html
> 
> The patch changes declarations from "struct i2c_msg msg[]" format to 
> "struct i2c_msg *msg".
> 
> I've run this by Greg K-H and fixed a typo akpm noticed. The patch 
> touches on several other
> files using *i2c_transfer and *master_xfer that give warnings.

This patch is already in the -mm tree, and will be sent to Linus in a
few days.

thanks,

greg k-h
