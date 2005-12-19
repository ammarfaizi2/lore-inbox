Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVLSMCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVLSMCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 07:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVLSMCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 07:02:44 -0500
Received: from ausmtp03.au.ibm.com ([202.81.18.151]:49299 "EHLO
	ausmtp03.au.ibm.com") by vger.kernel.org with ESMTP id S932432AbVLSMCn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 07:02:43 -0500
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
MIME-Version: 1.0
Subject: Re: [openib-general] [PATCH 07/13]  [RFC] ipath core misc files
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OF1B7C4042.2950A6E5-ON652570DC.00423BBB-652570DC.004228D5@in.ibm.com>
From: Krishna Kumar2 <krkumar2@in.ibm.com>
Date: Mon, 19 Dec 2005 17:35:39 +0530
X-MIMETrack: Serialize by Router on d23m0069/23/M/IBM(Release 6.53HF294 | January 28, 2005) at
 19/12/2005 17:35:41,
	Serialize complete at 19/12/2005 17:35:41
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please ignore if you see this twice, I am sending this a second time as I 
got an error
on previous send)

Roland Dreier <rolandd@cisco.com> wrote:

...
> +int ipath_mlock(unsigned long start_page, size_t num_pages, struct page 
**p)
> +{
> +   int n;
> +
> +   _IPATH_VDBG("pin %lx pages from vaddr %lx\n", num_pages, 
start_page);
> +   down_read(&current->mm->mmap_sem);
> +   n = get_user_pages(current, current->mm, start_page, num_pages, 1, 
1,
> +            p, NULL);
> +   up_read(&current->mm->mmap_sem);
> +   if (n != num_pages) {
> +      _IPATH_INFO
> +          ("get_user_pages (0x%lx pages starting at 0x%lx failed with 
%d\n",
> +           num_pages, start_page, n);
> +      if (n < 0)   /* it's an errno */
> +         return n;
> +      return -ENOMEM;   /* no way to know actual error */
> +   }
> +
> +   return 0;
> +}

For this routine (where num_pages can be >1), in the error case you need 
to 
page_cache_release() the pages that were successfully 'got' 
(get_page()'d).

- KK

