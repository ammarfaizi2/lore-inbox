Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWKFU4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWKFU4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 15:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753789AbWKFU4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 15:56:09 -0500
Received: from smtp-out.google.com ([216.239.33.17]:15901 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750724AbWKFU4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 15:56:08 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=UfGWQ8u1zdyqpvAROw7EH+mwV54IIAzkPu8RvIatz+xNJUH6GDTVl1bRPQ8Ko/1M6
	/oo/EDMfz5ldZxpg4i/BQ==
Message-ID: <6599ad830611061255u458a795bpca1c360cb93f253@mail.gmail.com>
Date: Mon, 6 Nov 2006 12:55:53 -0800
From: "Paul Menage" <menage@google.com>
To: balbir@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 2/6] Cpusets hooked into containers
Cc: sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net, jlan@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, pj@sgi.com,
       mbligh@google.com, winget@google.com, rohitseth@google.com
In-Reply-To: <454ED769.8040302@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061020183819.656586000@menage.corp.google.com>
	 <20061020190626.810567000@menage.corp.google.com>
	 <454ED769.8040302@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/06, Balbir Singh <balbir@in.ibm.com> wrote:
>
> I needed the following patches to get the cpuset code to compile.
> Inlining two patches makes it hard to distinguish between the patches
> and harder to read them, so I am attaching them along with this email.

The first I missed due to not compiling with CONFIG_HOTPLUG_* - thanks
for the patch.

For the second, the following change to fs/proc/base.c should have
appeared in cpusets_using_containers.patch, but got left out due to
quilt misusage. It basically makes "cpuset" an alias for "container"
in the relevant /proc directories if CONFIG_CPUSETS_LEGACY_API is
defined.

--- container-2.6.19-rc2.orig/fs/proc/base.c
+++ container-2.6.19-rc2/fs/proc/base.c
@@ -69,7 +69,6 @@
 #include <linux/ptrace.h>
 #include <linux/seccomp.h>
 #include <linux/container.h>
-#include <linux/cpuset.h>
 #include <linux/audit.h>
 #include <linux/poll.h>
 #include <linux/nsproxy.h>
@@ -1784,8 +1783,8 @@ static struct pid_entry tgid_base_stuff[
 #ifdef CONFIG_CONTAINERS
 	REG("container",  S_IRUGO, container),
 #endif
-#ifdef CONFIG_CPUSETS
-	REG("cpuset",     S_IRUGO, cpuset),
+#ifdef CONFIG_CPUSETS_LEGACY_API
+	REG("cpuset",     S_IRUGO, container),
 #endif
 	INF("oom_score",  S_IRUGO, oom_score),
 	REG("oom_adj",    S_IRUGO|S_IWUSR, oom_adjust),
@@ -2061,8 +2060,8 @@ static struct pid_entry tid_base_stuff[]
 #ifdef CONFIG_CONTAINERS
 	REG("container",  S_IRUGO, container),
 #endif
-#ifdef CONFIG_CPUSETS
-	REG("cpuset",    S_IRUGO, cpuset),
+#ifdef CONFIG_CPUSETS_LEGACY_API
+	REG("cpuset",    S_IRUGO, container),
 #endif
 	INF("oom_score", S_IRUGO, oom_score),
 	REG("oom_adj",   S_IRUGO|S_IWUSR, oom_adjust),

Paul
