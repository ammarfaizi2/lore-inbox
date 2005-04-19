Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVDSO6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVDSO6D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVDSO6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:58:02 -0400
Received: from mx1.suse.de ([195.135.220.2]:14563 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261586AbVDSO5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:57:13 -0400
Message-ID: <42651C38.6090807@suse.de>
Date: Tue, 19 Apr 2005 16:56:56 +0200
From: Thomas Renninger <trenn@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050317
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
Cc: Frank Sorenson <frank@tuxrocks.com>, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       ML ACPI-devel <acpi-devel@lists.sourceforge.net>,
       Bodo Bauer <bb@suse.de>, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1 - C-state measures
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <42566C22.4040509@suse.de> <20050408115535.GI4477@atomide.com>
In-Reply-To: <20050408115535.GI4477@atomide.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050501040601000209010508"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050501040601000209010508
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Here are some figures (I used your pmstats):

The machine is a Pentium M 2.00 GHz, supporting C0-C4 processor power states.
The machine run at 2.00 GHz all the time.
A lot of modules (pcmcia, usb, ...) where loaded, services that could
produce load where stopped -> processor is mostly idle.

_____________________________________________________________________________________
*Running with 1000Hz:*

_No processor module:_

Average current the last 100 seconds: *2289mA*
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/1000_HZ_No_module_loaded)


_passing bm_history=0xFFFFFFFF (default) to processor module:_

Average current the last 470 seconds: *1986mA* (also measured better values ~1800, does battery level play a role?!?)
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/1000_HZ_bm_history_FFFFFFFF)


_passing bm_history=0xFF to processor module:_

Average current the last 190 seconds: *1757mA*
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/1000_HZ_bm_history_FF)
(Usage count could be bogus, as some invokations could not succeed if bm has currently been active).
_____________________________________________________________________________________

*Running with CONFIG_NO_IDLE_HZ:*
Patched with http://www.muru.com/linux/dyntick/patches/patch-dynamic-tick-2.6.12-rc2-050408-1.gz
(With the c-state patch attached applied)

_No processor module:_

Average current the last 80 seconds: *2262mA*
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/tony_dyn_tick_No_module_loaded)

idle_ms == 40, bm_promote_bs == 30
Average current the last 160 seconds: *1507mA*
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/tony_dyn_tick_processor_idle_40_bm_30)

idle_ms == 100, bm_promote_bs == 30
Average current the last 80 seconds: *1466mA*
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/tony_dyn_tick_processor_idle_100_bm_30)

idle_ms == 40, bm_promote_bs == 50
Average current the last 150 seconds: *1481mA*
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/tony_dyn_tick_processor_idle_40_bm_30)

idle_ms == 40, bm_promote_bs == 10
Average current the last 330 seconds: *1474mA*
(cmp. ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/measures_C4_machine/tony_dyn_tick_processor_idle_40_bm_10)

Hmm, parameters do not influence at all ... (idle_ms should only comes in when switching between idle/not idle).
_____________________________________________________________________________________


