Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVFIN3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVFIN3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 09:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVFIN3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 09:29:47 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:42411 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262403AbVFINPp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 09:15:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s1ZzPcLrZS1qrJMM75t7pAM534iDUmdNF6031+nYLHRoD/hT6uOGzLrDDI0UX+VvVueT1Nht6DQQX+LwDl35UrQBXgsCT56s/sY9dENtVBUAmFp56xlcXtxNIwdpNqK2pp3uaz9dnP9pDpkTku7W8pTaGBWLQfnvb84sD7Ahxtw=
Message-ID: <84144f020506090615f6d67fc@mail.gmail.com>
Date: Thu, 9 Jun 2005 16:15:41 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH 1/4] new timeofday core subsystem (v. B2)
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Nishanth Aravamudan <nacc@us.ibm.com>, Darren Hart <darren@dvhart.com>,
       "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

Some coding style comments below.

                      Pekka

On 6/9/05, john stultz <johnstul@us.ibm.com> wrote:
> Index: include/linux/timesource.h
> ===================================================================
> --- /dev/null  (tree:9b72b650285720c17d0aa0a3795c30fe492700b3)
> +++ 00e808a96ae388482e12d64053b45f880799cb67/include/linux/timesource.h  (mode:100644)
> @@ -0,0 +1,171 @@
> +/*  linux/include/linux/timesource.h
> + *
> + *  This file contains the structure definitions for timesources.
> + *
> + *  If you are not a timesource, or the time of day code, you should
> + *  not be including this file!
> + */
> +#ifndef _LINUX_TIMESORUCE_H
> +#define _LINUX_TIMESORUCE_H

Typo.

> +++ 00e808a96ae388482e12d64053b45f880799cb67/kernel/ntp.c  (mode:100644)
> @@ -0,0 +1,519 @@
> +/********************************************************************
> +* linux/kernel/ntp.c
> +*
> +* Revision History:
> +* 2004-09-02:  A0
> +*   o First pass sent to lkml for review.
> +* 2004-12-07:  A1
> +*   o No changes, sent to lkml for review.
> +* 2005-03-11:  A3
> +*   o yanked ntp_scale(), ntp adjustments are done in cyc2ns
> +* 2005-04-29:  A4
> +*   o Added conditional debug info
> +* 2005-05-12:  A5
> +*   o comment cleanups
> +* 2005-05-31:  B0
> +*   o comment cleanups
> +*	o Improved rounding

Please drop this (useless) revision history.

> +/* NTP scaling code
> + * Functions:
> + * ----------
> + * nsec_t ntp_scale(nsec_t value):
> + *      Scales the nsec_t vale using ntp kernel state
> + * void ntp_advance(nsec_t interval):
> + *      Increments the NTP state machine by interval time
> + * static int ntp_hardupdate(long offset, struct timeval tv)
> + *      ntp_adjtimex helper function
> + * int ntp_adjtimex(struct timex* tx):
> + *      Interface to adjust NTP state machine
> + * int ntp_leapsecond(struct timespec now)
> + *      Does NTP leapsecond processing. Returns number of
> + *      seconds current time should be adjusted by.
> + * void ntp_clear(void):
> + *      Clears the ntp kernel state
> + * int get_ntp_status(void):
> + *      returns ntp_status value
> + *
> + * Variables:
> + * ----------
> + * ntp kernel state variables:
> + *      See below for full list.
> + * ntp_lock:
> + *      Protects ntp kernel state variables
> + */

Please drop the above ToC as it is not even up to date anymore (at least
ntp_scale is gone).

