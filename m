Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWHBU6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWHBU6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 16:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWHBU6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 16:58:12 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44219 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751227AbWHBU6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 16:58:11 -0400
Subject: Re: [RFC][PATCH] enable VMSPLIT for highmem kernels
From: Dave Hansen <haveblue@us.ibm.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060802205533.CBD06E21@localhost.localdomain>
References: <20060802205533.CBD06E21@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 02 Aug 2006 13:57:56 -0700
Message-Id: <1154552277.7232.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, I somehow managed to post that without appending my description.
Here goes:

The current VMSPLIT Kconfig option is disabled whenever highmem
is on.  This is a bit screwy because the people who need to
change VMSPLIT the most tend to be the ones with highmem and
constrained lowmem.

So, remove the highmem dependency.  But, re-include the
dependency for the "full 1GB of lowmem" option.  You can't have
the full 1GB of lowmem and highmem because of the need for the
vmalloc(), kmap(), etc... areas.

I thought there would be at least a bit of tweaking to do to
get it to work, but everything seems OK.

Boot tested on a 4GB x86 machine, and a 12GB 3-node NUMA-Q:

elm3b82:~# cat /proc/meminfo
MemTotal:      3695412 kB
MemFree:       3659540 kB
...
LowTotal:      2909008 kB
LowFree:       2892324 kB
...
elm3b82:~# zgrep PAE /proc/config.gz
CONFIG_X86_PAE=y

larry:~# cat /proc/meminfo
MemTotal:     11845900 kB
MemFree:      11786748 kB
...
LowTotal:      2855180 kB
LowFree:       2830092 kB

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>

-- Dave

