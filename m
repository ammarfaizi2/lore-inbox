Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262538AbVCPHH4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbVCPHH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 02:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262539AbVCPHH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 02:07:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:7908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262538AbVCPHHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 02:07:48 -0500
Date: Tue, 15 Mar 2005 23:07:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, rohit.seth@intel.com
Subject: Re: [PATCH] Reading deterministic cache parameters and exporting it
 in /sysfs
Message-Id: <20050315230736.6faa3734.akpm@osdl.org>
In-Reply-To: <20050315152448.A1697@unix-os.sc.intel.com>
References: <20050315152448.A1697@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> wrote:
>
>  The attached patch adds support for using cpuid(4) instead of cpuid(2), to get 
>  CPU cache information in a deterministic way for Intel CPUs, whenever 
>  supported.

- find_num_cache_leaves can be marked __init

- Please look for other __init opportunities.  That's quite a lot of code.

- Some functions have a space before the ( and some don't:

	+static ssize_t show_size (struct _cpuid4_info *this_leaf, char *buf)

  omitting the space is preferred.

- Don't cast the return value of kmalloc:

+	cpuid4_info[cpu] = (struct _cpuid4_info *)kmalloc(
+	    sizeof(struct _cpuid4_info) * num_cache_leaves, GFP_KERNEL);

- Sometimes there's a space after an `if', sometimes not.

+		if(cpuid4_info[i])

  a space is preferred.

- kfree(NULL) is permitted:

+	if(cpuid4_info[i])
+		kfree(cpuid4_info[i]);
+	if(cache_kobject[i])
+		kfree(cache_kobject[i]);
+	if(index_kobject[i])
+		kfree(index_kobject[i]);

  (in several places)


Once you've worked through the design issues with davej, please upissue the
patch, thanks.