The measures are based on the /proc/acpi/battery/*/* info and are not very accurate, but could give an overall picture.

      Thomas

P.S.: Not tested, because I have no x86_64 C3 machine, but the patch should also work reliable with Andi's dyn_tick patch
for x86_64 machines.

Tony: I modified your pmstats to produce an average current value: ftp://ftp.suse.com/pub/people/trenn/dyn_tick_c_states/pmstats

--------------050501040601000209010508
Content-Type: text/x-patch;
 name="dynamic_tick_cstate_patch_final.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dynamic_tick_cstate_patch_final.diff"

Patch not enough tested, yet.
Should behave the same if compile with !CONFIG_IDLE_HZ.

If CONFIG_IDLE_HZ is set, the c-state will be evaluated on
three control values (averages of the last 4 measures):

a) idle_ms -> if machine was active for longer than this
   value (avg), the machine is assumed to not be idle
   and C1 will be triggered.

b) bm_promote_ms -> if the avg bus master activity is below
   this threshold, C2 is invoked.

c) sleep_avg (no module param) -> the average sleep time of the
   last four C2 (or higher) invokations.
   If a and b does not apply, a C-state will be searched that has
   the highest latency, but still has a latency below the latest
   C2 (or higher) sleeping time and average sleeping time value.

ToDo:
Test on other machines (only C2 or C0 support).
Discuss and enhance algorithm.
If it is used this way, average calculations could get MMX optimised.

--- linux-2.6.12-rc2.orig/drivers/acpi/processor_idle.c	2005-04-19 15:03:13.000000000 +0200
+++ linux-2.6.12-rc2/drivers/acpi/processor_idle.c	2005-04-19 15:17:56.000000000 +0200
@@ -60,6 +60,22 @@
 static unsigned int nocst = 0;
 module_param(nocst, uint, 0000);
 
+static unsigned int idle_ms = 40;
+module_param(idle_ms, uint, 0644);
+MODULE_PARM_DESC(idle_ms, "Promote to lower state if machine stays shorter than x ms not in idle func (avg) [40].");
+
+static unsigned int bm_promote_ms = 30;
+module_param(bm_promote_ms, uint, 0644);
+MODULE_PARM_DESC(bm_promote_ms, "Promote to lower state if avg bm is less than x ms [30].");
+
+//#define DEBUG 1
+#ifdef DEBUG
+#define myPrintk(string, args...) printk(KERN_INFO ""string, ##args);
+#else
+#define myPrintk(string, args...) {};
+#endif
+
+
 /*
  * bm_history -- bit-mask with a bit per jiffy of bus-master activity
  * 1000 HZ: 0xFFFFFFFF: 32 jiffies = 32ms
@@ -162,6 +178,88 @@
 	return;
 }
 
+u16 calc_average (u64 last_measures){
+	int x;
+	u16 ret = 0;
+	for (x = 0; x < sizeof(u64)*8; x+=16){
+		ret += (last_measures >> x) & (u64)0xFFFF;
+//		myPrintk (KERN_INFO "x: %d - ret: %X - last_measures: %X - result %X\n", x, ret, (u64)last_measures, (last_measures >> x) & (u64)0xFFFF);
+	}
+/* divide by four -> average bm activity for the last 4 times */
+	ret >>= 2;
+	return ret;
+}
+
+/*
+ * check BM Activity
+ * -----------------
+ * Check for bus mastering activity and save history in
+ * pr->power.bm_activity
+ *
+ * return 0  -> no bm activity for long time
+ * return 1  -> we currently have bus master activity 
+ *
+ */
+
+static void check_bm_activity(struct acpi_processor *pr) {
+	u32		bm_status = 0;
+	unsigned long	diff = jiffies - pr->power.bm_check_timestamp;
+	
+#ifndef CONFIG_NO_IDLE_HZ
+	if (diff > 32)
+		diff = 32;
+	while (diff) {
+		/* if we didn't get called, assume there was busmaster activity */
+		diff--;
+		if (diff)
+			pr->power.bm_activity |= 0x1;
+		pr->power.bm_activity <<= 1;
+	}
+	
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
+			  &bm_status, ACPI_MTX_DO_NOT_LOCK);
+	if (bm_status) {
+		pr->power.bm_activity++;
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
+				  1, ACPI_MTX_DO_NOT_LOCK);
+	}
+	/*
+	 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
+	 * the true state of bus mastering activity; forcing us to
+	 * manually check the BMIDEA bit of each IDE channel.
+	 */
+	else if (errata.piix4.bmisx) {
+		if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
+		    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
+			pr->power.bm_activity++;
+	}
+	pr->power.bm_check_timestamp = jiffies;
+	
+#else
+	if (diff > 0xFFFF)
+		diff = 0xFFFF;
+	acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
+			  &bm_status, ACPI_MTX_DO_NOT_LOCK);
+//	myPrintk (KERN_INFO "bm_status - %d, diff: %lu - bm_avg_ms: %X\n",
+//		  bm_status, diff, pr->power.bm_avg_ms);
+	if (bm_status) {
+		acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
+				  1, ACPI_MTX_DO_NOT_LOCK);
+		/* we had an active bus master -> get timestamp */
+		pr->power.bm_check_timestamp = jiffies;
+		pr->power.bm_last_measures <<= 16;
+	}
+	/* just OR, even if !bm_status, shouldn't matter */
+	pr->power.bm_last_measures |= diff;
+	
+//	myPrintk (KERN_INFO "diff: %lu - Avg: bm_last_measures: %#16X\n", diff, (u64)pr->power.bm_last_measures);
+
+	pr->power.bm_avg_ms = calc_average (pr->power.bm_last_measures);
+	
+	
+//	printk (KERN_INFO "Avg: bm_avg_ms: %lu ms \n", (unsigned long)pr->power.bm_avg_ms);
+#endif
+}
 
 static void acpi_processor_idle (void)
 {
@@ -171,6 +269,12 @@
 	int			sleep_ticks = 0;
 	u32			t1, t2 = 0;
 
+#ifdef CONFIG_NO_IDLE_HZ
+	struct acpi_processor_cx *temp_state = NULL;
+	int		        i = 0;
+	unsigned long	diff = jiffies - pr->power.active_timestamp;
+#endif
+
 	pr = processors[_smp_processor_id()];
 	if (!pr)
 		return;
@@ -191,9 +295,27 @@
 	}
 
 	cx = pr->power.state;
