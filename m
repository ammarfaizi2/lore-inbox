Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWHIVCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWHIVCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 17:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWHIVCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 17:02:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:36314 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751265AbWHIVCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 17:02:46 -0400
Subject: Re: [PATCH] not empty pages list after fuse_readpages
From: Dave Hansen <haveblue@us.ibm.com>
To: Alexander Zarochentsev <zam@namesys.com>
Cc: linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net
In-Reply-To: <200608100020.29880.zam@namesys.com>
References: <200608100020.29880.zam@namesys.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 14:02:36 -0700
Message-Id: <1155157356.19249.188.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 00:20 +0400, Alexander Zarochentsev wrote:
> 
>         }
> +       if (0) {
> +clean_pages_up:
> +               readpages_cleanup_helper(pages);
> +       }
>         return err;
>  }

If the list is really empty during a normal exit, does it hurt to call
the helper?  The whole goto inside of an if(0) statement looks a little
funky.

The following would be the same number of lines of code, and this is
used pretty commonly in the kernel:

	return err;
clean_pages_up:
	readpages_cleanup_helper(pages);
	return err;

But, I really wonder what is wrong with this:

clean_pages_up:
	readpages_cleanup_helper(pages);
	return err;

-- Dave

