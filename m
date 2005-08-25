Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbVHYFcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbVHYFcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbVHYFcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:32:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63917 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964844AbVHYFcT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:32:19 -0400
Date: Wed, 24 Aug 2005 22:32:09 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: cpu_exclusive sched domains fix broke ppc64
Message-Id: <20050824223209.352a5f87.pj@sgi.com>
In-Reply-To: <17164.11361.437380.179789@cargo.ozlabs.ibm.com>
References: <17164.11361.437380.179789@cargo.ozlabs.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A day or two ago, Paul M. wrote:
> Compiling -rc7 for ppc64 using pSeries_defconfig I get this compile
> error:

Not that the following really matters ... I've already sent in a fix,
based on your analysis, followed by Nick's suggestion that we don't do
it this way anyway.

... however ... question for Paul M. ...  what version of gcc did this fail on?

I finally got my crosstools setup working for me again, and building
a powerpc64 using gcc-3.4.0 on my Intel PC box does _not_ fail.  That
build goes through fine.  This is with CONFIG_CPUSETS=y, but without my
fix of early this Wednesday to put the cpumask in question into a local
variable.

Either I've managed to confuse myself (most likely) or else this gcc
3.4 is newer than you were using, and this newer gcc has gotten smart
enough to unravel this particular case and recognize that there actually
is already a memory object (the array of cpumasks, one per node, specifying
which cpus are on that node) laying around that can be used here.

Strange.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
