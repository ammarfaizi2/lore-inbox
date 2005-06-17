Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVFQAwP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVFQAwP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 20:52:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVFQAwP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 20:52:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261874AbVFQAwL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 20:52:11 -0400
Date: Thu, 16 Jun 2005 17:51:30 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.12-rc6-mm1 & 2K lun testing
Message-Id: <20050616175130.22572451.akpm@osdl.org>
In-Reply-To: <1118965381.4301.488.camel@dyn9047017072.beaverton.ibm.com>
References: <1118856977.4301.406.camel@dyn9047017072.beaverton.ibm.com>
	<20050616002451.01f7e9ed.akpm@osdl.org>
	<1118951458.4301.478.camel@dyn9047017072.beaverton.ibm.com>
	<20050616133730.1924fca3.akpm@osdl.org>
	<1118965381.4301.488.camel@dyn9047017072.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> > Try this:
>  > 
>  > diff -puN mm/page-writeback.c~a mm/page-writeback.c
>  > --- 25/mm/page-writeback.c~a	Thu Jun 16 13:36:29 2005
>  > +++ 25-akpm/mm/page-writeback.c	Thu Jun 16 13:36:54 2005
>  > @@ -501,6 +501,8 @@ void laptop_sync_completion(void)
>  >  
>  >  static void set_ratelimit(void)
>  >  {
>  > +	ratelimit_pages = 32;
>  > +	return;
>  >  	ratelimit_pages = total_pages / (num_online_cpus() * 32);
>  >  	if (ratelimit_pages < 16)
>  >  		ratelimit_pages = 16;
>  > _
>  > 
> 
>  Wow !! Reducing the dirty ratios and the above patch did the trick.
>  Instead of 100% sys CPU, now I have only 50% in sys.

It shouldn't be necessary to do both.  Either the patch or the tuning
should fix it.  Please confirm.

Also please determine whether the deep CFQ queue depth is a problem when
the VFS tuning/patching is in place.

IOW: let's work out which of these three areas needs to be addressed.
