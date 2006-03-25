Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWCYLv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWCYLv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 06:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbWCYLv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 06:51:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62678 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751376AbWCYLv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 06:51:26 -0500
Date: Sat, 25 Mar 2006 03:47:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP busted on non-cpu-hotplug systems
Message-Id: <20060325034744.35b70f43.akpm@osdl.org>
In-Reply-To: <20060325.024226.53296559.davem@davemloft.net>
References: <20060325.024226.53296559.davem@davemloft.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> wrote:
>
> 
> I just noticed this on sparc64, as I lost 31 cpus on my
> Niagara box due to it :)
> 
> boot_cpu_init() sets the boot processor ID in cpu_present_map.
> 
> But fixup_cpu_present_map() will only populate the cpu_present_map if
> it is empty, which it won't be because of what boot_cpu_init() just
> did.

oops.  I guess most architectures set cpu_present_map while bringing up the
APs.

I think it'd be cleanest to require that the arch do that -
fixup_cpu_present_map() looks like a bit of a hack.

I guess if we want to perpetuate fixup_cpu_present_map() then we should
teach it to ignore the boot cpu.   (cpus_weight(&cpu_present_map) == 1)
would do that.
