Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264327AbTEGXX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbTEGXVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:21:36 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:6528 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264327AbTEGXSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:18:39 -0400
Date: Wed, 7 May 2003 16:32:57 -0700
From: Greg KH <greg@kroah.com>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPUFreq sysfs interface MIA?
Message-ID: <20030507233257.GA4481@kroah.com>
References: <873cjsv8hg.fsf@enki.rimspace.net> <20030506211210.GA3148@kroah.com> <87n0hzbnk6.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87n0hzbnk6.fsf@enki.rimspace.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 10:36:09AM +1000, Daniel Pittman wrote:
> On Tue, 6 May 2003, Greg KH wrote:
> > On Tue, May 06, 2003 at 05:29:15PM +1000, Daniel Pittman wrote:
> >> 
> >> The content of /sys/devices/sys/cpu0 is:
> >> /sys/devices/sys/cpu0
> >> |-- name
> >> `-- power
> > 
> > What does /sys/class/cpu show?
> 
> /sys/class/cpu
> `-- cpu0
>     `-- device -> ../../../devices/sys/cpu0

Oops, forgot to hook up stuff...  Does the following patch from Jonathan
Corbet fix this?

thanks,

greg k-h


# cpufreq class fix

diff -Nru a/include/linux/cpu.h b/include/linux/cpu.h
--- a/include/linux/cpu.h	Wed May  7 16:29:37 2003
+++ b/include/linux/cpu.h	Wed May  7 16:29:37 2003
@@ -29,6 +29,7 @@
 };
 
 extern int register_cpu(struct cpu *, int, struct node *);
+extern struct class cpu_class;
 
 /* Stop CPUs going up and down. */
 extern struct semaphore cpucontrol;
diff -Nru a/kernel/cpufreq.c b/kernel/cpufreq.c
--- a/kernel/cpufreq.c	Wed May  7 16:29:37 2003
+++ b/kernel/cpufreq.c	Wed May  7 16:29:37 2003
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/cpu.h>
 
 /**
  * The "cpufreq driver" - the arch- or hardware-dependend low
@@ -115,6 +116,7 @@
 extern struct device_class cpu_devclass;
 
 static struct class_interface cpufreq_interface = {
+        .class =	&cpu_class,
         .add =		&cpufreq_add_dev,
         .remove =	&cpufreq_remove_dev,
 };
