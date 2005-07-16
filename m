Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVGPDKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVGPDKI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 23:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262102AbVGPDHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 23:07:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44951 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262115AbVGPDGF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 23:06:05 -0400
Subject: [RFC][PATCH - 9/12] NTP cleanup: Improve NTP variable names
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1121483101.28638.2.camel@cog.beaverton.ibm.com>
References: <1121482517.25236.29.camel@cog.beaverton.ibm.com>
	 <1121482620.25236.31.camel@cog.beaverton.ibm.com>
	 <1121482672.25236.33.camel@cog.beaverton.ibm.com>
	 <1121482713.25236.35.camel@cog.beaverton.ibm.com>
	 <1121482758.25236.37.camel@cog.beaverton.ibm.com>
	 <1121482804.25236.39.camel@cog.beaverton.ibm.com>
	 <1121482925.25236.42.camel@cog.beaverton.ibm.com>
	 <1121483064.28638.0.camel@cog.beaverton.ibm.com>
	 <1121483101.28638.2.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 20:06:00 -0700
Message-Id: <1121483160.28638.4.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

	This patch changes the NTP variable names from time_* to ntp_* further
clarifying their use. 

Any comments or feedback would be greatly appreciated.

thanks
-john


linux-2.6.13-rc3_timeofday-ntp-part9_B4.patch
============================================
diff --git a/arch/cris/kernel/time.c b/arch/cris/kernel/time.c
--- a/arch/cris/kernel/time.c
+++ b/arch/cris/kernel/time.c
@@ -68,11 +68,11 @@ void do_gettimeofday(struct timeval *tv)
 	}
 
         /*
-	 * If time_adjust is negative then NTP is slowing the clock
+	 * If ntp_adjtime_offset is negative then NTP is slowing the clock
 	 * so make sure not to go into next possible interval.
 	 * Better to lose some accuracy than have time go backwards..
 	 */
-	if (unlikely(time_adjust < 0) && usec > tickadj)
+	if (unlikely(ntp_adjtime_offset < 0) && usec > tickadj)
 		usec = tickadj;
 
 	sec = xtime.tv_sec;
diff --git a/arch/frv/kernel/time.c b/arch/frv/kernel/time.c
--- a/arch/frv/kernel/time.c
+++ b/arch/frv/kernel/time.c
@@ -166,11 +166,11 @@ void do_gettimeofday(struct timeval *tv)
 		lost = jiffies - wall_jiffies;
 
 		/*
-		 * If time_adjust is negative then NTP is slowing the clock
+		 * If ntp_adjtime_offset is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(ntp_adjtime_offset < 0)) {
 			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
 			usec = min(usec, max_ntp_tick);
 
diff --git a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c
+++ b/arch/i386/kernel/time.c
@@ -142,11 +142,11 @@ void do_gettimeofday(struct timeval *tv)
 		lost = jiffies - wall_jiffies;
 
 		/*
-		 * If time_adjust is negative then NTP is slowing the clock
+		 * If ntp_adjtime_offset is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(ntp_adjtime_offset < 0)) {
 			max_ntp_tick = (USEC_PER_SEC / HZ) - tickadj;
 			usec = min(usec, max_ntp_tick);
 
diff --git a/arch/m32r/kernel/time.c b/arch/m32r/kernel/time.c
--- a/arch/m32r/kernel/time.c
+++ b/arch/m32r/kernel/time.c
@@ -122,11 +122,11 @@ void do_gettimeofday(struct timeval *tv)
 		lost = jiffies - wall_jiffies;
 
 		/*
-		 * If time_adjust is negative then NTP is slowing the clock
+		 * If ntp_adjtime_offset is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(ntp_adjtime_offset < 0)) {
 			usec = min(usec, max_ntp_tick);
 			if (lost)
 				usec += lost * max_ntp_tick;
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -171,11 +171,11 @@ void do_gettimeofday(struct timeval *tv)
 		lost = jiffies - wall_jiffies;
 
 		/*
-		 * If time_adjust is negative then NTP is slowing the clock
+		 * If ntp_adjtime_offset is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(ntp_adjtime_offset < 0)) {
 			usec = min(usec, max_ntp_tick);
 
 			if (lost)
diff --git a/arch/ppc64/kernel/time.c b/arch/ppc64/kernel/time.c
--- a/arch/ppc64/kernel/time.c
+++ b/arch/ppc64/kernel/time.c
@@ -355,7 +355,7 @@ int timer_interrupt(struct pt_regs * reg
 			timer_sync_xtime(lpaca->next_jiffy_update_tb);
 			timer_check_rtc();
 			write_sequnlock(&xtime_lock);
-			if ( adjusting_time && (time_adjust == 0) )
+			if ( adjusting_time && (ntp_adjtime_offset == 0) )
 				ppc_adjtimex();
 		}
 		lpaca->next_jiffy_update_tb += tb_ticks_per_jiffy;
@@ -582,7 +582,7 @@ void __init time_init(void)
 	systemcfg->stamp_xsec = xtime.tv_sec * XSEC_PER_SEC;
 	systemcfg->tb_to_xs = tb_to_xs;
 
-	time_freq = 0;
+	ntp_freq = 0;
 
 	xtime.tv_nsec = 0;
 	last_rtc_update = xtime.tv_sec;
@@ -599,7 +599,7 @@ void __init time_init(void)
  * to microseconds to keep do_gettimeofday synchronized 
  * with ntpd.
  *
- * Use the time_adjust, time_freq and time_offset computed by adjtimex to 
+ * Use the ntp_adjtime_offset, ntp_freq and ntp_offset computed by adjtimex to 
  * adjust the frequency.
  */
 
