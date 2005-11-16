Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965174AbVKPCDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965174AbVKPCDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 21:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVKPCDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 21:03:42 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:968 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965174AbVKPCDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 21:03:41 -0500
Date: Tue, 15 Nov 2005 18:03:36 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Simon.Derr@bull.net, steiner@sgi.com
Subject: Re: [PATCH] cpuset export symbols gpl
Message-Id: <20051115180336.11139847.pj@sgi.com>
In-Reply-To: <20051115173935.5fc75e00.akpm@osdl.org>
References: <20051116012254.6470.89326.sendpatchset@jackhammer.engr.sgi.com>
	<20051115173935.5fc75e00.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote (of exporting cpuset symbols)
> We normally would do this when such modules are merged.  Do tell us more..

It was an oversight not to do this when cpusets went in last year,
but we didn't notice, as the loadable module we cared about had a
hack in place from earlier development that avoided needing this.

In cleaning this up, we realized that the module needed to access
task->cpuset->cpus_allowed, and that the correct (and safe) way to
do this, via cpuset_cpus_allowed(), was not available to the module.

The other 4 exports I added on general principles, but don't have
any pressing need for.  The one I need is cpuset_cpus_allowed().

The loadable module in question we call 'dplace', and is used to
provide fancier cpuset-relative task placement by manipulating
task->cpus_allowed at exec.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
