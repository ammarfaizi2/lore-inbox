Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265161AbSIWCjv>; Sun, 22 Sep 2002 22:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265163AbSIWCjv>; Sun, 22 Sep 2002 22:39:51 -0400
Received: from holomorphy.com ([66.224.33.161]:40595 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265161AbSIWCju>;
	Sun, 22 Sep 2002 22:39:50 -0400
Date: Sun, 22 Sep 2002 19:36:55 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rolf Fokkens <fokkensr@fokkensr.vertis.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 32bit wraps and USER_HZ [64 bit counters], kernel 2.5.37
Message-ID: <20020923023655.GV3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rolf Fokkens <fokkensr@fokkensr.vertis.nl>,
	linux-kernel@vger.kernel.org
References: <200209222207.g8MM7MM04998@fokkensr.vertis.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <200209222207.g8MM7MM04998@fokkensr.vertis.nl>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 12:07:22AM +0200, Rolf Fokkens wrote:
@@ -340,9 +335,12 @@
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
-	unsigned long utime, stime, cutime, cstime;
-	unsigned long start_time;
-	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
+
+	rwlock_t times_lock;
+	u64 utime, stime, cutime, cstime;
+	u64 cpu_utime[NR_CPUS], cpu_stime[NR_CPUS];
+	u64 start_time;
+

Hmm. Isn't task_t bloated enough already? I'd rather remove them than
make them 64-bit.


Thanks,
Bill
