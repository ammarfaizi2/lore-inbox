Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161009AbWJDO2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161009AbWJDO2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 10:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161124AbWJDO2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 10:28:02 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:15284 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161009AbWJDO2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 10:28:01 -0400
Date: Wed, 4 Oct 2006 07:27:46 -0700
From: Paul Jackson <pj@sgi.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, reinette.chatre@linux.intel.com,
       linux-kernel@vger.kernel.org, inaky@linux.intel.com
Subject: Re: [PATCH] bitmap: bitmap_parse takes a kernel buffer instead of a
 user buffer
Message-Id: <20061004072746.8e4b97a0.pj@sgi.com>
In-Reply-To: <20061004141405.GA22833@tsunami.ccur.com>
References: <200610030816.27941.reinette.chatre@linux.intel.com>
	<20061003163936.d8e26629.akpm@osdl.org>
	<20061004141405.GA22833@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am slightly concerned about using a kmalloc where 'count' is specified
> by userspace.  There might be a DoS attack in here somewhere.....

Good point.  One should usually guard such a kmalloc, by checking the
count from user space against some crude upper limit, that is big
enough for any legitimate purposes, but avoids trying to allocate some
humongous amount.  For example, see kernel/cpuset.c:

        /* Crude upper limit on largest legitimate cpulist user might write. */
        if (nbytes > 100 + 6 * NR_CPUS)
                return -E2BIG;

> Perhaps we can reverse Andrew's idea: rename the existing bitmap_parse
> to bitmap_parse_user, then make the kernel-buffer version, bitmap_parse,
> be a wrapper around that.

Perhaps I should have my coffee first, but I don't see where the
order in which we wrap these affects the need to impose a crude
upper limit on what the user can ask for.

Off hand, I'd expect the kernel version to be the actual implementing
code, and the user version to be the wrapper and also to impose the
crude upper limit.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
