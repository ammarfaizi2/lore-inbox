Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbWBNKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbWBNKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWBNKNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:13:15 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:40682 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030274AbWBNKMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:12:53 -0500
Date: Tue, 14 Feb 2006 11:12:46 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 10/12] hrtimer: remove useless const
Message-ID: <Pine.LNX.4.61.0602141111380.3741@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A const for arguments which are passed by value is completely ignored by
gcc. It has only an effect on local variables and even here a recent gcc 
doesn't need it either to produce better code. I left a few const which 
help gcc-3.x to produce slightly smaller code.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/hrtimer.h      |    8 +++----
 include/linux/jiffies.h      |   12 +++++------
 include/linux/ktime.h        |   20 +++++++++---------
 include/linux/posix-timers.h |   22 ++++++++++----------
 include/linux/time.h         |   10 ++++-----
 kernel/hrtimer.c             |    8 +++----
 kernel/posix-cpu-timers.c    |   46 +++++++++++++++++++++----------------------
 kernel/posix-timers.c        |   26 ++++++++++++------------
 kernel/time.c                |   10 ++++-----
 9 files changed, 81 insertions(+), 81 deletions(-)

Index: linux-2.6-git/include/linux/hrtimer.h
===================================================================
--- linux-2.6-git.orig/include/linux/hrtimer.h	2006-02-13 22:30:16.000000000 +0100
+++ linux-2.6-git/include/linux/hrtimer.h	2006-02-13 22:30:18.000000000 +0100
@@ -97,7 +97,7 @@ extern void hrtimer_init(struct hrtimer 
 
 /* Basic timer operations: */
 extern int hrtimer_start(struct hrtimer *timer, ktime_t tim,
-			 const enum hrtimer_mode mode);
+			 enum hrtimer_mode mode);
 extern int hrtimer_cancel(struct hrtimer *timer);
 extern int hrtimer_try_to_cancel(struct hrtimer *timer);
 