> +int ntp_advance(nsec_t interval)
> +{
> +	static u64 interval_sum = 0;
> +	static long ss_adj = 0;
> +	unsigned long flags;
> +	long ppm_sum;
> +
> +	/* inc interval sum */

Please drop this redundant comment.

> +	interval_sum += interval;
> +
> +	write_seqlock_irqsave(&ntp_lock, flags);
> +
> +	/* decrement singleshot offset interval */

Ditto.

> +	ss_offset_len -= interval;
> +	if(ss_offset_len < 0) /* make sure it doesn't go negative */

Ditto.

> +		ss_offset_len = 0;
> +
> +	/* Do second overflow code */

Highly confusing comment. Preferred fix is to drop it.

> +	while (interval_sum > NSEC_PER_SEC) {
> +		/* XXX - I'd prefer to smoothly apply this math
> +		 * at each call to ntp_advance() rather then each
> +		 * second.
> +		 */
> +		long tmp;
> +
> +		/* Bump maxerror by ntp_tolerance */

Drop redundant comment.

> +		ntp_maxerror += shiftR(ntp_tolerance, SHIFT_USEC);
> +		if (ntp_maxerror > NTP_PHASE_LIMIT) {
> +			ntp_maxerror = NTP_PHASE_LIMIT;
> +			ntp_status |= STA_UNSYNC;
> +		}
> +
> +		/* Calculate offset_adj for the next second */

Ditto.

> +		tmp = ntp_offset;

tmp could use a more descriptive name.

> +		if (!(ntp_status & STA_FLL))
> +		    tmp = shiftR(tmp, SHIFT_KG + ntp_constant);
> +
> +		/* bound the adjustment to MAXPHASE/MINSEC */

Redundant comment.

> +		tmp = min(tmp, (MAXPHASE / MINSEC) << SHIFT_UPDATE);
> +		tmp = max(tmp, -(MAXPHASE / MINSEC) << SHIFT_UPDATE);
> +
> +		offset_adj = shiftR(tmp, SHIFT_UPDATE); /* (usec/sec) = ppm */
> +		ntp_offset -= tmp;
> +
> +		interval_sum -= NSEC_PER_SEC;
> +
> +		/* calculate singleshot aproximation ppm for the next second */

Ditto.

> +/**
> + * ntp_hardupdate - Calculates the offset and freq values
> + * offset: current offset
> + * tv: timeval holding the current time
> + *
> + * Private function, called only by ntp_adjtimex while holding ntp_lock

All static functions are private so why duplicate that in the comment?

> + *
> + * This function is called when an offset adjustment is requested.
> + * It calculates the offset adjustment and manipulates the
> + * frequency adjustement accordingly.
> + */
> +static int ntp_hardupdate(long offset, struct timeval tv)
> +{
> +	int ret;
> +	long tmp, interval;
> +
> +	ret = 0;
> +	if (!(ntp_status & STA_PLL))
> +		return ret;
> +
> +	tmp = offset;

tmp could use a better name. new_offset?

> +	/* Make sure offset is bounded by MAXPHASE */

Redundant comment.

> +	tmp = min(tmp, MAXPHASE);
> +	tmp = max(tmp, -MAXPHASE);
> +
> +	ntp_offset = tmp << SHIFT_UPDATE;
> +
> +	if ((ntp_status & STA_FREQHOLD) || (ntp_reftime == 0))
> +		ntp_reftime = tv.tv_sec;
> +
> +	/* calculate seconds since last call to hardupdate */

Ditto.

> +	interval = tv.tv_sec - ntp_reftime;
> +	ntp_reftime = tv.tv_sec;
> +
> +	if ((ntp_status & STA_FLL) && (interval >= MINSEC)) {
> +		long damping;
> +		/* calculate frequency for this interval */

Redundant comment. tmp could use a better name. Introduce a new variable.

> +		tmp = (offset + interval/2) / interval; /* ppm (usec/sec)*/
> +
> +		/* calculate damping factor */

Redundant comment.

> +		damping = SHIFT_KH - SHIFT_USEC;
> +
> +		/* convert to shifted ppm, then apply damping factor */

Redundant comment.

> +		ntp_freq += shiftR(tmp,damping);
> +#if NTP_DEBUG
> +		printk("ntp->freq change: %ld\n",shiftR(tmp,damping));
> +#endif
> +
> +	} else if ((ntp_status & STA_PLL) && (interval < MAXSEC)) {
> +		long damping;
> +		tmp = offset * interval;

tmp could use a better name. Introduce a new variable.

> +
> +		/* calculate damping factor */

Redundant comment.

> +		damping = (2 * ntp_constant) + SHIFT_KF - SHIFT_USEC;
> +
> +		/* apply damping factor */

Redundant comment.

> +		ntp_freq += shiftR(tmp,damping);
> +
> +#if NTP_DEBUG
> +		printk("ntp->freq change: %ld\n", shiftR(tmp,damping));
> +#endif
> +	} else { /* interval out of bounds */

Redundant comment.

> +#if NTP_DEBUG
> +		printk("ntp_hardupdate(): interval out of bounds: %ld status: 0x%x\n",
> +				interval, ntp_status);
> +#endif
> +		ret = -1; /* TIME_ERROR */

Use constant instead of comment.

> +	}
> +
> +	/* bound ntp_freq */

Redundant comment.

> +	if (ntp_freq > ntp_tolerance)
> +		ntp_freq = ntp_tolerance;
> +	if (ntp_freq < -ntp_tolerance)
> +		ntp_freq = -ntp_tolerance;
> +
> +	return ret;
> +}
> +
> +/**
> + * ntp_adjtimex - Interface to change NTP state machine
> + * @tx: timex value passed to the kernel to be used
> + */
> +int ntp_adjtimex(struct timex* tx)
> +{
> +	long save_offset;
> +	int result;
> +	unsigned long flags;
> +
> +/* Sanity checking
> + */
> +	/* frequency adjustment limited to +/- MAXFREQ */

Redundant comment.

> +	if ((tx->modes & ADJ_FREQUENCY)
> +			&& (abs(tx->freq) > MAXFREQ))

Spurious parenthesis.

> +		return -EINVAL;
> +
> +	/* maxerror adjustment limited to NTP_PHASE_LIMIT */
> +	if ((tx->modes & ADJ_MAXERROR)
> +			&& (tx->maxerror < 0
> +				|| tx->maxerror >= NTP_PHASE_LIMIT))
> +		return -EINVAL;
> +
> +	/* esterror adjustment limited to NTP_PHASE_LIMIT */
> +	if ((tx->modes & ADJ_ESTERROR)
> +			&& (tx->esterror < 0
> +				|| tx->esterror >= NTP_PHASE_LIMIT))
> +		return -EINVAL;
> +
> +	/* constant adjustment must be positive */
> +	if ((tx->modes & ADJ_TIMECONST)
> +			&& (tx->constant < 0))
> +		return -EINVAL;
> +
> +	/* Single shot mode can only be used by itself */
> +	if (((tx->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
> +			&& (tx->modes != ADJ_OFFSET_SINGLESHOT))
> +		return -EINVAL;
> +
> +	/* offset adjustment limited to +/- MAXPHASE */
> +	if ((tx->modes != ADJ_OFFSET_SINGLESHOT)
> +			&& (tx->modes & ADJ_OFFSET)
> +			&& (abs(tx->offset)>= MAXPHASE))
> +		return -EINVAL;
> +
> +	/* tick adjustment limited to 10% */
> +	if ((tx->modes & ADJ_TICK)
> +			&& ((tx->tick < 900000/USER_HZ)
> +				||(tx->tick > 11000000/USER_HZ)))
> +		return -EINVAL;

Ditto for all the above if statements.

> +
> +#if NTP_DEBUG
> +	if(tx->modes) {
> +		printk("adjtimex: tx->offset: %ld    tx->freq: %ld\n",
> +				tx->offset, tx->freq);
> +	}
> +#endif
> +
> +/* Kernel input bits
> + */

Strange comment. Extract function rather than introduce 'place holder'
comments such as the above.

> +	write_seqlock_irqsave(&ntp_lock, flags);
> +
> +	result = ntp_state;
> +
> +	/* For ADJ_OFFSET_SINGLESHOT we must return the old offset */
> +	save_offset = shiftR(ntp_offset, SHIFT_UPDATE);
> +
> +	/* Process input parameters */

Redundant comment.

> +	if (tx->modes & ADJ_STATUS) {
> +		ntp_status &=  STA_RONLY;
> +		ntp_status |= tx->status & ~STA_RONLY;
> +	}
> +
> +	if (tx->modes & ADJ_FREQUENCY)
> +		ntp_freq = tx->freq;
> +
> +	if (tx->modes & ADJ_MAXERROR)
> +		ntp_maxerror = tx->maxerror;
> +
> +	if (tx->modes & ADJ_ESTERROR)
> +		ntp_esterror = tx->esterror;
> +
> +	if (tx->modes & ADJ_TIMECONST)
> +		ntp_constant = tx->constant;
> +
> +	if (tx->modes & ADJ_OFFSET) {
> +		/* check if we're doing a singleshot adjustment */

Redundant comment.

> +		if (tx->modes == ADJ_OFFSET_SINGLESHOT)
> +				singleshot_adj = tx->offset;
> +		/* otherwise, call hardupdate() */

Ditto.

> +		else if (ntp_hardupdate(tx->offset, tx->time))
> +			result = TIME_ERROR;
> +	}
> +
> +	if (tx->modes & ADJ_TICK) {
> +		/* first calculate usec/user_tick offset */

Ditto.

> +		tick_adj = ((USEC_PER_SEC + USER_HZ/2)/USER_HZ) - tx->tick;
> +		/* multiply by user_hz to get usec/sec => ppm */

Ditto.

> +		tick_adj *= USER_HZ;
> +		/* save tx->tick for future calls to adjtimex */

Ditto.

> +		ntp_tick = tx->tick;
> +	}
> +
> +	if ((ntp_status & (STA_UNSYNC|STA_CLOCKERR)) != 0 )
> +		result = TIME_ERROR;
> +
> +/* Kernel output bits
> + */
> +	/* write kernel state to user timex values*/

Ditto.

> +	if ((tx->modes & ADJ_OFFSET_SINGLESHOT) == ADJ_OFFSET_SINGLESHOT)
> +		tx->offset = save_offset;
> +	else
> +		tx->offset = shiftR(ntp_offset, SHIFT_UPDATE);
> +
> +	tx->freq = ntp_freq;
> +	tx->maxerror = ntp_maxerror;
> +	tx->esterror = ntp_esterror;
> +	tx->status = ntp_status;
> +	tx->constant = ntp_constant;
> +	tx->precision = ntp_precision;
> +	tx->tolerance = ntp_tolerance;
> +
> +	/* PPS is not implemented, so these are zero */
> +	tx->ppsfreq	= /*XXX - Not Implemented!*/ 0;
> +	tx->jitter	= /*XXX - Not Implemented!*/ 0;
> +	tx->shift	= /*XXX - Not Implemented!*/ 0;
> +	tx->stabil	= /*XXX - Not Implemented!*/ 0;
> +	tx->jitcnt	= /*XXX - Not Implemented!*/ 0;
> +	tx->calcnt	= /*XXX - Not Implemented!*/ 0;
> +	tx->errcnt	= /*XXX - Not Implemented!*/ 0;
> +	tx->stbcnt	= /*XXX - Not Implemented!*/ 0;

One comment is enough.

> +
> +	write_sequnlock_irqrestore(&ntp_lock, flags);
> +
> +	return result;
> +}
> +
> +
> +/**
> + * ntp_leapsecond - NTP leapsecond processing code.
> + * now: the current time
> + *
> + * Returns the number of seconds (-1, 0, or 1) that
> + * should be added to the current time to properly
> + * adjust for leapseconds.
> + */
> +int ntp_leapsecond(struct timespec now)
> +{
> +	/*
> +	 * Leap second processing. If in leap-insert state at
> +	 * the end of the day, the system clock is set back one
> +	 * second; if in leap-delete state, the system clock is
> +	 * set ahead one second.
> +	 */
> +	static time_t leaptime = 0;
> +
> +	switch (ntp_state) {
> +	case TIME_OK:
> +		if (ntp_status & STA_INS) {
> +			ntp_state = TIME_INS;
> +			/* calculate end of today (23:59:59)*/
> +			leaptime = now.tv_sec + SEC_PER_DAY -
> +					(now.tv_sec % SEC_PER_DAY) - 1;
> +		}
> +		else if (ntp_status & STA_DEL) {
> +			ntp_state = TIME_DEL;
> +			/* calculate end of today (23:59:59)*/
> +			leaptime = now.tv_sec + SEC_PER_DAY -
> +					(now.tv_sec % SEC_PER_DAY) - 1;

Duplicate code. Please introduce ntp_end_of_today().

> +void ntp_clear(void)
> +{
> +	unsigned long flags;
> +	write_seqlock_irqsave(&ntp_lock, flags);
> +
> +	/* clear everything */

Redundant comment.

> Index: kernel/timeofday.c
> ===================================================================
> --- /dev/null  (tree:9b72b650285720c17d0aa0a3795c30fe492700b3)
> +++ 00e808a96ae388482e12d64053b45f880799cb67/kernel/timeofday.c  (mode:100644)
> @@ -0,0 +1,607 @@
> +/*********************************************************************
> +* linux/kernel/timeofday.c
> +*
> +* Revision History:
> +* 2004-09-02:   A0
> +*   o First pass sent to lkml for review.
> +* 2004-12-07:   A1
> +*   o Rework of timesource structure
> +*   o Sent to lkml for review
> +* 2005-01-24:   A2
> +*   o write_seqlock_irq -> writeseqlock_irqsave
> +*   o arch generic interface for for get_cmos_time() equivalents
> +*   o suspend/resume hooks for sleep/hibernate (lightly tested)
> +*   o timesource adjust_callback hook
> +*   o Sent to lkml for review
> +* 2005-03-11:   A3
> +*   o periodic_hook (formerly interrupt_hook) now calle by softtimer
> +*   o yanked ntp_scale(), ntp adjustments are done in cyc2ns now
> +*   o sent to lkml for review
> +* 2005-04-29:   A4
> +*   o Improved the cyc2ns remainder handling
> +*   o Added getnstimeofday
> +*   o Cleanups from Nish Aravamudan
> +* 2005-05-12:   A5
> +*   o Added clock_was_set hooks
> +*   o Added suspend/resume sysfs hooks
> +*   o Minor code cleanups
> +*   o First attempt at docbook comments
> +* 2005-05-31:   B0
> +*  o Comment cleanups
> +*  o Rounding fixes

Please drop this useless revision history.

> +nsec_t get_lowres_timestamp(void)
> +{
> +	nsec_t ret;
> +	unsigned long seq;
> +	do {
> +		seq = read_seqbegin(&system_time_lock);
> +
> +		/* quickly grab system_time*/

Redundant comment.

> +nsec_t get_lowres_timeofday(void)
> +{
> +	nsec_t ret;
> +	unsigned long seq;
> +	do {
> +		seq = read_seqbegin(&system_time_lock);
> +
> +		/* quickly calculate low-res time of day */

Redundant comment.

> +static inline nsec_t __monotonic_clock(void)
> +{
> +	nsec_t ret, ns_offset;
> +	cycle_t now, cycle_delta;
> +
> +	/* read timesource */

Redundant comment.

> +	now = read_timesource(timesource);
> +
> +	/* calculate the delta since the last timeofday_periodic_hook */

Ditto.

> +	cycle_delta = (now - offset_base) & timesource->mask;
> +
> +	/* convert to nanoseconds */

Ditto.

> +	ns_offset = cyc2ns(timesource, ntp_adj, cycle_delta);
> +
> +	/* add result to system time */

Ditto.

> +int do_adjtimex(struct timex *tx)
> +{
> + 	/* Check capabilities if we're trying to modify something */

Redundant comment.

> +	if (tx->modes && !capable(CAP_SYS_TIME))
> +		return -EPERM;
> +
> +	/* Note: We set tx->time first,
> +	 * because ntp_adjtimex uses it
> +	 */
> +	do_gettimeofday(&tx->time);
> +
> +	/* call out to NTP code */

Redundant comment.

> +static int timeofday_suspend_hook(struct sys_device *dev, u32 state)
> +{
> +	unsigned long flags;
> +
> +	write_seqlock_irqsave(&system_time_lock, flags);
> +
> +	/* Make sure time_suspend_state is sane */

Redundant comment.

> +	BUG_ON(time_suspend_state != TIME_RUNNING);
> +
> +	/* First off, save suspend start time
> +	 * then quickly call __monotonic_clock.
> +	 * These two calls hopefully occur quickly
> +	 * because the difference between reads will
> +	 * accumulate as time drift on resume.
> +	 */
> +	suspend_start = read_persistent_clock();
> +	system_time = __monotonic_clock();
> +
> +	/* switch states */

Redundant comment.

> +	time_suspend_state = TIME_SUSPENDED;
> +
> +	write_sequnlock_irqrestore(&system_time_lock, flags);
> +	return 0;
> +}
> +
> +
> +/**
> + * timeofday_resume_hook - Resumes the timeofday subsystem.
> + * @dev: unused
> + *
> + * This function resumes the timeofday subsystem
> + * from a previous call to timeofday_suspend_hook.
> + */
> +static int timeofday_resume_hook(struct sys_device *dev)
> +{
> +	nsec_t now, suspend_time;
> +	unsigned long flags;
> +
> +	write_seqlock_irqsave(&system_time_lock, flags);
> +
> +	/* Make sure time_suspend_state is sane */

Redundant comment.

> +	BUG_ON(time_suspend_state != TIME_SUSPENDED);
> +
> +	/* Read persistent clock to mark the end of
> +	 * the suspend interval then rebase the
> +	 * offset_base to current timesource value.
> +	 * Again, time between these two calls will
> +	 * not be accounted for and will show up as
> +	 * time drift.
> +	 */
> +	now = read_persistent_clock();
> +	offset_base = read_timesource(timesource);
> +
> +	/* calculate how long we were out for */

Ditto

> +	suspend_time = now - suspend_start;
> +
> +	/* update system_time */

Ditto

> +	system_time += suspend_time;
> +
> +	ntp_clear();
> +
> +	/* Set us back to running */

Ditto

> +	time_suspend_state = TIME_RUNNING;
> +
> +	/* finally, update legacy time values */

Ditto

> +	update_legacy_time_values();
> +
> +	write_sequnlock_irqrestore(&system_time_lock, flags);
> +
> +	/* signal posix-timers about time change */

Ditto

> +static void timeofday_periodic_hook(unsigned long unused)
> +{
> +	cycle_t now, cycle_delta;
> +	static u64 remainder;
> +	nsec_t ns, ns_ntp;
> +	long leapsecond;
> +	struct timesource_t* next;
> +	unsigned long flags;
> +	u64 tmp;
> +	int ppm;
> +
> +	write_seqlock_irqsave(&system_time_lock, flags);
> +
> +	/* read time source & calc time since last call*/
> +	now = read_timesource(timesource);

Redundant comment.

> +	cycle_delta = (now - offset_base) & timesource->mask;
> +
> +	/* convert cycles to ntp adjusted ns and save remainder */

ditto

> +	ns_ntp = cyc2ns_rem(timesource, ntp_adj, cycle_delta, &remainder);
> +
> +	/* convert cycles to raw ns for ntp advance */

ditto

> +	ns = cyc2ns(timesource, 0, cycle_delta);
> +
> +#if TIME_DBG
> +	static int dbg=0;
> +	if(!(dbg++%TIME_DBG_FREQ)){
> +		printk(KERN_INFO "now: %lluc - then: %lluc = delta: %lluc -> %llu ns + %llu shift_ns (ntp_adj: %i)\n",
> +			(unsigned long long)now, (unsigned long long)offset_base,
> +			(unsigned long long)cycle_delta, (unsigned long long)ns,
> +			(unsigned long long)remainder, ntp_adj);
> +	}
> +}
> +#endif
> +
> +	/* update system_time */

ditto

> +	system_time += ns_ntp;
> +
> +	/* reset the offset_base */

ditto

> +	offset_base = now;
> +
> +	/* advance the ntp state machine by ns interval*/

ditto

> +	ppm = ntp_advance(ns);
> +
> +	/* do ntp leap second processing*/

ditto

> +	leapsecond = ntp_leapsecond(ns_to_timespec(system_time+wall_time_offset));
> +	wall_time_offset += leapsecond * NSEC_PER_SEC;
> +
> +	/* sync the persistent clock */

ditto

> +	if (!(get_ntp_status() & STA_UNSYNC))
> +		sync_persistent_clock(ns_to_timespec(system_time + wall_time_offset));
> +
> +	/* if necessary, switch timesources */

ditto

> +	next = get_next_timesource();
> +	if (next != timesource) {
> +		/* immediately set new offset_base */

ditto

> +		offset_base = read_timesource(next);
> +		/* swap timesources */

ditto

> +		timesource = next;
> +		printk(KERN_INFO "Time: %s timesource has been installed.\n",
> +					timesource->name);
> +		ntp_clear();
> +		ntp_adj = 0;
> +		remainder = 0;
> +	}
> +
> +	/* now is a safe time, so allow timesource to adjust
> +	 * itself (for example: to make cpufreq changes).
> +	 */
> +	if(timesource->update_callback)
> +		timesource->update_callback();
> +
> +
> +	/* Convert the signed ppm to timesource multiplier adjustment */

ditto

> +	tmp = abs(ppm);


tmp wants better name

> +	tmp = tmp * timesource->mult;
> +	tmp += 1000000/2; /* round for div*/
> +	do_div(tmp, 1000000);
> +	if (ppm < 0)
> +		ntp_adj = -(int)tmp;
> +	else
> +		ntp_adj = (int)tmp;
> +
> +	/* sync legacy values */

redundant comment

> +	update_legacy_time_values();
> +
> +	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
> +							timesource, ntp_adj);
> +
> +	write_sequnlock_irqrestore(&system_time_lock, flags);
> +
> +	/* XXX - Do we need to call clock_was_set() here? */
> +
> +	/* Set us up to go off on the next interval */
> +	mod_timer(&timeofday_timer,
> +				jiffies + msecs_to_jiffies(PERIODIC_INTERVAL_MS));
> +}
> +
> +
> +/**
> + * timeofday_init - Initializes time variables
> + *
> + */
> +void __init timeofday_init(void)
> +{
> +	unsigned long flags;
> +#if TIME_DBG
> +	printk(KERN_INFO "timeofday_init: Starting up!\n");
> +#endif
> +	write_seqlock_irqsave(&system_time_lock, flags);
> +
> +	/* initialize the timesource variable */

redundant comment

> +	timesource = get_next_timesource();
> +
> +	/* clear and initialize offsets*/

ditto

> +	offset_base = read_timesource(timesource);
> +	wall_time_offset = read_persistent_clock();
> +
> +	/* clear NTP scaling factor & state machine */

ditto

> +	ntp_adj = 0;
> +	ntp_clear();
> +
> +	arch_update_vsyscall_gtod(system_time + wall_time_offset, offset_base,
> +							timesource, ntp_adj);
> +
> +	/* initialize legacy time values */

ditto

> +	update_legacy_time_values();
> +
> +	write_sequnlock_irqrestore(&system_time_lock, flags);
> +
> +	/* Install timeofday_periodic_hook timer */

ditto

> Index: kernel/timesource.c
> ===================================================================
> --- /dev/null  (tree:9b72b650285720c17d0aa0a3795c30fe492700b3)
> +++ 00e808a96ae388482e12d64053b45f880799cb67/kernel/timesource.c  (mode:100644)
> @@ -0,0 +1,253 @@
> +/*********************************************************************
> +* linux/kernel/timesource.c
> +*
> +* This file contains the functions which manage timesource drivers.
> +*
> +* Revision History:
> +* 2004-12-07:   A1
> +*   o Rework of timesource structure
> +*   o Sent to lkml for review
> +* 2005-04-29:   A4
> +*   o Keep track of all registered timesources
> +*   o Add sysfs interface for overriding default selection
> +* 2005-05-12:   A5
> +*   o Add boot-time timesource= option for timesource overrides

Please drop this useless revision history.

> +static struct timesource_t* select_timesource(void)
> +{
> +	struct timesource_t* best = timesource_list[0];
> +	int i;
> +
> +	for (i=0; i < timesource_list_counter; i++) {
> +		/* Check for override */

Redundant comment.

> +		if ((override_name[0] != 0) &&
> +			(strlen(override_name)
> +				== strlen(timesource_list[i]->name)) &&
> +			(!strncmp(timesource_list[i]->name, override_name,
> +				 strlen(override_name)))) {
> +			best = timesource_list[i];
> +			break;
> +		}
> +		/* Pick the highest priority */

ditto

> +		if (timesource_list[i]->priority > best->priority)
> +		 	best = timesource_list[i];
> +	}
> +	return best;
> +}
> +
> +/**
> + * register_timesource - Used to install new timesources
> + * @t: timesource to be registered
> + *
> + */
> +void register_timesource(struct timesource_t* t)
> +{
> +	char* error_msg = 0;
> +	int i;
> +	write_seqlock(&timesource_lock);
> +
> +	/* check if timesource is already registered */

Redundant comment.

> +	for (i=0; i < timesource_list_counter; i++)
> +		if (!strncmp(timesource_list[i]->name, t->name, strlen(t->name))){
> +			error_msg = "Already registered!";
> +			break;
> +		}
> +
> +	/* check that the list isn't full */

ditto

> +	if (timesource_list_counter >= MAX_TIMESOURCES)
> +		error_msg = "Too many timesources!";
> +
> +	if(!error_msg)
> +		timesource_list[timesource_list_counter++] = t;
> +	else
> +		printk("register_timesource: Cannot register %s. %s\n",
> +					t->name, error_msg);
> +
> +	/* select next timesource */

ditto

> +	next_timesource = select_timesource();
> +
> +	write_sequnlock(&timesource_lock);
> +}
> +EXPORT_SYMBOL(register_timesource);
> +
> +/**
> + * sysfs_show_timesources - sysfs interface for listing timesource
> + * @dev: unused
> + * @buf: char buffer to be filled with timesource list
> + *
> + * Provides sysfs interface for listing registered timesources
> + */
> +static ssize_t sysfs_show_timesources(struct sys_device *dev, char *buf)
> +{
> +	int i;
> +	char* curr = buf;
> +	write_seqlock(&timesource_lock);
> +	for(i=0; i < timesource_list_counter; i++) {
> +		/* Mark current timesource w/ a star */

ditto

> +		if (timesource_list[i] == curr_timesource)
> +			curr += sprintf(curr, "*");
> +		curr += sprintf(curr, "%s ",timesource_list[i]->name);
> +	}
> +	write_sequnlock(&timesource_lock);
> +
> +	curr += sprintf(curr, "\n");
> +	return curr - buf;
> +}
> +
> +/**
> + * sysfs_override_timesource - interface for manually overriding timesource
> + * @dev: unused
> + * @buf: name of override timesource
> + *
> + *
> + *     Takes input from sysfs interface for manually overriding
> + *     the default timesource selction
> + */
> +static ssize_t sysfs_override_timesource(struct sys_device *dev,
> +			const char *buf, size_t count)
> +{
> +	/* check to avoid underflow later */
> +	if (strlen(buf) == 0)
> +		return count;
> +
> +	write_seqlock(&timesource_lock);
> +
> +	/* copy the name given */

redundant comment

> +	strncpy(override_name, buf, strlen(buf)-1);
> +	override_name[strlen(buf)-1] = 0;
> +
> +	/* see if we can find it */

ditto
