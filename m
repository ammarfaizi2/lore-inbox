Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932442AbVIFIJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVIFIJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 04:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVIFIJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 04:09:26 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49830 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932442AbVIFIJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 04:09:26 -0400
Date: Tue, 6 Sep 2005 01:08:22 -0700
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: mel@csn.ul.ie, linux-kernel@vger.kernel.org, dino@in.ibm.com,
       jschopp@austin.ibm.com, Simon.Derr@bull.net, torvalds@osdl.org,
       haveblue@us.ibm.com
Subject: Re: [PATCH 0/4] cpusets mems_allowed constrain GFP_KERNEL, oom
 killer
Message-Id: <20050906010822.5cb635c0.pj@sgi.com>
In-Reply-To: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
References: <20050901090853.18441.24035.sendpatchset@jackhammer.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Please throw away the following 4 patches in 2.6.13-mm1:

  cpusets-oom_kill-tweaks.patch
  cpusets-new-__gfp_hardwall-flag.patch
  cpusets-formalize-intermediate-gfp_kernel-containment.patch
  cpusets-confine-oom_killer-to-mem_exclusive-cpuset.patch

You will see almost the same patches come back at you, in another
week, after I first send some patches to rework handling the global
cpuset semaphore cpuset_sem.

My code reading leads me to think there is a rare lockup possibility
here, where a task already holding cpuset_sem could try to get it
again in the new cpuset_zone_allowed() code.

Only systems actively manipulating cpusets have any chance of seeing
this.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