@@ -105,7 +105,7 @@ extern int hrtimer_try_to_cancel(struct 
 
 /* Query timers: */
 extern ktime_t hrtimer_get_remaining(const struct hrtimer *timer);
-extern int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp);
+extern int hrtimer_get_res(clockid_t which_clock, struct timespec *tp);
 
 static inline int hrtimer_active(const struct hrtimer *timer)
 {
@@ -118,8 +118,8 @@ extern unsigned long hrtimer_forward(str
 /* Precise sleep: */
 extern long hrtimer_nanosleep(struct timespec *rqtp,
 			      struct timespec __user *rmtp,
-			      const enum hrtimer_mode mode,
-			      const clockid_t clockid);
+			      enum hrtimer_mode mode,
+			      clockid_t clockid);
 
 /* Soft interrupt function to run the hrtimer queues: */
 extern void hrtimer_run_queues(void);
Index: linux-2.6-git/include/linux/jiffies.h
===================================================================
--- linux-2.6-git.orig/include/linux/jiffies.h	2006-02-13 22:29:44.000000000 +0100
+++ linux-2.6-git/include/linux/jiffies.h	2006-02-13 22:30:18.000000000 +0100
@@ -243,7 +243,7 @@ static inline u64 get_jiffies_64(void)
  * Avoid unnecessary multiplications/divisions in the
  * two most common HZ cases:
  */
-static inline unsigned int jiffies_to_msecs(const unsigned long j)
+static inline unsigned int jiffies_to_msecs(unsigned long j)
 {
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
 	return (MSEC_PER_SEC / HZ) * j;
@@ -254,7 +254,7 @@ static inline unsigned int jiffies_to_ms
 #endif
 }
 
-static inline unsigned int jiffies_to_usecs(const unsigned long j)
+static inline unsigned int jiffies_to_usecs(unsigned long j)
 {
 #if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
 	return (USEC_PER_SEC / HZ) * j;
@@ -265,7 +265,7 @@ static inline unsigned int jiffies_to_us
 #endif
 }
 
-static inline unsigned long msecs_to_jiffies(const unsigned int m)
+static inline unsigned long msecs_to_jiffies(unsigned int m)
 {
 	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
@@ -278,7 +278,7 @@ static inline unsigned long msecs_to_jif
 #endif
 }
 
-static inline unsigned long usecs_to_jiffies(const unsigned int u)
+static inline unsigned long usecs_to_jiffies(unsigned int u)
 {
 	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
 		return MAX_JIFFY_OFFSET;
@@ -319,7 +319,7 @@ timespec_to_jiffies(const struct timespe
 }
 
 static __inline__ void
-jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
+jiffies_to_timespec(unsigned long jiffies, struct timespec *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
@@ -357,7 +357,7 @@ timeval_to_jiffies(const struct timeval 
 }
 
 static __inline__ void
-jiffies_to_timeval(const unsigned long jiffies, struct timeval *value)
+jiffies_to_timeval(unsigned long jiffies, struct timeval *value)
 {
 	/*
 	 * Convert jiffies to nanoseconds and separate with
Index: linux-2.6-git/include/linux/ktime.h
===================================================================
--- linux-2.6-git.orig/include/linux/ktime.h	2006-02-13 22:30:13.000000000 +0100
+++ linux-2.6-git/include/linux/ktime.h	2006-02-13 22:30:18.000000000 +0100
@@ -72,7 +72,7 @@ typedef union {
  *
  * Return the ktime_t representation of the value
  */
-static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
+static inline ktime_t ktime_set(long secs, unsigned long nsecs)
 {
 	return (ktime_t) { .tv64 = (s64)secs * NSEC_PER_SEC + (s64)nsecs };
 }
@@ -131,7 +131,7 @@ static inline ktime_t timeval_to_ktime(s
  */
 
 /* Set a ktime_t variable to a value in sec/nsec representation: */
-static inline ktime_t ktime_set(const long secs, const unsigned long nsecs)
+static inline ktime_t ktime_set(long secs, unsigned long nsecs)
 {
 	return (ktime_t) { .tv = { .sec = secs, .nsec = nsecs } };
 }
@@ -144,7 +144,7 @@ static inline ktime_t ktime_set(const lo
  *
  * Returns the remainder of the substraction
  */
-static inline ktime_t ktime_sub(const ktime_t lhs, const ktime_t rhs)
+static inline ktime_t ktime_sub(ktime_t lhs, ktime_t rhs)
 {
 	ktime_t res;
 
@@ -163,7 +163,7 @@ static inline ktime_t ktime_sub(const kt
  *
  * Returns the sum of addend1 and addend2
  */
-static inline ktime_t ktime_add(const ktime_t add1, const ktime_t add2)
+static inline ktime_t ktime_add(ktime_t add1, ktime_t add2)
 {
 	ktime_t res;
 
@@ -190,7 +190,7 @@ static inline ktime_t ktime_add(const kt
  *
  * Returns the sum of kt and nsec in ktime_t format
  */
-extern ktime_t ktime_add_ns(const ktime_t kt, u64 nsec);
+extern ktime_t ktime_add_ns(ktime_t kt, u64 nsec);
 
 /**
  * timespec_to_ktime - convert a timespec to ktime_t format
@@ -199,7 +199,7 @@ extern ktime_t ktime_add_ns(const ktime_
  *
  * Returns a ktime_t variable with the converted timespec value
  */
-static inline ktime_t timespec_to_ktime(const struct timespec ts)
+static inline ktime_t timespec_to_ktime(struct timespec ts)
 {
 	return (ktime_t) { .tv = { .sec = (s32)ts.tv_sec,
 			   	   .nsec = (s32)ts.tv_nsec } };
@@ -212,7 +212,7 @@ static inline ktime_t timespec_to_ktime(
  *
  * Returns a ktime_t variable with the converted timeval value
  */
-static inline ktime_t timeval_to_ktime(const struct timeval tv)
+static inline ktime_t timeval_to_ktime(struct timeval tv)
 {
 	return (ktime_t) { .tv = { .sec = (s32)tv.tv_sec,
 				   .nsec = (s32)tv.tv_usec * 1000 } };
@@ -225,7 +225,7 @@ static inline ktime_t timeval_to_ktime(c
  *
  * Returns the timespec representation of the ktime value
  */
-static inline struct timespec ktime_to_timespec(const ktime_t kt)
+static inline struct timespec ktime_to_timespec(ktime_t kt)
 {
 	return (struct timespec) { .tv_sec = (time_t) kt.tv.sec,
 				   .tv_nsec = (long) kt.tv.nsec };
@@ -238,7 +238,7 @@ static inline struct timespec ktime_to_t
  *
  * Returns the timeval representation of the ktime value
  */
-static inline struct timeval ktime_to_timeval(const ktime_t kt)
+static inline struct timeval ktime_to_timeval(ktime_t kt)
 {
 	return (struct timeval) {
 		.tv_sec = (time_t) kt.tv.sec,
@@ -251,7 +251,7 @@ static inline struct timeval ktime_to_ti
  *
  * Returns the scalar nanoseconds representation of kt
  */
-static inline u64 ktime_to_ns(const ktime_t kt)
+static inline u64 ktime_to_ns(ktime_t kt)
 {
 	return (u64) kt.tv.sec * NSEC_PER_SEC + kt.tv.nsec;
 }
Index: linux-2.6-git/include/linux/posix-timers.h
===================================================================
--- linux-2.6-git.orig/include/linux/posix-timers.h	2006-02-13 22:29:44.000000000 +0100
+++ linux-2.6-git/include/linux/posix-timers.h	2006-02-13 22:30:18.000000000 +0100
@@ -66,11 +66,11 @@ struct k_itimer {
 
 struct k_clock {
 	int res;		/* in nanoseconds */
-	int (*clock_getres) (const clockid_t which_clock, struct timespec *tp);
-	int (*clock_set) (const clockid_t which_clock, struct timespec * tp);
-	int (*clock_get) (const clockid_t which_clock, struct timespec * tp);
+	int (*clock_getres) (clockid_t which_clock, struct timespec *tp);
+	int (*clock_set) (clockid_t which_clock, struct timespec * tp);
+	int (*clock_get) (clockid_t which_clock, struct timespec * tp);
 	int (*timer_create) (struct k_itimer *timer);
-	int (*nsleep) (const clockid_t which_clock, int flags,
+	int (*nsleep) (clockid_t which_clock, int flags,
 		       struct timespec *, struct timespec __user *);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
@@ -81,21 +81,21 @@ struct k_clock {
 			   struct itimerspec * cur_setting);
 };
 
-void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock);
+void register_posix_clock(clockid_t clock_id, struct k_clock *new_clock);
 
 /* error handlers for timer_create, nanosleep and settime */
-int do_posix_clock_nonanosleep(const clockid_t, int flags, struct timespec *,
+int do_posix_clock_nonanosleep(clockid_t, int flags, struct timespec *,
 			       struct timespec __user *);
-int do_posix_clock_nosettime(const clockid_t, struct timespec *tp);
+int do_posix_clock_nosettime(clockid_t, struct timespec *tp);
 
 /* function to call to trigger timer event */
 int posix_timer_event(struct k_itimer *timr, int si_private);
 
-int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *ts);
-int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *ts);
-int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *ts);
+int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *ts);
+int posix_cpu_clock_get(clockid_t which_clock, struct timespec *ts);
+int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *ts);
 int posix_cpu_timer_create(struct k_itimer *timer);
-int posix_cpu_nsleep(const clockid_t which_clock, int flags,
+int posix_cpu_nsleep(clockid_t which_clock, int flags,
 		     struct timespec *rqtp, struct timespec __user *rmtp);
 int posix_cpu_timer_set(struct k_itimer *timer, int flags,
 			struct itimerspec *new, struct itimerspec *old);
Index: linux-2.6-git/include/linux/time.h
===================================================================
--- linux-2.6-git.orig/include/linux/time.h	2006-02-13 22:29:44.000000000 +0100
+++ linux-2.6-git/include/linux/time.h	2006-02-13 22:30:18.000000000 +0100
@@ -61,9 +61,9 @@ static inline int timeval_compare(struct
 	return lhs->tv_usec - rhs->tv_usec;
 }
 
-extern unsigned long mktime(const unsigned int year, const unsigned int mon,
-			    const unsigned int day, const unsigned int hour,
-			    const unsigned int min, const unsigned int sec);
+extern unsigned long mktime(unsigned int year, unsigned int mon,
+			    unsigned int day, unsigned int hour,
+			    unsigned int min, unsigned int sec);
 
 extern void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec);
 
@@ -137,7 +137,7 @@ static inline nsec_t timeval_to_ns(const
  *
  * Returns the timespec representation of the nsec parameter.
  */
-extern struct timespec ns_to_timespec(const nsec_t nsec);
+extern struct timespec ns_to_timespec(nsec_t nsec);
 
 /**
  * ns_to_timeval - Convert nanoseconds to timeval
@@ -145,7 +145,7 @@ extern struct timespec ns_to_timespec(co
  *
  * Returns the timeval representation of the nsec parameter.
  */
-extern struct timeval ns_to_timeval(const nsec_t nsec);
+extern struct timeval ns_to_timeval(nsec_t nsec);
 
 #endif /* __KERNEL__ */
 
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-13 22:30:16.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-13 22:30:18.000000000 +0100
@@ -224,7 +224,7 @@ lock_hrtimer_base(const struct hrtimer *
  *
  * Returns the sum of kt and nsec in ktime_t format
  */
-ktime_t ktime_add_ns(const ktime_t kt, u64 nsec)
+ktime_t ktime_add_ns(ktime_t kt, u64 nsec)
 {
 	ktime_t tmp;
 
@@ -401,7 +401,7 @@ remove_hrtimer(struct hrtimer *timer, st
  *  1 when the timer was active
  */
 int
-hrtimer_start(struct hrtimer *timer, ktime_t tim, const enum hrtimer_mode mode)
+hrtimer_start(struct hrtimer *timer, ktime_t tim, enum hrtimer_mode mode)
 {
 	struct hrtimer_base *base, *new_base;
 	unsigned long flags;
@@ -524,7 +524,7 @@ void hrtimer_init(struct hrtimer *timer,
  * Store the resolution of the clock selected by which_clock in the
  * variable pointed to by tp.
  */
-int hrtimer_get_res(const clockid_t which_clock, struct timespec *tp)
+int hrtimer_get_res(clockid_t which_clock, struct timespec *tp)
 {
 	struct hrtimer_base *bases;
 
@@ -662,7 +662,7 @@ static long __sched nanosleep_restart(st
 }
 
 long hrtimer_nanosleep(struct timespec *rqtp, struct timespec __user *rmtp,
-		       const enum hrtimer_mode mode, const clockid_t clockid)
+		       enum hrtimer_mode mode, clockid_t clockid)
 {
 	struct restart_block *restart;
 	struct sleep_hrtimer t;
Index: linux-2.6-git/kernel/posix-cpu-timers.c
===================================================================
--- linux-2.6-git.orig/kernel/posix-cpu-timers.c	2006-02-13 22:29:44.000000000 +0100
+++ linux-2.6-git/kernel/posix-cpu-timers.c	2006-02-13 22:30:18.000000000 +0100
@@ -7,11 +7,11 @@
 #include <asm/uaccess.h>
 #include <linux/errno.h>
 
-static int check_clock(const clockid_t which_clock)
+static int check_clock(clockid_t which_clock)
 {
 	int error = 0;
 	struct task_struct *p;
-	const pid_t pid = CPUCLOCK_PID(which_clock);
+	pid_t pid = CPUCLOCK_PID(which_clock);
 
 	if (CPUCLOCK_WHICH(which_clock) >= CPUCLOCK_MAX)
 		return -EINVAL;
@@ -31,7 +31,7 @@ static int check_clock(const clockid_t w
 }
 
 static inline union cpu_time_count
-timespec_to_sample(const clockid_t which_clock, const struct timespec *tp)
+timespec_to_sample(clockid_t which_clock, const struct timespec *tp)
 {
 	union cpu_time_count ret;
 	ret.sched = 0;		/* high half always zero when .cpu used */
@@ -43,7 +43,7 @@ timespec_to_sample(const clockid_t which
 	return ret;
 }
 
-static void sample_to_timespec(const clockid_t which_clock,
+static void sample_to_timespec(clockid_t which_clock,
 			       union cpu_time_count cpu,
 			       struct timespec *tp)
 {
@@ -55,7 +55,7 @@ static void sample_to_timespec(const clo
 	}
 }
 
-static inline int cpu_time_before(const clockid_t which_clock,
+static inline int cpu_time_before(clockid_t which_clock,
 				  union cpu_time_count now,
 				  union cpu_time_count then)
 {
@@ -65,7 +65,7 @@ static inline int cpu_time_before(const 
 		return cputime_lt(now.cpu, then.cpu);
 	}
 }
-static inline void cpu_time_add(const clockid_t which_clock,
+static inline void cpu_time_add(clockid_t which_clock,
 				union cpu_time_count *acc,
 			        union cpu_time_count val)
 {
@@ -75,7 +75,7 @@ static inline void cpu_time_add(const cl
 		acc->cpu = cputime_add(acc->cpu, val.cpu);
 	}
 }
-static inline union cpu_time_count cpu_time_sub(const clockid_t which_clock,
+static inline union cpu_time_count cpu_time_sub(clockid_t which_clock,
 						union cpu_time_count a,
 						union cpu_time_count b)
 {
@@ -151,7 +151,7 @@ static inline unsigned long long sched_n
 	return (p == current) ? current_sched_time(p) : p->sched_time;
 }
 
-int posix_cpu_clock_getres(const clockid_t which_clock, struct timespec *tp)
+int posix_cpu_clock_getres(clockid_t which_clock, struct timespec *tp)
 {
 	int error = check_clock(which_clock);
 	if (!error) {
@@ -169,7 +169,7 @@ int posix_cpu_clock_getres(const clockid
 	return error;
 }
 
-int posix_cpu_clock_set(const clockid_t which_clock, const struct timespec *tp)
+int posix_cpu_clock_set(clockid_t which_clock, const struct timespec *tp)
 {
 	/*
 	 * You can never reset a CPU clock, but we check for other errors
@@ -186,7 +186,7 @@ int posix_cpu_clock_set(const clockid_t 
 /*
  * Sample a per-thread clock for the given task.
  */
-static int cpu_clock_sample(const clockid_t which_clock, struct task_struct *p,
+static int cpu_clock_sample(clockid_t which_clock, struct task_struct *p,
 			    union cpu_time_count *cpu)
 {
 	switch (CPUCLOCK_WHICH(which_clock)) {
@@ -248,7 +248,7 @@ static int cpu_clock_sample_group_locked
  * Sample a process (thread group) clock for the given group_leader task.
  * Must be called with tasklist_lock held for reading.
  */
-static int cpu_clock_sample_group(const clockid_t which_clock,
+static int cpu_clock_sample_group(clockid_t which_clock,
 				  struct task_struct *p,
 				  union cpu_time_count *cpu)
 {
@@ -262,9 +262,9 @@ static int cpu_clock_sample_group(const 
 }
 
 
-int posix_cpu_clock_get(const clockid_t which_clock, struct timespec *tp)
+int posix_cpu_clock_get(clockid_t which_clock, struct timespec *tp)
 {
-	const pid_t pid = CPUCLOCK_PID(which_clock);
+	pid_t pid = CPUCLOCK_PID(which_clock);
 	int error = -EINVAL;
 	union cpu_time_count rtn;
 
@@ -321,7 +321,7 @@ int posix_cpu_clock_get(const clockid_t 
 int posix_cpu_timer_create(struct k_itimer *new_timer)
 {
 	int ret = 0;
-	const pid_t pid = CPUCLOCK_PID(new_timer->it_clock);
+	pid_t pid = CPUCLOCK_PID(new_timer->it_clock);
 	struct task_struct *p;
 
 	if (CPUCLOCK_WHICH(new_timer->it_clock) >= CPUCLOCK_MAX)
@@ -551,7 +551,7 @@ static void arm_timer(struct k_itimer *t
 {
 	struct task_struct *p = timer->it.cpu.task;
 	struct list_head *head, *listpos;
-	struct cpu_timer_list *const nt = &timer->it.cpu;
+	struct cpu_timer_list *nt = &timer->it.cpu;
 	struct cpu_timer_list *next;
 	unsigned long i;
 
@@ -1006,7 +1006,7 @@ static void check_process_timers(struct 
 				 struct list_head *firing)
 {
 	int maxfire;
-	struct signal_struct *const sig = tsk->signal;
+	struct signal_struct *sig = tsk->signal;
 	cputime_t utime, stime, ptime, virt_expires, prof_expires;
 	unsigned long long sched_time, sched_expires;
 	struct task_struct *t;
@@ -1155,7 +1155,7 @@ static void check_process_timers(struct 
 
 		cputime_t prof_left, virt_left, ticks;
 		unsigned long long sched_left, sched;
-		const unsigned int nthreads = atomic_read(&sig->live);
+		unsigned int nthreads = atomic_read(&sig->live);
 
 		if (!nthreads)
 			return;
@@ -1507,12 +1507,12 @@ posix_cpu_clock_nanosleep_restart(struct
 #define PROCESS_CLOCK	MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED)
 #define THREAD_CLOCK	MAKE_THREAD_CPUCLOCK(0, CPUCLOCK_SCHED)
 
-static int process_cpu_clock_getres(const clockid_t which_clock,
+static int process_cpu_clock_getres(clockid_t which_clock,
 				    struct timespec *tp)
 {
 	return posix_cpu_clock_getres(PROCESS_CLOCK, tp);
 }
-static int process_cpu_clock_get(const clockid_t which_clock,
+static int process_cpu_clock_get(clockid_t which_clock,
 				 struct timespec *tp)
 {
 	return posix_cpu_clock_get(PROCESS_CLOCK, tp);
@@ -1522,18 +1522,18 @@ static int process_cpu_timer_create(stru
 	timer->it_clock = PROCESS_CLOCK;
 	return posix_cpu_timer_create(timer);
 }
-static int process_cpu_nsleep(const clockid_t which_clock, int flags,
+static int process_cpu_nsleep(clockid_t which_clock, int flags,
 			      struct timespec *rqtp,
 			      struct timespec __user *rmtp)
 {
 	return posix_cpu_nsleep(PROCESS_CLOCK, flags, rqtp, rmtp);
 }
-static int thread_cpu_clock_getres(const clockid_t which_clock,
+static int thread_cpu_clock_getres(clockid_t which_clock,
 				   struct timespec *tp)
 {
 	return posix_cpu_clock_getres(THREAD_CLOCK, tp);
 }
-static int thread_cpu_clock_get(const clockid_t which_clock,
+static int thread_cpu_clock_get(clockid_t which_clock,
 				struct timespec *tp)
 {
 	return posix_cpu_clock_get(THREAD_CLOCK, tp);
@@ -1543,7 +1543,7 @@ static int thread_cpu_timer_create(struc
 	timer->it_clock = THREAD_CLOCK;
 	return posix_cpu_timer_create(timer);
 }
-static int thread_cpu_nsleep(const clockid_t which_clock, int flags,
+static int thread_cpu_nsleep(clockid_t which_clock, int flags,
 			      struct timespec *rqtp, struct timespec __user *rmtp)
 {
 	return -EINVAL;
Index: linux-2.6-git/kernel/posix-timers.c
===================================================================
--- linux-2.6-git.orig/kernel/posix-timers.c	2006-02-13 22:30:16.000000000 +0100
+++ linux-2.6-git/kernel/posix-timers.c	2006-02-13 22:30:18.000000000 +0100
@@ -137,7 +137,7 @@ static struct k_clock posix_clocks[MAX_C
 /*
  * These ones are defined below.
  */
-static int common_nsleep(const clockid_t, int flags, struct timespec *t,
+static int common_nsleep(clockid_t, int flags, struct timespec *t,
 			 struct timespec __user *rmtp);
 static void common_timer_get(struct k_itimer *, struct itimerspec *);
 static int common_timer_set(struct k_itimer *, int,
@@ -169,7 +169,7 @@ static inline void unlock_timer(struct k
  * the function pointer CALL in struct k_clock.
  */
 
-static inline int common_clock_getres(const clockid_t which_clock,
+static inline int common_clock_getres(clockid_t which_clock,
 				      struct timespec *tp)
 {
 	tp->tv_sec = 0;
@@ -186,7 +186,7 @@ static int common_clock_get(clockid_t wh
 	return 0;
 }
 
-static inline int common_clock_set(const clockid_t which_clock,
+static inline int common_clock_set(clockid_t which_clock,
 				   struct timespec *tp)
 {
 	return do_sys_settimeofday(tp, NULL);
@@ -201,7 +201,7 @@ static int common_timer_create(struct k_
 /*
  * Return nonzero if we know a priori this clockid_t value is bogus.
  */
-static inline int invalid_clockid(const clockid_t which_clock)
+static inline int invalid_clockid(clockid_t which_clock)
 {
 	if (which_clock < 0)	/* CPU clock, posix_cpu_* will check it */
 		return 0;
@@ -379,7 +379,7 @@ static struct task_struct * good_sigeven
 	return rtn;
 }
 
-void register_posix_clock(const clockid_t clock_id, struct k_clock *new_clock)
+void register_posix_clock(clockid_t clock_id, struct k_clock *new_clock)
 {
 	if ((unsigned) clock_id >= MAX_CLOCKS) {
 		printk("POSIX clock register failed for clock_id %d\n",
@@ -425,7 +425,7 @@ static void release_posix_timer(struct k
 /* Create a POSIX.1b interval timer. */
 
 asmlinkage long
-sys_timer_create(const clockid_t which_clock,
+sys_timer_create(clockid_t which_clock,
 		 struct sigevent __user *timer_event_spec,
 		 timer_t __user * created_timer_id)
 {
@@ -868,13 +868,13 @@ void exit_itimers(struct signal_struct *
 }
 
 /* Not available / possible... functions */
-int do_posix_clock_nosettime(const clockid_t clockid, struct timespec *tp)
+int do_posix_clock_nosettime(clockid_t clockid, struct timespec *tp)
 {
 	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(do_posix_clock_nosettime);
 
-int do_posix_clock_nonanosleep(const clockid_t clock, int flags,
+int do_posix_clock_nonanosleep(clockid_t clock, int flags,
 			       struct timespec *t, struct timespec __user *r)
 {
 #ifndef ENOTSUP
@@ -885,7 +885,7 @@ int do_posix_clock_nonanosleep(const clo
 }
 EXPORT_SYMBOL_GPL(do_posix_clock_nonanosleep);
 
-asmlinkage long sys_clock_settime(const clockid_t which_clock,
+asmlinkage long sys_clock_settime(clockid_t which_clock,
 				  const struct timespec __user *tp)
 {
 	struct timespec new_tp;
@@ -899,7 +899,7 @@ asmlinkage long sys_clock_settime(const 
 }
 
 asmlinkage long
-sys_clock_gettime(const clockid_t which_clock, struct timespec __user *tp)
+sys_clock_gettime(clockid_t which_clock, struct timespec __user *tp)
 {
 	struct timespec kernel_tp;
 	int error;
@@ -916,7 +916,7 @@ sys_clock_gettime(const clockid_t which_
 }
 
 asmlinkage long
-sys_clock_getres(const clockid_t which_clock, struct timespec __user *tp)
+sys_clock_getres(clockid_t which_clock, struct timespec __user *tp)
 {
 	struct timespec rtn_tp;
 	int error;
@@ -937,7 +937,7 @@ sys_clock_getres(const clockid_t which_c
 /*
  * nanosleep for monotonic and realtime clocks
  */
-static int common_nsleep(const clockid_t which_clock, int flags,
+static int common_nsleep(clockid_t which_clock, int flags,
 			 struct timespec *tsave, struct timespec __user *rmtp)
 {
 	return hrtimer_nanosleep(tsave, rmtp, flags & TIMER_ABSTIME ?
@@ -945,7 +945,7 @@ static int common_nsleep(const clockid_t
 }
 
 asmlinkage long
-sys_clock_nanosleep(const clockid_t which_clock, int flags,
+sys_clock_nanosleep(clockid_t which_clock, int flags,
 		    const struct timespec __user *rqtp,
 		    struct timespec __user *rmtp)
 {
Index: linux-2.6-git/kernel/time.c
===================================================================
--- linux-2.6-git.orig/kernel/time.c	2006-02-13 22:29:44.000000000 +0100
+++ linux-2.6-git/kernel/time.c	2006-02-13 22:30:18.000000000 +0100
@@ -581,9 +581,9 @@ EXPORT_SYMBOL_GPL(getnstimeofday);
  * will already get problems at other places on 2038-01-19 03:14:08)
  */
 unsigned long
-mktime(const unsigned int year0, const unsigned int mon0,
-       const unsigned int day, const unsigned int hour,
-       const unsigned int min, const unsigned int sec)
+mktime(unsigned int year0, unsigned int mon0,
+       unsigned int day, unsigned int hour,
+       unsigned int min, unsigned int sec)
 {
 	unsigned int mon = mon0, year = year0;
 
@@ -637,7 +637,7 @@ void set_normalized_timespec(struct time
  *
  * Returns the timespec representation of the nsec parameter.
  */
-struct timespec ns_to_timespec(const nsec_t nsec)
+struct timespec ns_to_timespec(nsec_t nsec)
 {
 	struct timespec ts;
 
@@ -657,7 +657,7 @@ struct timespec ns_to_timespec(const nse
  *
  * Returns the timeval representation of the nsec parameter.
  */
-struct timeval ns_to_timeval(const nsec_t nsec)
+struct timeval ns_to_timeval(nsec_t nsec)
 {
 	struct timespec ts = ns_to_timespec(nsec);
 	struct timeval tv;
