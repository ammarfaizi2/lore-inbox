Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVDCGCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVDCGCM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 01:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDCGCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 01:02:12 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:32977 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261509AbVDCGBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 01:01:49 -0500
Date: Sat, 2 Apr 2005 22:02:00 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kernel/rcupdate.c: make the exports EXPORT_SYMBOL_GPL
Message-ID: <20050403060200.GA1332@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050327143454.GJ4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327143454.GJ4285@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 04:34:54PM +0200, Adrian Bunk wrote:
> Due to the patent situation at least in the USA, the exports of 
> kernel/rcupdate.c should be EXPORT_SYMBOL_GPL.

Based on -what- line of reasoning???  The obvious ones do not apply
to this situation.

These need to be put back.  Moving them to GPL -- but in a measured
manner, as I proposed on this list some months ago -- is fine.  Changing
these particular exports precipitously is most definitely -not- fine.
Here is my earlier proposal:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=110520930301813&w=2

See below for a patch that puts the exports back, along with an updated
version of my earlier patch that starts the process of moving them to GPL.
I will also be following this message with RFC patches that introduce
two (EXPORT_SYMBOL_GPL) interfaces to replace synchronize_kernel(),
which then becomes deprecated.

Andrew, please apply.

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

diff -urpN -X ../dontdiff linux-2.5-notyet/kernel/rcupdate.c linux-2.5/kernel/rcupdate.c
--- linux-2.5-notyet/kernel/rcupdate.c	Sat Apr  2 17:15:14 2005
+++ linux-2.5/kernel/rcupdate.c	Sat Apr  2 07:54:30 2005
@@ -465,6 +465,6 @@ void synchronize_kernel(void)
 }
 
 module_param(maxbatch, int, 0);
-EXPORT_SYMBOL_GPL(call_rcu);
-EXPORT_SYMBOL_GPL(call_rcu_bh);
-EXPORT_SYMBOL_GPL(synchronize_kernel);
+EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */
+EXPORT_SYMBOL(synchronize_kernel);  /* WARNING: GPL-only in April 2006. */
diff -urpN -X ../dontdiff linux-2.5-2005.04.02/Documentation/feature-removal-schedule.txt linux-2.5-2005.04.02-01/Documentation/feature-removal-schedule.txt
--- linux-2.5-2005.04.02/Documentation/feature-removal-schedule.txt	Sat Apr  2 07:48:46 2005
+++ linux-2.5-2005.04.02-01/Documentation/feature-removal-schedule.txt	Sat Apr  2 21:16:24 2005
@@ -15,3 +15,16 @@ Why:	It has been unmaintained for a numb
 	against the LSB, and can be replaced by using udev.
 Who:	Greg Kroah-Hartman <greg@kroah.com>
 
+What:	RCU API moves to EXPORT_SYMBOL_GPL
+When:	April 2006
+Files:	include/linux/rcupdate.h, kernel/rcupdate.c
+Why:	Outside of Linux, the only implementations of anything even
+	vaguely resembling RCU that I am aware of are in DYNIX/ptx,
+	VM/XA, Tornado, and K42.  I do not expect anyone to port binary
+	drivers or kernel modules from any of these, since the first two
+	are owned by IBM and the last two are open-source research OSes.
+	So these will move to GPL after a grace period to allow
+	people, who might be using implementations that I am not aware
+	of, to adjust to this upcoming change.
+Who:	Paul E. McKenney <paulmck@us.ibm.com>
+
