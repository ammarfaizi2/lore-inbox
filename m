Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWJEWcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWJEWcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 18:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWJEWcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 18:32:46 -0400
Received: from mga07.intel.com ([143.182.124.22]:34399 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932384AbWJEWcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 18:32:45 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,267,1157353200"; 
   d="scan'208"; a="127532582:sNHT26792647"
Message-ID: <1577.10.24.192.66.1160087563.squirrel@linux.intel.com>
In-Reply-To: <200610051448.34866.reinette.chatre@linux.intel.com>
References: <200610041756.30528.reinette.chatre@linux.intel.com>
    <20061004185747.4cb64048.akpm@osdl.org>
    <200610051249.07856.reinette.chatre@linux.intel.com>
    <200610051448.34866.reinette.chatre@linux.intel.com>
Date: Thu, 5 Oct 2006 15:32:43 -0700 (PDT)
Subject: Re: [PATCH] bitmap: parse input from kernel and user buffers
From: "Inaky Perez-Gonzalez" <inaky@linux.intel.com>
To: "Reinette Chatre" <reinette.chatre@linux.intel.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Inaky Perez-Gonzalez" <inaky@linux.intel.com>,
       "Joe Korty" <joe.korty@ccur.com>, "Paul Jackson" <pj@sgi.com>,
       linux-kernel@vger.kernel.org, reinette.chatre@linux.intel.com
User-Agent: SquirrelMail/1.4.6-7.el4.centos4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reinette Chatre wrote:
> lib/bitmap.c:bitmap_parse() is a library function that received as
> input a user buffer. This seemed to have originated from the way
> the write_proc function of the /proc filesystem operates.
>
> This has been reworked to not use kmalloc and eliminates a lot
> of get_user() overhead by performing one access_ok before using
> __get_user().
> We need to test if we are in kernel or user space (is_user) and access
> the buffer differently. We cannot use __get_user() to access kernel
> addresses in all cases, for example in architectures with separate
> address space for kernel and user.
>
> This function will be useful for other uses as well; for example,
> taking input  for /sysfs instead of /proc, so it was changed to accept
> kernel buffers. We have this use for the Linux UWB project, as part
> as the upcoming bandwidth allocator code.
>
> Only a few routines used this function and they were changed too.
>
> Signed-off-by: Reinette Chatre <reinette.chatre@linux.intel.com>
Signed-off-by: Inaky Perez-Gonzalez <inaky@linux.intel.com>
