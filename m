Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWITRBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWITRBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751953AbWITRBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:01:46 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:45775 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751961AbWITRBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:01:45 -0400
Subject: Re: 2.6.18-rt1
From: Daniel Walker <dwalker@mvista.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200609201250.03750.gene.heskett@verizon.net>
References: <20060920141907.GA30765@elte.hu>
	 <200609201250.03750.gene.heskett@verizon.net>
Content-Type: multipart/mixed; boundary="=-vf+o0gW3KZsh/9s5VHQJ"
Date: Wed, 20 Sep 2006 10:00:38 -0700
Message-Id: <1158771639.29177.5.camel@c-67-180-230-165.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vf+o0gW3KZsh/9s5VHQJ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-09-20 at 12:50 -0400, Gene Heskett wrote:

>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x16f25): In function `hrtimer_start':
> : undefined reference to `hrtimer_update_timer_prio'
> make: *** [.tmp_vmlinux1] Error 1
> 
> about half way thru the normal time.  config attached.  I don't think hires 
> timers are enabled.
> 
> Comments?
> 

Fix attached.

Daniel

--=-vf+o0gW3KZsh/9s5VHQJ
Content-Disposition: attachment; filename=fix_hrt_build_issue.patch
Content-Type: text/x-patch; name=fix_hrt_build_issue.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

---
 kernel/hrtimer.c |    1 +
 1 files changed, 1 insertion(+)

Index: linux-2.6.18/kernel/hrtimer.c
===================================================================
--- linux-2.6.18.orig/kernel/hrtimer.c
+++ linux-2.6.18/kernel/hrtimer.c
@@ -918,6 +918,7 @@ static inline void hrtimer_resume_jiffie
 #else
 
 # define hrtimer_hres_active		0
+# define hrtimer_update_timer_prio(t)	do { } while (0)
 # define hrtimer_check_clocks()		do { } while (0)
 # define hrtimer_enqueue_reprogram(t,b)	0
 # define hrtimer_force_reprogram(b)	do { } while (0)

--=-vf+o0gW3KZsh/9s5VHQJ--

