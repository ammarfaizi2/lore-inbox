Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVKUSSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVKUSSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 13:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVKUSSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 13:18:43 -0500
Received: from mail.metronet.co.uk ([213.162.97.75]:48563 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S932432AbVKUSSm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 13:18:42 -0500
Date: Mon, 21 Nov 2005 18:17:22 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Cc: blaisorblade@yahoo.it, davej@codemonkey.org.uk, davej@redhat.com
Subject: [patch 1/1] cpufreq_conservative/ondemand: invert meaning of 'ignore nice'
Message-ID: <20051121181722.GA2599@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The use of the 'ignore_nice' sysfs file is confusing to anyone using it. This 
removes the sysfs file 'ignore_nice' and in its place creates a 
'ignore_nice_load' entry which defaults to '1'; meaning nice'd processes are 
not counted towards the 'business' calculation.

WARNING: this obvious breaks any userland tools that expected ignore_nice' to 
exist, to draw attention to this fact it was concluded on the mailing list 
that the entry should be removed altogether so the userland app breaks and so 
the author can build simple to detect workaround.  Having said that it seems 
currently very few tools even make use of this functionality; all I could 
find was a Gentoo Wiki entry.

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_inverse_ignore_nice_flag.diff"

diff -u -r linux-2.6.14.orig/drivers/cpufreq/cpufreq_conservative.c linux-2.6.14/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.14.orig/drivers/cpufreq/cpufreq_conservative.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/cpufreq/cpufreq_conservative.c	2005-11-21 18:10:00.834518250 +0000
@@ -127,7 +127,7 @@
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
 show_one(down_threshold, down_threshold);
-show_one(ignore_nice, ignore_nice);
+show_one(ignore_nice_load, ignore_nice);
 show_one(freq_step, freq_step);
 
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused, 
@@ -207,7 +207,7 @@
 	return count;
 }
 
-static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+static ssize_t store_ignore_nice_load(struct cpufreq_policy *policy,
 		const char *buf, size_t count)
 {
 	unsigned int input;
@@ -272,7 +272,7 @@
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
 define_one_rw(down_threshold);
-define_one_rw(ignore_nice);
+define_one_rw(ignore_nice_load);
 define_one_rw(freq_step);
 
 static struct attribute * dbs_attributes[] = {
@@ -282,7 +282,7 @@
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
 	&down_threshold.attr,
-	&ignore_nice.attr,
+	&ignore_nice_load.attr,
 	&freq_step.attr,
 	NULL
 };
diff -u -r linux-2.6.14.orig/drivers/cpufreq/cpufreq_ondemand.c linux-2.6.14/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.14.orig/drivers/cpufreq/cpufreq_ondemand.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/cpufreq/cpufreq_ondemand.c	2005-11-21 18:10:00.862520000 +0000
@@ -119,7 +119,7 @@
 show_one(sampling_rate, sampling_rate);
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
-show_one(ignore_nice, ignore_nice);
+show_one(ignore_nice_load, ignore_nice);
 
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused, 
 		const char *buf, size_t count)
@@ -179,7 +179,7 @@
 	return count;
 }
 
-static ssize_t store_ignore_nice(struct cpufreq_policy *policy,
+static ssize_t store_ignore_load_tasks(struct cpufreq_policy *policy,
 		const char *buf, size_t count)
 {
 	unsigned int input;
@@ -220,7 +220,7 @@
 define_one_rw(sampling_rate);
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
-define_one_rw(ignore_nice);
+define_one_rw(ignore_nice_load);
 
 static struct attribute * dbs_attributes[] = {
 	&sampling_rate_max.attr,
@@ -228,7 +228,7 @@
 	&sampling_rate.attr,
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
-	&ignore_nice.attr,
+	&ignore_nice_load.attr,
 	NULL
 };
 

--rwEMma7ioTxnRzrJ--
