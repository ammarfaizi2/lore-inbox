Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWCFPoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWCFPoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 10:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWCFPoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 10:44:12 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:31184 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751153AbWCFPoJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 10:44:09 -0500
Subject: Re: + memory-hotplug-compile-fix.patch added to -mm tree
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kamezawa.hiroyu@jp.fujitsu.com, mm-commits@vger.kernel.org
In-Reply-To: <200603040753.k247rbNK012054@shell0.pdx.osdl.net>
References: <200603040753.k247rbNK012054@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Mon, 06 Mar 2006 07:43:20 -0800
Message-Id: <1141659800.9274.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-03 at 23:52 -0800, akpm@osdl.org wrote:
> diff -puN include/linux/memory_hotplug.h~memory-hotplug-compile-fix include/linux/memory_hotplug.h
> --- devel/include/linux/memory_hotplug.h~memory-hotplug-compile-fix     2006-03-03 23:50:50.000000000 -0800
> +++ devel-akpm/include/linux/memory_hotplug.h   2006-03-03 23:51:45.000000000 -0800
> @@ -6,6 +6,10 @@
>  #include <linux/mmzone.h>
>  #include <linux/notifier.h>
>  
> +struct page;
> +struct zone;
> +struct pglist_data;

There are places in that file where we dereference both zone and pgdat
struct pointers.  struct page, on the other hand, is only a function
argument.  So, the predeclaration should be fine for pages.  But, it
probably won't do any good for zones or pgdats.  

-- Dave

