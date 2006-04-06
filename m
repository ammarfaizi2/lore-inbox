Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751339AbWDFWFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbWDFWFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbWDFWFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:05:41 -0400
Received: from blackbird.sr71.net ([64.146.134.44]:44677 "EHLO
	blackbird.sr71.net") by vger.kernel.org with ESMTP id S1751339AbWDFWFk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:05:40 -0400
Subject: Re: [Patch:003/004] wait_table and zonelist initializing for
	memory hotadd (wait_table initialization)
From: Dave Hansen <dave@sr71.net>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
In-Reply-To: <20060405195913.3C45.Y-GOTO@jp.fujitsu.com>
References: <20060405192737.3C3F.Y-GOTO@jp.fujitsu.com>
	 <20060405195913.3C45.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Thu, 06 Apr 2006 15:05:04 -0700
Message-Id: <1144361104.9731.190.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-05 at 20:01 +0900, Yasunori Goto wrote:
> 
> +#ifdef CONFIG_MEMORY_HOTPLUG
>  static inline unsigned long wait_table_size(unsigned long pages)
>  {
>         unsigned long size = 1;
> @@ -1803,6 +1804,17 @@ static inline unsigned long wait_table_s
>  
>         return max(size, 4UL);
>  }
> +#else
> +/*
> + * XXX: Because zone size might be changed by hot-add,
> + *      It is hard to determin suitable size for wait_table as
> traditional.
> + *      So, we use maximum size now.
> + */
> +static inline unsigned long wait_table_size(unsigned long pages)
> +{
> +       return 4096UL;
> +}
> +#endif 

Sorry for the slow response.  My IBM email is temporarily dead.

Couple of things.  

First, is there anything useful that prepending UL to the constants does
to the functions?  It ends up looking a little messy to me.

Also, I thought you were going to put a big fat comment on there about
doing it correctly in the future.  It would also be nice to quantify the
wasted space in terms of bytes, just so that people get a feel for it.

Oh, and wait_table_size() needs a unit.  wait_table_size_bytes() sounds
like a winner to me.

-- Dave

