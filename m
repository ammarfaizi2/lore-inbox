Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161068AbWAHTKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161068AbWAHTKP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbWAHTKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:10:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37011 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161068AbWAHTKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:10:13 -0500
Subject: Re: [PATCH 1/2] amd76x_pm: C2 powersaving for AMD K7
From: Arjan van de Ven <arjan@infradead.org>
To: Joerg Sommrey <jo@sommrey.de>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060108190337.GA22780@sommrey.de>
References: <20060108190337.GA22780@sommrey.de>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 20:10:10 +0100
Message-Id: <1136747410.2955.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 20:03 +0100, Joerg Sommrey wrote:
> + * Locking is done using atomic_t variables, no spin locks needed.

but... there seems to be a race now:
+               smp_mb();
+               if (unlikely(atomic_read(&amd76x_stat.num_idle)
+                                       == num_online)) {
+                       /* Invoke C2 */
+                       prs->C2_cnt++;
+                       inb(amd76x_pm_cfg.C2_reg);
+                       break;
+               }


also.. atomic_t + manual interrupt disabling isn't by definition better
than a spinlock... when people say "spinlocks are expensive" they imply
that atomics are also expensive... 

