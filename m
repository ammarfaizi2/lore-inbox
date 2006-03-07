Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752487AbWCGMK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbWCGMK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbWCGMK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:10:28 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:4765 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752487AbWCGMK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:10:27 -0500
Date: Tue, 7 Mar 2006 17:39:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       fabbione@ubuntu.com
Subject: Re: VFS nr_files accounting
Message-ID: <20060307120916.GD5946@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060305070537.GB21751@in.ibm.com> <20060304.233725.49897411.davem@davemloft.net> <20060305113847.GE21751@in.ibm.com> <20060306.123904.35238417.davem@davemloft.net> <20060307064120.GA5946@in.ibm.com> <20060306230639.24eacb6c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306230639.24eacb6c.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 11:06:39PM -0800, Andrew Morton wrote:
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> >
> >  > I think we should seriously consider these patches for 2.6.16
> > 
> >  Isn't it a little too late in the 2.6.16 cycle ? I would have
> >  liked a little more time in -mm. Anyway, it is Linus' call. 
> >  I can refresh the patches and submit against latest mainline
> >  if Linus and Andrew want.
> 
> I'd view a 2.6.16 merge as relatively low-risk.  My main concern would be
> possible breakage of those whacky route-cache workloads.

Yes, I was hoping that more time in -mm would bring out those
whacky corner case OOM/latency problems. 

Anyway, here is the kernel paramenter documentation patch.
I am not sure if I got the restrictions in square bracket
right.

Thanks
Dipankar



Update kernel paramenters documentation for new RCU tuning
paramenters.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 Documentation/kernel-parameters.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+)

diff -puN Documentation/kernel-parameters.txt~rcu-tuning-parm-doc Documentation/kernel-parameters.txt
--- linux-2.6.16-rc3-rcu/Documentation/kernel-parameters.txt~rcu-tuning-parm-doc	2006-03-07 17:23:52.000000000 +0530
+++ linux-2.6.16-rc3-rcu-dipankar/Documentation/kernel-parameters.txt	2006-03-07 17:33:59.000000000 +0530
@@ -1280,6 +1280,19 @@ running once the system is up.
 			New name for the ramdisk parameter.
 			See Documentation/ramdisk.txt.
 
+	rcu.blimit=	[KNL,BOOT] Set maximum number of finished
+			RCU callbacks to process in one batch.
+
+	rcu.qhimark=	[KNL,BOOT] Set threshold of queued
+			RCU callbacks over which batch limiting is disabled.
+
+	rcu.qlowmark=	[KNL,BOOT] Set threshold of queued
+			RCU callbacks below which batch limiting is re-enabled.
+
+	rcu.rsinterval=	[KNL,BOOT,SMP] Set the number of additional
+			RCU callbacks to queued before forcing reschedule
+			on all cpus.
+
 	rdinit=		[KNL]
 			Format: <full_path>
 			Run specified binary instead of /init from the ramdisk,

_
