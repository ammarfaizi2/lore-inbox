Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268235AbUJCXWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268235AbUJCXWf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268236AbUJCXWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:22:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:26522 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268235AbUJCXWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:22:32 -0400
Date: Sun, 3 Oct 2004 16:20:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, trivial@rustcorp.com.au,
       rusty@rustcorp.com.au
Subject: Re: [PATCH 2.6][resend] Add DEVPATH env variable to hotplug helper
 call
Message-Id: <20041003162012.79296b37.akpm@osdl.org>
In-Reply-To: <20041003100857.GB5804@optonline.net>
References: <20041003100857.GB5804@optonline.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Josef 'Jeff' Sipek" <jeffpc@optonline.net> wrote:
>
> Add $DEVPATH to the environmental variables during /sbin/hotplug call.
> 
>  Josef 'Jeff' Sipek.
> 
>  Signed-off-by: Josef 'Jeff' Sipek <jeffpc@optonline.net>
> 
> 
>  diff -Nru a/kernel/cpu.c b/kernel/cpu.c
>  --- a/kernel/cpu.c	2004-09-24 13:08:57 -04:00
>  +++ b/kernel/cpu.c	2004-09-24 13:08:57 -04:00
>  @@ -61,13 +61,13 @@
>    * cpu' with certain environment variables set.  */
>   static int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)

I don't think this function should exist at all.  We already have kobjects
which represent the CPUs so it should be possible to find that kobject and
use kobject_hotplug() on it.  That gives you your $DEVPATH.

Does CPU hotplug behave correctly wrt /sys/devices/system/cpu?  Given that
register_cpu() is still marked __init, I assume not.
