Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751625AbWD0UpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbWD0UpE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751650AbWD0UpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:45:04 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12691 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751625AbWD0UpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:45:02 -0400
Date: Thu, 27 Apr 2006 13:44:42 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@surriel.com,
       nickpiggin@yahoo.com.au, ak@suse.de, akpm@osdl.org
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Message-Id: <20060427134442.639a6d19.pj@sgi.com>
In-Reply-To: <200604271308.10080.dsp@llnl.gov>
References: <200604271308.10080.dsp@llnl.gov>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> @@ -350,6 +353,8 @@ struct mm_struct {
>  	/* aio bits */
>  	rwlock_t		ioctx_list_lock;
>  	struct kioctx		*ioctx_list;
> +
> +	unsigned long flags;

I see Andi didn't reply to your question concerning what
struct he saw a 'flags' in.

Adding a flags word still costs a slot in mm_struct.

Adding a 'oom_notify' bitfield after the existing 'dumpable'
bitfield in mm_struct would save that slot:

        unsigned dumpable:2;
	unsigned oom_notify:1;

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
