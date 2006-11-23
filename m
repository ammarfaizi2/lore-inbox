Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933804AbWKWPiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933804AbWKWPiX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933810AbWKWPiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:38:22 -0500
Received: from twin.jikos.cz ([213.151.79.26]:58768 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S933804AbWKWPiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:38:22 -0500
Date: Thu, 23 Nov 2006 16:37:53 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] x86_64: fix build without HOTPLUG_CPU (was Re:
 2.6.19-rc6-mm1)
In-Reply-To: <20061123152734.GG29738@bingen.suse.de>
Message-ID: <Pine.LNX.4.64.0611231634090.8069@twin.jikos.cz>
References: <20061123021703.8550e37e.akpm@osdl.org> <45657A41.2040400@reub.net>
 <Pine.LNX.4.64.0611231503520.8069@twin.jikos.cz> <p731wnu42vt.fsf@bingen.suse.de>
 <Pine.LNX.4.64.0611231611510.8069@twin.jikos.cz> <20061123152734.GG29738@bingen.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006, Andi Kleen wrote:

> > Well, is it really? 6b3d1a95ba714bfb1cc81362f7f3e01b7654b4f3 adds the 
> > ifdef around the cpu_vsyscall_notifier() declaration, but later it's 
> > passed as parameter to hotcpu_notifier() unconditionally. This is fixed by 
> > the patch I sent.
> hotcpu_notifier is a macro that expands to nothing for !CONFIG_HOTPLUG_CPU

Now I see where does the confusion come from. 2.6.19-rc6-mm1 has 
hotplug-cpu-clean-up-hotcpu_notifier-use.patch from Ingo (CC added), which 
does this, among other things:

-#define hotcpu_notifier(fn, pri)       do { } while (0)
-#define register_hotcpu_notifier(nb)   do { } while (0)
-#define unregister_hotcpu_notifier(nb) do { } while (0)
+#define hotcpu_notifier(fn, pri)       do { (void)(fn); } while (0)
+#define register_hotcpu_notifier(nb)   do { (void)(nb); } while (0)
+#define unregister_hotcpu_notifier(nb) do { (void)(nb); } while (0)

-- 
Jiri Kosina
SUSE Labs

