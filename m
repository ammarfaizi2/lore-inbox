Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbWEKIH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbWEKIH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 04:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWEKIH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 04:07:29 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10197 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965204AbWEKIH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 04:07:28 -0400
Date: Thu, 11 May 2006 01:06:58 -0700
From: Paul Jackson <pj@sgi.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: akpm@osdl.org, bunk@stusta.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as
 unused-for-removal-soon
Message-Id: <20060511010658.c1e11d02.pj@sgi.com>
In-Reply-To: <4462E474.9020200@linux.intel.com>
References: <1146581587.32045.41.camel@laptopd505.fenrus.org>
	<20060510233427.4306422b.pj@sgi.com>
	<4462E474.9020200@linux.intel.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan wrote:
> not in the configs I tested at least... but maybe I need to add a specific config to
> my set..

Dang - I think you're right.

The original version of the patch that provided the new routine
cpuset_mem_spread_node() on about Feb 2, 2006 required that EXPORT, as
in that version cpuset_mem_spread_node() was called from the inline
versions of page_cache_alloc() and page_cache_alloc_cold().

But the final version of the cpuset_mem_spread_node() patch, on about
Feb 9, 2006, does not seem to require that EXPORT, because the callers
page_cache_alloc() and page_cache_alloc_code() were taken -out-of-line-
for the configurations that made use of cpuset_mem_spread_node().

However the EXPORT had already been added on about Feb 6 or 7, when
everyone and his brother noticed that I had broken the build with my
Feb 2 patch.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
