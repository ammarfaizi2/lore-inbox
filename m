Return-Path: <linux-kernel-owner+w=401wt.eu-S1161017AbXALHcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbXALHcD (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:32:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161019AbXALHcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:32:03 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40006 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161017AbXALHcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:32:01 -0500
Date: Thu, 11 Jan 2007 23:31:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Miles Lane" <miles.lane@gmail.com>
Cc: avi@qumranet.com, yaniv@qumranet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc4-mm1 -- WARNING: "profile_hits"
 [drivers/kvm/kvm-intel.ko] undefined!
Message-Id: <20070111233157.01341bea.akpm@osdl.org>
In-Reply-To: <a44ae5cd0701112318r9472505m106cb7dd65c4c836@mail.gmail.com>
References: <a44ae5cd0701112318r9472505m106cb7dd65c4c836@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jan 2007 01:18:17 -0600
"Miles Lane" <miles.lane@gmail.com> wrote:

> WARNING: "profile_hits" [drivers/kvm/kvm-intel.ko] undefined!

This?

From: Andrew Morton <akpm@osdl.org>

export profile_hits() on !SMP too.

Cc: Ingo Molnar <mingo@elte.hu>
Cc: Avi Kivity <avi@qumranet.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 kernel/profile.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/profile.c~kvm-add-vm-exit-profiling-fix kernel/profile.c
--- a/kernel/profile.c~kvm-add-vm-exit-profiling-fix
+++ a/kernel/profile.c
@@ -331,7 +331,6 @@ out:
 	local_irq_restore(flags);
 	put_cpu();
 }
-EXPORT_SYMBOL_GPL(profile_hits);
 
 static int __devinit profile_cpu_callback(struct notifier_block *info,
 					unsigned long action, void *__cpu)
@@ -401,6 +400,8 @@ void profile_hits(int type, void *__pc, 
 }
 #endif /* !CONFIG_SMP */
 
+EXPORT_SYMBOL_GPL(profile_hits);
+
 void profile_tick(int type)
 {
 	struct pt_regs *regs = get_irq_regs();
_

