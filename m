Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbWCYKmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWCYKmV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 05:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWCYKmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 05:42:21 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39858
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751157AbWCYKmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 05:42:21 -0500
Date: Sat, 25 Mar 2006 02:42:26 -0800 (PST)
Message-Id: <20060325.024226.53296559.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: SMP busted on non-cpu-hotplug systems
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just noticed this on sparc64, as I lost 31 cpus on my
Niagara box due to it :)

boot_cpu_init() sets the boot processor ID in cpu_present_map.

But fixup_cpu_present_map() will only populate the cpu_present_map if
it is empty, which it won't be because of what boot_cpu_init() just
did.