+
+#ifdef CONFIG_NO_IDLE_HZ
+	/* keep track of bm activity */
+	check_bm_activity(pr);
+
+	unsigned long	diff = jiffies - pr->power.active_timestamp;
+	if (diff > 0xFFFF)
+		diff = 0xFFFF;
+	pr->power.active_last_measures <<= 16;
+	pr->power.active_last_measures |= (u16)diff;
+	pr->power.active_avg_ms = calc_average(pr->power.active_last_measures);
+	if (pr->power.active_avg_ms > idle_ms){
+		printk (KERN_INFO "We were not idle for %d ms (4 times avg) -> goto C1\n", pr->power.active_avg_ms);
+		next_state = &pr->power.states[ACPI_STATE_C1];
+		goto end;
+	}
+#endif
 	if (!cx)
 		goto easy_out;
-
+	
+#ifndef CONFIG_NO_IDLE_HZ
 	/*
 	 * Check BM Activity
 	 * -----------------
@@ -201,40 +323,8 @@
 	 * for demotion.
 	 */
 	if (pr->flags.bm_check) {
-		u32		bm_status = 0;
-		unsigned long	diff = jiffies - pr->power.bm_check_timestamp;
-
-		if (diff > 32)
-			diff = 32;
-
-		while (diff) {
-			/* if we didn't get called, assume there was busmaster activity */
-			diff--;
-			if (diff)
-				pr->power.bm_activity |= 0x1;
-			pr->power.bm_activity <<= 1;
-		}
-
-		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
-			&bm_status, ACPI_MTX_DO_NOT_LOCK);
-		if (bm_status) {
-			pr->power.bm_activity++;
-			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
-				1, ACPI_MTX_DO_NOT_LOCK);
-		}
-		/*
-		 * PIIX4 Erratum #18: Note that BM_STS doesn't always reflect
-		 * the true state of bus mastering activity; forcing us to
-		 * manually check the BMIDEA bit of each IDE channel.
-		 */
-		else if (errata.piix4.bmisx) {
-			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
-				|| (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
-		}
-
-		pr->power.bm_check_timestamp = jiffies;
-
+		
+		check_bm_activity(pr);
 		/*
 		 * Apply bus mastering demotion policy.  Automatically demote
 		 * to avoid a faulty transition.  Note that the processor
@@ -253,6 +343,8 @@
 			goto end;
 		}
 	}
+#endif
+	cx->usage++;
 
 	cx->usage++;
 
@@ -278,7 +370,7 @@
 		 *      go to an ISR rather than here.  Need to instrument
 		 *      base interrupt handler.
 		 */
-		sleep_ticks = 0xFFFFFFFF;
+		sleep_ticks = 0xFFFFFFF;
 		break;
 
 	case ACPI_STATE_C2:
@@ -320,8 +412,51 @@
 		return;
 	}
 
+	if (sleep_ticks <= 0)
+		cx->failed++;
+
+#ifdef CONFIG_NO_IDLE_HZ
+		pr->power.sleep_last_measures <<= 16;
+		pr->power.sleep_last_measures |= sleep_ticks;
+		pr->power.sleep_avg_ticks = calc_average(pr->power.sleep_last_measures);
+#endif
+
 	next_state = pr->power.state;
 
