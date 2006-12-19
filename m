Return-Path: <linux-kernel-owner+w=401wt.eu-S932808AbWLSM0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbWLSM0z (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbWLSM0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:26:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48436 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932808AbWLSM0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:26:54 -0500
Date: Tue, 19 Dec 2006 04:26:07 -0800
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: yanmin_zhang@linux.intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jes@sgi.com, hch@lst.de, viro@zeniv.linux.org.uk, sgrubb@redhat.com,
       linux-audit@redhat.com, systemtap@sources.redhat.com
Subject: Re: Task watchers v2
Message-Id: <20061219042607.dcd865a3.pj@sgi.com>
In-Reply-To: <1166529955.995.177.camel@localhost.localdomain>
References: <20061215000754.764718000@us.ibm.com>
	<20061215000817.771088000@us.ibm.com>
	<1166420641.15989.117.camel@ymzhang>
	<1166447901.995.110.camel@localhost.localdomain>
	<20061218214159.2d571bf5.pj@sgi.com>
	<1166529955.995.177.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> Previous iterations of task watchers would prevent the code in these
> paths from being inlined. Furthermore, the code certainly wouldn't be
> placed near the table of function pointers (which was in an entirely
> different ELF section). By placing them adjacent to each other in the
> same ELF section we can improve the likelihood of cache hits in
> fork-heavy workloads (which were the ones that showed a performance
> decrease in the previous iteration of these patches).

Ah so - by marking some of the fork (and exit, exec, ...) routines
with the WATCH_TASK_* mechanism, you can compact them together in the
kernel's text pages, instead of having them scattered about based on
whatever source files they are in.

Nice.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
