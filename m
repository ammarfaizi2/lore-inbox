Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267711AbTASWqA>; Sun, 19 Jan 2003 17:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267712AbTASWp7>; Sun, 19 Jan 2003 17:45:59 -0500
Received: from holomorphy.com ([66.224.33.161]:14984 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267711AbTASWp7>;
	Sun, 19 Jan 2003 17:45:59 -0500
Date: Sun, 19 Jan 2003 14:54:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Cc: kai@chaos.physics.uiowa.edu
Subject: Re: [PATCH] cpumask_t
Message-ID: <20030119225458.GD770@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	kai@chaos.physics.uiowa.edu
References: <20020808.073630.37512884.davem@redhat.com> <20020809080517.E4BE5443C@lists.samba.org> <20030119213524.GH780@holomorphy.com> <20030119221852.GC789@holomorphy.com> <20030119224329.GI780@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119224329.GI780@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jan 19, 2003 at 02:18:52PM -0800, William Lee Irwin III wrote:
> +	if (!any_online_cpu(tmp) >= NR_CPUS)

Thanks for spotting this, kai


diff -urpN cpu-2.5.59-2/arch/i386/kernel/irq.c cpu-2.5.59-3/arch/i386/kernel/irq.c
--- cpu-2.5.59-2/arch/i386/kernel/irq.c	2003-01-19 14:30:24.000000000 -0800
+++ cpu-2.5.59-3/arch/i386/kernel/irq.c	2003-01-19 14:52:00.000000000 -0800
@@ -873,7 +873,7 @@ static int irq_affinity_write_proc (stru
 	 * one online CPU still has to be targeted.
 	 */
 	cpus_and(tmp, new_value, cpu_online_map);
-	if (!any_online_cpu(tmp) >= NR_CPUS)
+	if (any_online_cpu(tmp) >= NR_CPUS)
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
