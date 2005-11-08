Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965282AbVKHDH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965282AbVKHDH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965311AbVKHDH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:07:27 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:11208 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965282AbVKHDH1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:07:27 -0500
Date: Mon, 7 Nov 2005 19:07:15 -0800
From: Paul Jackson <pj@sgi.com>
To: "Rohit, Seth" <rohit.seth@intel.com>
Cc: akpm@osdl.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
Message-Id: <20051107190715.4d7b0f71.pj@sgi.com>
In-Reply-To: <20051107174349.A8018@unix-os.sc.intel.com>
References: <20051107174349.A8018@unix-os.sc.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seth wrote:
> +/* get_page_from_freeliest loops through all the possible zones
> + * to find out if it can allocate a page.  can_try_harder can have following
> + * values:
> + * -1 => No need to check for the watermarks.
> + *  0 => Don't go too low down in deeps below the low watermark (GFP_HIGH)
> + *  1 => Go far below the low watermark.  See zone_watermark_ok (RT TASK)

Argh.

These magic numbers, where in terms of how hard to try, 0 is less than
1 is less than -1, but where the order -does- matter for parsing such
tests as "if ((can_try_harder >= 0)" and where one has to read the
entire code to guess that, continue to give me conniptions.

I thought Nick had an alternative proposal, involving just boolean
flags.  Why didn't you ever consider that?


> + * cpuset check is not performed when the skip_cpuset_chk flag is set.
> + */
> +
> +static struct page *
> +get_page_from_freelist(gfp_t gfp_mask, unsigned int order, struct zone **zones, 
> +			int can_try_harder, int skip_cpuset_chk)

Well - thanks for thinking of me ;).  Though, as I suggested in my
reply last time, including a pseudo patch, I thought that the existing
flags such as can_try_harder had enough information to determine when
to do the cpuset check, without yet another flag for that.  Having now
two magic 1's and 0's at the end of the calling argument lists is even
less readable.


Seth wrote in a later message, responding to Andrew:
> I think it will be easier to do this change as a follow on patch as that
> will change the header file, function definition and such.  Can we defer
> this to separate follow on patch.

I have no clue what patch you have in mind here.  Guess I'd have to see it.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
