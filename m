Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933751AbWKWOHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933751AbWKWOHD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 09:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933753AbWKWOHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 09:07:03 -0500
Received: from twin.jikos.cz ([213.151.79.26]:50925 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S933751AbWKWOHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 09:07:00 -0500
Date: Thu, 23 Nov 2006 15:06:24 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-linuxkernel@reub.net>
Subject: [PATCH] x86_64: fix build without HOTPLUG_CPU (was Re: 2.6.19-rc6-mm1)
In-Reply-To: <45657A41.2040400@reub.net>
Message-ID: <Pine.LNX.4.64.0611231503520.8069@twin.jikos.cz>
References: <20061123021703.8550e37e.akpm@osdl.org> <45657A41.2040400@reub.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006, Reuben Farrelly wrote:

> > http://userweb.kernel.org/~akpm/2.6.19-rc6-mm1/
> arch/x86_64/kernel/vsyscall.c: In function 'vsyscall_init':
> arch/x86_64/kernel/vsyscall.c:310: error: 'cpu_vsyscall_notifier' undeclared
> (first use in this function)
> arch/x86_64/kernel/vsyscall.c:310: error: (Each undeclared identifier is
> reported only once
> arch/x86_64/kernel/vsyscall.c:310: error: for each function it appears in.)
> make[1]: *** [arch/x86_64/kernel/vsyscall.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2

[PATCH] x86_64: fix build without HOTPLUG_CPU

cpu_vsyscall_notifier() is defined only when CONFIG_HOTPLUG_CPU is 
defined.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>

--- 

 arch/x86_64/kernel/vsyscall.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index 3416462..e93ffcf 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -307,7 +307,9 @@ #ifdef CONFIG_SYSCTL
 	register_sysctl_table(kernel_root_table2, 0);
 #endif
 	on_each_cpu(cpu_vsyscall_init, NULL, 0, 1);
+#ifdef CONFIG_HOTPLUG_CPU
 	hotcpu_notifier(cpu_vsyscall_notifier, 0);
+#endif
 	return 0;
 }
 

-- 
Jiri Kosina
SUSE Labs

