Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265786AbUFWTrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265786AbUFWTrV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 15:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266618AbUFWTrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 15:47:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44251 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265786AbUFWTqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 15:46:49 -0400
Message-ID: <40D9DE1C.8020005@pobox.com>
Date: Wed, 23 Jun 2004 15:46:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dean Nelson <dcn@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] replace assorted ASSERT()s by something officially  sanctioned
References: <40D9D09D.mailx49E1J10NF@aqua.americas.sgi.com>
In-Reply-To: <40D9D09D.mailx49E1J10NF@aqua.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean Nelson wrote:
> It doesn't appear that an officially 'sanctioned' version of ASSERT() or
> an ASSERT()-like macro exists.
> 
> And by the proliferation of its use in the linux 2.6 kernel (I saw over
> 3000 references to it), it would seem that BUG_ON() does not satisfy all
> of the requirements of the community.
> 
> One problem with BUG_ON() is that it is always enabled. And even though
> the compiler does a good job of minimizing the impact of the conditional
> expression, there are times when the conditional check requires the
> accessing of a cacheline that would not get accessed had the BUG_ON() not
> been enabled. And if that cacheline were one that is hotly contended for,
> one's performance can be adversely affected.
> 
> For debugging purposes it would be nice to have a version of BUG_ON() that
> was only enabled if DEBUG was set. This is what appears to be behind the use
> of the ASSERT()-like macros.
> 
> As an example of what I have in mind, I've included the following quilt
> patch.
> 
> Thanks,
> Dean
> 
> 
> Index: linux/include/asm-i386/bug.h
> ===================================================================
> --- linux.orig/include/asm-i386/bug.h
> +++ linux/include/asm-i386/bug.h
> @@ -21,6 +21,12 @@
>  
>  #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
>  
> +#ifdef DEBUG
> +#define DBUG_ON(condition)	BUG_ON(condition)
> +#else
> +#define DBUG_ON(condition)
> +#endif

This won't work as it often needs to be driver-granular.  Also, 
WARN_ON() is often the closer implementation of assert(), than BUG_ON()

	Jeff