+#ifdef CONFIG_NO_IDLE_HZ
+	
+	/* use C1/C2 if we have to much bus master activity */
+	if (bm_promote_ms >= pr->power.bm_avg_ms){
+		myPrintk ("pr->power.bm_avg_ms: %d\n", (int)pr->power.bm_avg_ms);
+		next_state = &pr->power.states[ACPI_STATE_C2];
+		if (next_state == NULL || !next_state->valid){
+			next_state = &pr->power.states[ACPI_STATE_C1];
+			if (next_state == NULL || !next_state->valid)
+				goto easy_out;
+			
+		}
+		goto end;
+	}
+		
+	
+	/* goto sleep state which latency fits best to avg sleep time
+	   of the last 4 sleep cycles */
+	for (i=ACPI_STATE_C2; i < ACPI_PROCESSOR_MAX_POWER; i++) {
+		temp_state = &pr->power.states[i];
+		if (temp_state == NULL || !temp_state->valid)
+			break;
+		myPrintk ("pr->power.sleep_avg_ticks: %d - temp_state->promotion.threshold.ticks: %d"
+			  " - sleep_ticks; %d\n", 
+			  pr->power.sleep_avg_ticks, temp_state->promotion.threshold.ticks, sleep_ticks);
+		if (temp_state->promotion.state && 
+		    sleep_ticks > temp_state->promotion.threshold.ticks &&
+		    pr->power.sleep_avg_ticks > temp_state->promotion.threshold.ticks){
+			next_state = temp_state->promotion.state;
+		}
+		else
+			break;
+	}
+#else		
 	/*
 	 * Promotion?
 	 * ----------
@@ -330,6 +465,7 @@
 	 * mastering activity may prevent promotions.
 	 * Do not promote above max_cstate.
 	 */
+
 	if (cx->promotion.state &&
 	    ((cx->promotion.state - pr->power.states) <= max_cstate)) {
 		if (sleep_ticks > cx->promotion.threshold.ticks) {
@@ -366,6 +502,7 @@
 			}
 		}
 	}
+#endif
 
 end:
 	/*
@@ -384,7 +521,9 @@
 	 */
 	if (next_state != pr->power.state)
 		acpi_processor_power_activate(pr, next_state);
-
+#ifdef CONFIG_NO_IDLE_HZ
+	pr->power.active_timestamp = jiffies;
+#endif
 	return;
 
  easy_out:
@@ -393,6 +532,9 @@
 		pm_idle_save();
 	else
 		safe_halt();
+#ifdef CONFIG_NO_IDLE_HZ
+	pr->power.active_timestamp = jiffies;
+#endif
 	return;
 }
 
@@ -910,6 +1052,9 @@
 		seq_printf(seq, "latency[%03d] usage[%08d]\n",
 			pr->power.states[i].latency,
 			pr->power.states[i].usage);
+		seq_printf(seq, "                         failed[%08d]\n",
+			pr->power.states[i].failed);
+
 	}
 
 end:
--- linux-2.6.12-rc2.orig/include/acpi/processor.h	2005-04-19 15:03:44.000000000 +0200
+++ linux-2.6.12-rc2/include/acpi/processor.h	2005-04-19 15:17:56.000000000 +0200
@@ -48,6 +48,7 @@
 	u32			latency_ticks;
 	u32			power;
 	u32			usage;
+	u32                     failed;
 	struct acpi_processor_cx_policy promotion;
 	struct acpi_processor_cx_policy demotion;
 };
@@ -55,8 +56,16 @@
 struct acpi_processor_power {
 	struct acpi_processor_cx *state;
 	unsigned long		bm_check_timestamp;
-	u32			default_state;
 	u32			bm_activity;
+#ifdef CONFIG_NO_IDLE_HZ
+	u16			bm_avg_ms;
+	u64     		bm_last_measures;
+	u16     		sleep_avg_ticks;
+	u64     		sleep_last_measures;
+	unsigned long		active_timestamp;
+	u16     		active_avg_ms;
+	u64     		active_last_measures;
+#endif
 	int			count;
 	struct acpi_processor_cx states[ACPI_PROCESSOR_MAX_POWER];
 };

--------------050501040601000209010508--
