Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWG1FTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWG1FTM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWG1FTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:19:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:4075 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750953AbWG1FTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:19:11 -0400
Date: Thu, 27 Jul 2006 22:19:00 -0700
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, npiggin@suse.de, mingo@elte.hu,
       sivanich@sgi.com
Subject: Re: + sched-force-sbin-init-off-isolated-cpus.patch added to -mm
 tree
Message-Id: <20060727221900.d87afdcc.pj@sgi.com>
In-Reply-To: <200607280451.k6S4pEY9027994@shell0.pdx.osdl.net>
References: <200607280451.k6S4pEY9027994@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick wrote:
> Force /sbin/init off isolated cpus (unless every CPU is specified as an
> isolcpu).

For our big honkin NUMA iron SGI customers, who are serious about this
sort of thing, we actually already do this, entirely in user space.  I
use the init= kernel command line boot option to run a pre-init program,
that sets up a configurable (by a config file in /etc) cpuset, then
exec's the real init in that cpuset.  This feature is known to SGI
customers as the "bootcpuset."

But Nick's patch looks ok to me.  It seems harmless enough for our NUMA
power users - as the bootcpuset they configured will just override what
Nick's code did a few milliseconds (to read the pre-init executable off
the disk) earlier, harmlessly.  Meanwhile, the remaining (and likely
vast majority of) isolcpu users will get the behaviour they prefer.

Acked-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