@@ -617,32 +617,32 @@ void ppc_adjtimex(void)
 	long singleshot_ppm = 0;
 
 	/* Compute parts per million frequency adjustment to accomplish the time adjustment
-	   implied by time_offset to be applied over the elapsed time indicated by time_constant.
-	   Use SHIFT_USEC to get it into the same units as time_freq. */
-	if ( time_offset < 0 ) {
-		ltemp = -time_offset;
+	   implied by ntp_offset to be applied over the elapsed time indicated by ntp_constant.
+	   Use SHIFT_USEC to get it into the same units as ntp_freq. */
+	if ( ntp_offset < 0 ) {
+		ltemp = -ntp_offset;
 		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
-		ltemp >>= SHIFT_KG + time_constant;
+		ltemp >>= SHIFT_KG + ntp_constant;
 		ltemp = -ltemp;
 	}
 	else {
-		ltemp = time_offset;
+		ltemp = ntp_offset;
 		ltemp <<= SHIFT_USEC - SHIFT_UPDATE;
-		ltemp >>= SHIFT_KG + time_constant;
+		ltemp >>= SHIFT_KG + ntp_constant;
 	}
 	
 	/* If there is a single shot time adjustment in progress */
-	if ( time_adjust ) {
+	if ( ntp_adjtime_offset ) {
 #ifdef DEBUG_PPC_ADJTIMEX
 		printk("ppc_adjtimex: ");
 		if ( adjusting_time == 0 )
 			printk("starting ");
-		printk("single shot time_adjust = %ld\n", time_adjust);
+		printk("single shot ntp_adjtime_offset = %ld\n", ntp_adjtime_offset);
 #endif	
 	
 		adjusting_time = 1;
 		
-		/* Compute parts per million frequency adjustment to match time_adjust */
+		/* Compute parts per million frequency adjustment to match ntp_adjtime_offset */
 		singleshot_ppm = tickadj * HZ;	
 		/*
 		 * The adjustment should be tickadj*HZ to match the code in
@@ -650,21 +650,21 @@ void ppc_adjtimex(void)
 		 * large. 3/4 of tickadj*HZ seems about right
 		 */
 		singleshot_ppm -= singleshot_ppm / 4;
-		/* Use SHIFT_USEC to get it into the same units as time_freq */	
+		/* Use SHIFT_USEC to get it into the same units as ntp_freq */	
 		singleshot_ppm <<= SHIFT_USEC;
-		if ( time_adjust < 0 )
+		if ( ntp_adjtime_offset < 0 )
 			singleshot_ppm = -singleshot_ppm;
 	}
 	else {
 #ifdef DEBUG_PPC_ADJTIMEX
 		if ( adjusting_time )
-			printk("ppc_adjtimex: ending single shot time_adjust\n");
+			printk("ppc_adjtimex: ending single shot ntp_adjtime_offset\n");
 #endif
 		adjusting_time = 0;
 	}
 	
 	/* Add up all of the frequency adjustments */
-	delta_freq = time_freq + ltemp + singleshot_ppm;
+	delta_freq = ntp_freq + ltemp + singleshot_ppm;
 	
 	/* Compute a new value for tb_ticks_per_sec based on the frequency adjustment */
 	den = 1000000 * (1 << (SHIFT_USEC - 8));
@@ -678,7 +678,7 @@ void ppc_adjtimex(void)
 	}
 	
 #ifdef DEBUG_PPC_ADJTIMEX
-	printk("ppc_adjtimex: ltemp = %ld, time_freq = %ld, singleshot_ppm = %ld\n", ltemp, time_freq, singleshot_ppm);
+	printk("ppc_adjtimex: ltemp = %ld, ntp_freq = %ld, singleshot_ppm = %ld\n", ltemp, ntp_freq, singleshot_ppm);
 	printk("ppc_adjtimex: tb_ticks_per_sec - base = %ld  new = %ld\n", tb_ticks_per_sec, new_tb_ticks_per_sec);
 #endif
 				
diff --git a/arch/sparc/kernel/pcic.c b/arch/sparc/kernel/pcic.c
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -783,11 +783,11 @@ static void pci_do_gettimeofday(struct t
 		lost = jiffies - wall_jiffies;
 
 		/*
-		 * If time_adjust is negative then NTP is slowing the clock
+		 * If ntp_adjtime_offset is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(ntp_adjtime_offset < 0)) {
 			usec = min(usec, max_ntp_tick);
 
 			if (lost)
diff --git a/arch/sparc/kernel/time.c b/arch/sparc/kernel/time.c
--- a/arch/sparc/kernel/time.c
+++ b/arch/sparc/kernel/time.c
@@ -492,11 +492,11 @@ void do_gettimeofday(struct timeval *tv)
 		lost = jiffies - wall_jiffies;
 
 		/*
-		 * If time_adjust is negative then NTP is slowing the clock
+		 * If ntp_adjtime_offset is negative then NTP is slowing the clock
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0)) {
+		if (unlikely(ntp_adjtime_offset < 0)) {
 			usec = min(usec, max_ntp_tick);
 
 			if (lost)
diff --git a/include/linux/ntp.h b/include/linux/ntp.h
--- a/include/linux/ntp.h
+++ b/include/linux/ntp.h
@@ -20,9 +20,9 @@ int ntp_synced(void);
  * these variables cannot be made static just yet
  */
 extern int tickadj;
-extern long time_offset;
-extern long time_freq;
-extern long time_adjust;
-extern long time_constant;
+extern long ntp_offset;
+extern long ntp_freq;
+extern long ntp_adjtime_offset;
+extern long ntp_constant;
 
 #endif
diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -47,26 +47,28 @@
 
 /* Don't completely fail for HZ > 500.  */
 int tickadj = 500/HZ ? : 1;		/* microsecs */
-
-/*
- * phase-lock loop variables
- */
-/* TIME_ERROR prevents overwriting the CMOS clock */
-static int time_state = TIME_OK;              /* clock synchronization status */
-static int time_status = STA_UNSYNC;          /* clock status bits */
-long time_offset;                      /* time adjustment (us) */
-long time_constant = 2;                /* pll time constant */
-static long time_tolerance = MAXFREQ;         /* frequency tolerance (ppm) */
-static long time_precision = 1;               /* clock precision (us) */
-static long time_maxerror = NTP_PHASE_LIMIT;  /* maximum error (us) */
-static long time_esterror = NTP_PHASE_LIMIT;  /* estimated error (us) */
-static long time_phase;                       /* phase offset (scaled us) */
-long time_freq = (((NSEC_PER_SEC + HZ/2) % HZ - HZ/2) << SHIFT_USEC) / NSEC_PER_USEC;
-                                        /* frequency offset (scaled ppm) */
+static long time_phase;                 /* phase offset (scaled us) */
 static long time_adj;                   /* tick adjust (scaled 1 / HZ) */
-static long time_reftime;                      /* time at last adjustment (s) */
-long time_adjust;
-static long time_next_adjust;
+
+/* Chapter 5: Kernel Variables [RFC 1589 pg. 28] */
+/* 5.1 Interface Variables */
+static int ntp_status = STA_UNSYNC;             /* status */
+long ntp_offset;                                /* usec */
+long ntp_constant = 2;                          /* ntp magic? */
+static long ntp_maxerror = NTP_PHASE_LIMIT;     /* usec */
+static long ntp_esterror = NTP_PHASE_LIMIT;     /* usec */
+static const long ntp_tolerance	= MAXFREQ;      /* shifted ppm */
+static const long ntp_precision	= 1;            /* constant */
+
+/* 5.2 Phase-Lock Loop Variables */
+long ntp_freq;                                  /* shifted ppm */
+static long ntp_reftime;                        /* sec */
+
+/* Extra values */
+static int ntp_state    = TIME_OK;              /* leapsecond state */
+long ntp_adjtime_offset;
+static long ntp_next_adjtime_offset;
+
 
 #define SEC_PER_DAY 86400
 
@@ -92,10 +94,10 @@ int ntp_advance(unsigned long interval_n
 		interval_sum -= NSEC_PER_SEC;
 
 		/* Bump the maxerror field */
-		time_maxerror += time_tolerance >> SHIFT_USEC;
-		if ( time_maxerror > NTP_PHASE_LIMIT ) {
-			time_maxerror = NTP_PHASE_LIMIT;
-			time_status |= STA_UNSYNC;
+		ntp_maxerror += shiftR(ntp_tolerance, SHIFT_USEC);
+		if (ntp_maxerror > NTP_PHASE_LIMIT) {
+			ntp_maxerror = NTP_PHASE_LIMIT;
+			ntp_status |= STA_UNSYNC;
 		}
 
 		/*
@@ -107,16 +109,16 @@ int ntp_advance(unsigned long interval_n
 		 * the adjustment over not more than the number of
 		 * seconds between updates.
 		 */
-		next_adj = time_offset;
-		if (!(time_status & STA_FLL))
-			next_adj = shiftR(next_adj, SHIFT_KG + time_constant);
+		next_adj = ntp_offset;
+		if (!(ntp_status & STA_FLL))
+			next_adj = shiftR(next_adj, SHIFT_KG + ntp_constant);
 		next_adj = min(next_adj, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
 		next_adj = max(next_adj, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
-		time_offset -= next_adj;
+		ntp_offset -= next_adj;
 
 		time_adj = next_adj << (SHIFT_SCALE - SHIFT_HZ - SHIFT_UPDATE);
 
-		time_adj += shiftR(time_freq, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
+		time_adj += shiftR(ntp_freq, (SHIFT_USEC + SHIFT_HZ - SHIFT_SCALE));
 
 #if HZ == 100
     	/* Compensate for (HZ==100) != (1 << SHIFT_HZ).
@@ -136,23 +138,23 @@ int ntp_advance(unsigned long interval_n
 	}
 
 
-	if ( (time_adjust_step = time_adjust) != 0 ) {
+	if ( (time_adjust_step = ntp_adjtime_offset) != 0 ) {
 	    /* We are doing an adjtime thing.
 	     *
 	     * Prepare time_adjust_step to be within bounds.
-	     * Note that a positive time_adjust means we want the clock
+	     * Note that a positive ntp_adjtime_offset means we want the clock
 	     * to run faster.
 	     *
 	     * Limit the amount of the step to be in the range
 	     * -tickadj .. +tickadj
 	     */
-		if (time_adjust > tickadj)
+		if (ntp_adjtime_offset > tickadj)
 			time_adjust_step = tickadj;
-		else if (time_adjust < -tickadj)
+		else if (ntp_adjtime_offset < -tickadj)
 			time_adjust_step = -tickadj;
 
 	    /* Reduce by this step the amount of time left  */
-	    time_adjust -= time_adjust_step;
+	    ntp_adjtime_offset -= time_adjust_step;
 	}
 	delta_nsec = time_adjust_step * 1000;
 
@@ -172,9 +174,9 @@ int ntp_advance(unsigned long interval_n
 	}
 
 	/* Changes by adjtime() do not take effect till next tick. */
-	if (time_next_adjust != 0) {
-		time_adjust = time_next_adjust;
-		time_next_adjust = 0;
+	if (ntp_next_adjtime_offset != 0) {
+		ntp_adjtime_offset = ntp_next_adjtime_offset;
+		ntp_next_adjtime_offset = 0;
 	}
 
 	return delta_nsec;
@@ -197,51 +199,51 @@ static int ntp_hardupdate(long offset, s
 	long current_offset, interval;
 
 	ret = 0;
-	if (!(time_status & STA_PLL))
+	if (!(ntp_status & STA_PLL))
 		return ret;
 
 	current_offset = offset;
 	/* Make sure offset is bounded by MAXPHASE */
 	current_offset = min(current_offset, MAXPHASE);
 	current_offset = max(current_offset, -MAXPHASE);
-	time_offset = current_offset << SHIFT_UPDATE;
+	ntp_offset = current_offset << SHIFT_UPDATE;
 
-	if (time_status & STA_FREQHOLD || time_reftime == 0)
-		time_reftime = tv.tv_sec;
+	if (ntp_status & STA_FREQHOLD || ntp_reftime == 0)
+		ntp_reftime = tv.tv_sec;
 
 	/* calculate seconds since last call to hardupdate */
-	interval = tv.tv_sec - time_reftime;
-	time_reftime = tv.tv_sec;
+	interval = tv.tv_sec - ntp_reftime;
+	ntp_reftime = tv.tv_sec;
 
 	/*
 	 * Select whether the frequency is to be controlled
 	 * and in which mode (PLL or FLL). Clamp to the operating
 	 * range. Ugly multiply/divide should be replaced someday.
 	 */
-	if ((time_status & STA_FLL) && (interval >= MINSEC)) {
+	if ((ntp_status & STA_FLL) && (interval >= MINSEC)) {
 		long offset_ppm;
 
-		offset_ppm = time_offset / interval;
+		offset_ppm = ntp_offset / interval;
 		offset_ppm <<= (SHIFT_USEC - SHIFT_UPDATE);
 
-		time_freq += shiftR(offset_ppm, SHIFT_KH);
+		ntp_freq += shiftR(offset_ppm, SHIFT_KH);
 
-	} else if ((time_status & STA_PLL) && (interval < MAXSEC)) {
+	} else if ((ntp_status & STA_PLL) && (interval < MAXSEC)) {
 		long damping, offset_ppm;
 
 		offset_ppm = offset * interval;
 
-		damping = (2 * time_constant) + SHIFT_KF - SHIFT_USEC;
+		damping = (2 * ntp_constant) + SHIFT_KF - SHIFT_USEC;
 
-		time_freq += shiftR(offset_ppm, damping);
+		ntp_freq += shiftR(offset_ppm, damping);
 
 	} else { /* calibration interval out of bounds (p. 12) */
 		ret = TIME_ERROR;
 	}
 
-	/* bound time_freq */
-	time_freq = min(time_freq, time_tolerance);
-	time_freq = max(time_freq, -time_tolerance);
+	/* bound ntp_freq */
+	ntp_freq = min(ntp_freq, ntp_tolerance);
+	ntp_freq = max(ntp_freq, -ntp_tolerance);
 
 	return ret;
 }
@@ -297,34 +299,34 @@ int ntp_adjtimex(struct timex *txc)
 		return -EINVAL;
 
 	write_seqlock_irq(&xtime_lock);
-	result = time_state;       /* mostly `TIME_OK' */
+	result = ntp_state;       /* mostly `TIME_OK' */
 
 	/* Save for later - semantics of adjtime is to return old value */
-	save_adjust = time_next_adjust ? time_next_adjust : time_adjust;
+	save_adjust = ntp_next_adjtime_offset ? ntp_next_adjtime_offset : ntp_adjtime_offset;
 
 	/* If there are input parameters, then process them */
 
 	if (txc->modes & ADJ_STATUS)	/* only set allowed bits */
-		time_status = (txc->status & ~STA_RONLY) |
-				(time_status & STA_RONLY);
+		ntp_status = (txc->status & ~STA_RONLY) |
+				(ntp_status & STA_RONLY);
 
 	if (txc->modes & ADJ_FREQUENCY)
-		time_freq = txc->freq;
+		ntp_freq = txc->freq;
 
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror = txc->maxerror;
+		ntp_maxerror = txc->maxerror;
 
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror = txc->esterror;
+		ntp_esterror = txc->esterror;
 
 	if (txc->modes & ADJ_TIMECONST)
-		time_constant = txc->constant;
+		ntp_constant = txc->constant;
 
 	if (txc->modes & ADJ_OFFSET) {
 		if (txc->modes == ADJ_OFFSET_SINGLESHOT) {
 			/* adjtime() is independent from ntp_adjtime() */
-			if ((time_next_adjust = txc->offset) == 0)
-				time_adjust = 0;
+			if ((ntp_next_adjtime_offset = txc->offset) == 0)
+				ntp_adjtime_offset = 0;
 		} else if (ntp_hardupdate(txc->offset, xtime))
 			result = TIME_ERROR;
 	}
@@ -334,23 +336,22 @@ int ntp_adjtimex(struct timex *txc)
 		tick_nsec = TICK_USEC_TO_NSEC(tick_usec);
 	}
 
-	if ((time_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
+	if ((ntp_status & (STA_UNSYNC|STA_CLOCKERR)) != 0)
 		result = TIME_ERROR;
 
 	/* write kernel state to user timex values*/
-
 	if ((txc->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
 		txc->offset = save_adjust;
-	else {
-		txc->offset = shiftR(time_offset, SHIFT_UPDATE);
-	}
-	txc->freq = time_freq;
-	txc->maxerror = time_maxerror;
-	txc->esterror = time_esterror;
-	txc->status = time_status;
-	txc->constant = time_constant;
-	txc->precision = time_precision;
-	txc->tolerance = time_tolerance;
+	else
+		txc->offset = shiftR(ntp_offset, SHIFT_UPDATE);
+
+	txc->freq = ntp_freq;
+	txc->maxerror = ntp_maxerror;
+	txc->esterror = ntp_esterror;
+	txc->status = ntp_status;
+	txc->constant = ntp_constant;
+	txc->precision = ntp_precision;
+	txc->tolerance = ntp_tolerance;
 	txc->tick = tick_usec;
 
 	/* PPS is not implemented, so these are zero */
@@ -387,12 +388,12 @@ int ntp_leapsecond(struct timespec now)
 	 */
 	static time_t leaptime = 0;
 
-	switch (time_state) {
+	switch (ntp_state) {
 	case TIME_OK:
-		if (time_status & STA_INS)
-			time_state = TIME_INS;
-		else if (time_status & STA_DEL)
-			time_state = TIME_DEL;
+		if (ntp_status & STA_INS)
+			ntp_state = TIME_INS;
+		else if (ntp_status & STA_DEL)
+			ntp_state = TIME_DEL;
 
 		/* calculate end of today (23:59:59)*/
 		leaptime = now.tv_sec + SEC_PER_DAY -
@@ -402,7 +403,7 @@ int ntp_leapsecond(struct timespec now)
 	case TIME_INS:
 		/* Once we are at (or past) leaptime, insert the second */
 		if (now.tv_sec >= leaptime) {
-			time_state = TIME_OOP;
+			ntp_state = TIME_OOP;
 			printk(KERN_NOTICE "Clock: inserting leap second 23:59:60 UTC\n");
 			return -1;
 		}
@@ -411,7 +412,7 @@ int ntp_leapsecond(struct timespec now)
 	case TIME_DEL:
 		/* Once we are at (or past) leaptime, delete the second */
 		if (now.tv_sec >= leaptime) {
-			time_state = TIME_WAIT;
+			ntp_state = TIME_WAIT;
 			printk(KERN_NOTICE "Clock: deleting leap second 23:59:59 UTC\n");
 			return 1;
 		}
@@ -420,12 +421,12 @@ int ntp_leapsecond(struct timespec now)
 	case TIME_OOP:
 		/*  Wait for the end of the leap second*/
 		if (now.tv_sec > (leaptime + 1))
-			time_state = TIME_WAIT;
+			ntp_state = TIME_WAIT;
 		break;
 
 	case TIME_WAIT:
-		if (!(time_status & (STA_INS | STA_DEL)))
-			time_state = TIME_OK;
+		if (!(ntp_status & (STA_INS | STA_DEL)))
+			ntp_state = TIME_OK;
 	}
 
 	return 0;
@@ -439,10 +440,10 @@ int ntp_leapsecond(struct timespec now)
  */
 void ntp_clear(void)
 {
-	time_adjust = 0;		/* stop active adjtime() */
-	time_status |= STA_UNSYNC;
-	time_maxerror = NTP_PHASE_LIMIT;
-	time_esterror = NTP_PHASE_LIMIT;
+	ntp_next_adjtime_offset = 0;		/* stop active adjtime() */
+	ntp_status |= STA_UNSYNC;
+	ntp_maxerror = NTP_PHASE_LIMIT;
+	ntp_esterror = NTP_PHASE_LIMIT;
 }
 
 /**
@@ -451,6 +452,6 @@ void ntp_clear(void)
  */
 int ntp_synced(void)
 {
-	return !(time_status & STA_UNSYNC);
+	return !(ntp_status & STA_UNSYNC);
 }
 


