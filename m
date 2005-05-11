Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVEKUqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVEKUqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 16:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbVEKUqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 16:46:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8399 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262052AbVEKUqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 16:46:08 -0400
Date: Wed, 11 May 2005 13:45:54 -0700
From: Paul Jackson <pj@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: dino@in.ibm.com, Simon.Derr@bull.net, lse-tech@lists.sourceforge.net,
       akpm@osdl.org, nickpiggin@yahoo.com.au, vatsa@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [PATCH] cpusets+hotplug+preepmt broken
Message-Id: <20050511134554.3d72db59.pj@sgi.com>
In-Reply-To: <20050511202648.GF3614@otto>
References: <20050511191654.GA3916@in.ibm.com>
	<20050511122543.6e9f6097.pj@sgi.com>
	<20050511125508.20bf44ec.pj@sgi.com>
	<20050511202648.GF3614@otto>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan asked:
> Won't holding cpuset_sem while calling cpuset_cpus_allowed cause a
> deadlock?

It definitely would, which is why Dinakar's patch both added a call to
get cpuset_sem earlier in the hot unplug code, as well as removed the
call to get cpuset_sem that was inside the cpuset_cpus_allowed code (as
well as modified the other caller of cpuset_cpus_allowed, the
sched_setaffinity code, to explicitly get cpuset_sem before calling
cpuset_cpus_allowed, since that call no longer acquired cpuset_sem on
its own.


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
