Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262280AbSI1Rcm>; Sat, 28 Sep 2002 13:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbSI1Rcl>; Sat, 28 Sep 2002 13:32:41 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:45053 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262280AbSI1R25>;
	Sat, 28 Sep 2002 13:28:57 -0400
Message-ID: <3D95E798.EDB241DD@mvista.com>
Date: Sat, 28 Sep 2002 10:32:08 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "george@mvista.com" <george@mvista.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH 6/6] High-res-timers part 6 (support-man) take 2
Content-Type: multipart/mixed;
 boundary="------------4B780845C44A4B93B94E427F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------4B780845C44A4B93B94E427F
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The 4th, 5th, and 6th parts are support code and not really
part of the kernel.

This part contains man pages for the new system calls.

The whole of this patch will create and populate the
Documentation/high-res-timers/man directory.  A make file is
included to install the man pages.

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
--------------4B780845C44A4B93B94E427F
Content-Type: text/plain; charset=us-ascii;
 name="hrtimers-man-2.5.36-1.0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimers-man-2.5.36-1.0.patch"

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/Makefile linux/Documentation/high-res-timers/man/Makefile
--- linux-2.5.36-kb/Documentation/high-res-timers/man/Makefile	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/Makefile	Fri Sep 27 10:50:58 2002
@@ -0,0 +1,45 @@
+# Makefile: install high-res-timers man pages
+#
+# We attempt to find the "correct" directory for the man pages as follows:
+
+# If the enviroment variable MANPATH is defined and not null, use the first
+# entry in it.
+
+# Otherwise, if /etc/man.config exists, use the first MANPATH entry in it.
+# If both of these fail, print an error and quit.
+
+# If you want to override this to put the pages in directory foo use:
+# make MANPATH=foo
+
+# If you want to force it to use the /etc/man.config and you have a MANPATH use:
+# make MANPATH=
+
+# You may need to be root to run this make.
+
+all: man
+MANCONF = /etc/man.config
+MANPAGES = clock_getcpuclockid.3 clock_getres.3 clock_gettime.3 \
+	   clock_nanosleep.3 clock_settime.3 pthread_getcpuclockid.3 \
+	   timer_create.3 timer_delete.3 timer_getoverrun.3 \
+	   timer_gettime.3 timer_settime.3
+
+man: $(MANPAGES)
+	@ENVMANPATH=`echo $$MANPATH | sed -e "s/:.*//"` ;\
+	if [ "$$ENVMANPATH" = "" ] ; then \
+		if [ -e $(MANCONF) ] ; then \
+			MANDIR=`grep -w '^ *MANPATH' $(MANCONF) |sed -e 2,50d -e "s/ *MANPATH[^/]*//"` ; \
+		else \
+			MANDIR="" ; \
+		fi \
+	else \
+		MANDIR=$$ENVMANPATH ; \
+	fi  ; \
+	if [ -d $$MANDIR ] ; then \
+		echo "Installing POSIX timers man pages to >$$MANDIR/< ..."; \
+		cp $(MANPAGES) $$MANDIR && \
+		cd $$MANDIR && \
+		chmod 644 $(MANPAGES) && \
+		gzip -9 $(MANPAGES); \
+	else \
+		echo "error: directory >$$MANDIR< does not exist, create or use make MANPATH=<dir>!"; \
+	fi
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/clock_getcpuclockid.3 linux/Documentation/high-res-timers/man/clock_getcpuclockid.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/clock_getcpuclockid.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/clock_getcpuclockid.3	Fri Sep 27 10:56:32 2002
@@ -0,0 +1,74 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH CLOCK_GETCPUCLOCKID 3  2002-03-14 "Linux Manpage" "Linux Manpage"
+.SH NAME
+clock_getcpuclockid \- retrieve the current process's CPU-time clock
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int clock_getcpuclockid(pid_t " pid ", clockid_t *" clock_id ");"
+.SH DESCRIPTION
+.B clock_getcpuclockid
+retrieves the clock value of the current process's CPU-time clock.
+The clock value is stored in
+.IR clock_id .
+The process ID specified by
+.IR pid
+must equal the current process.
+.SH "RETURN VALUE"
+On success,
+.BR clock_getcpuclockid
+returns the value 0 and places the retrieved clock value in
+.IR clock_id .
+.PP
+On failure,
+.BR clock_getcpuclockid
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR ENOSYS
+The function is not supported on this implementation.
+.TP
+.BR EPERM
+The requesting process is not
+.IR pid .
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_nanosleep (3),
+.BR pthread_getcpuclockid (3),
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_gettime (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/clock_getres.3 linux/Documentation/high-res-timers/man/clock_getres.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/clock_getres.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/clock_getres.3	Fri Sep 27 10:57:14 2002
@@ -0,0 +1,95 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH CLOCK_GETRES 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+clock_getres \- get a clock's resolution
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int clock_getres(clockid_t " which_clock ", struct timespec *" resolution ");"
+.SH DESCRIPTION
+.B clock_getres
+retrieves the resolution (granularity) of the clock specified by
+.IR which_clock .
+The retrieved value is placed in the (non-NULL)
+.IR timespec
+structure pointed to by
+.IR resolution .
+.PP
+The resolution returned by this function is the resolution used in timer
+and 
+.BR clock_nanosleep(3) 
+calls using the same clock.  
+.BR Clock_gettime(3)
+, on the other hand, will always return the best resolution it can given
+the clock
+source.	 This resolution is usually better than one microsecond, except
+for 
+.BR CLOCK_PROCESS_CPUTIME_ID 
+and 
+.BR CLOCK_THREAD_CPUTIME_ID 
+which will be the same as returned here.
+.PP
+The clock resolutions are system-dependent and can not be set by the user.
+.PP
+For a listing of valid clocks, see
+.BR clock_gettime (3).
+.SH "RETURN VALUE"
+On success,
+.BR clock_getres
+returns the value 0 and places the requested resolution in the specified
+structure.
+.PP
+On failure,
+.BR clock_getres
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR EINVAL
+The clock specified by
+.IR which_clock
+is invalid.
+.TP
+.BR ENOSYS
+The function is not supported on this implementation.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getcpuclockid (3),
+.BR clock_gettime (3),
+.BR clock_settime (3),
+.BR clock_nanosleep (3),
+.BR pthread_getcpuclockid (3),
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_gettime (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/clock_gettime.3 linux/Documentation/high-res-timers/man/clock_gettime.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/clock_gettime.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/clock_gettime.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,130 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH CLOCK_GETTIME 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+clock_gettime \- get the current value for the specified clock
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int clock_gettime(clockid_t " which_clock ", struct timespec *" setting ");"
+.SH DESCRIPTION
+.B clock_gettime
+retrieves the current value for the clock specified by
+.IR which_clock .
+The retrieved value is placed in the
+.IR timespec
+structure pointed to by
+.IR setting .
+Depending on the resolution of the specified clock, it may be possible to
+retrieve the same value with consecutive calls to
+.BR clock_gettime (3).
+.PP
+To set the current time value of a given clock, see
+.BR clock_settime (3).
+To retrieve the resolution of a given clock, see
+.BR clock_getres (3).
+.PP
+.SS Clock types
+The
+.I which_clock
+argument specifies the clock type.  The type used determines the behavior and
+properties of the clock.  Valid clock types are:
+.TP
+.BR CLOCK_REALTIME
+Wall clock.  The time is expressed in seconds and nanoseconds since the UNIX
+Epoch (00:00 1 Jan 1970 UTC).  The POSIX standard dictates the resolution of
+this clock not be worse than 100Hz (10ms). In Linux, the resolution is 1/HZ
+(usually 10ms on 32-bit architectures and 1ms on 64-bit architectures).  As
+this clock is based on wall time, either the user or system can set it and thus
+it is not guaranteed to be monotonic.
+.TP
+.BR CLOCK_REALTIME_HR
+High-resolution version of
+.BR CLOCK_REALTIME.
+Resolution is architecture-dependent.
+.TP
+.BR CLOCK_MONOTONIC
+System uptime clock.  The time is expressed in seconds and nanoseconds since
+boot.  The resolution is again 1/HZ.  The clock is guaranteed to be monotonic.
+.TP
+.BR CLOCK_MONOTONIC_HR
+High-resolution version of
+.BR CLOCK_MONOTONIC .
+Resolution is architecture-dependent.
+.TP
+.BR CLOCK_PROCESS_CPUTIME_ID
+CPU-time clock of the calling process.  Time is measured in seconds and
+nanoseconds the current process has spent executing on the system.  The
+resolution is implementation-defined; in Linux it is 1/HZ.  Timers and
+clock_nanosleep calls on this clock are not supported.
+.TP
+.BR CLOCK_THREAD_CPUTIME_ID
+Like
+.BR CLOCK_PROCESS_CPUTIME_ID ,
+but for the current thread, not process.
+.PP
+The clocks
+.BR CLOCK_REALTIME_HR
+and
+.BR CLOCK_MONOTONIC_HR
+are present only if the kernel is configured with high-resolution timer
+support.
+.SH "RETURN VALUE"
+On success,
+.BR clock_gettime
+returns the value 0 and places the requested clock value in the specified
+structure.
+.PP
+On failure,
+.BR clock_gettime
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR EINVAL
+The clock specified by
+.IR which_clock
+is invalid.
+.TP
+.BR ENOSYS
+The function is not supported on this implementation.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getcpuclockid (3),
+.BR clock_getres (3),
+.BR clock_settime (3),
+.BR clock_nanosleep (3),
+.BR pthread_getcpuclockid (3),
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_gettime (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/clock_nanosleep.3 linux/Documentation/high-res-timers/man/clock_nanosleep.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/clock_nanosleep.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/clock_nanosleep.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,155 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH CLOCK_NANOSLEEP 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+clock_nanosleep \- high-resolution sleep with a specified clock
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int clock_nanosleep(clockid_t " which_clock ", int " flags ", const struct timespec *" rqtp ", struct timespec *" rmtp ");"
+.SH DESCRIPTION
+.B clock_nanosleep
+suspends execution of the currently running thread until the time specified by
+.IR rqtp
+has elapsed or until the thread receives a signal.
+.PP
+The default behavior is to interpret the specified sleep time as relative
+to the current time.
+The
+.BR TIMER_ABSTIME
+flag specified in
+.IR flags
+will modify this behavior to make the time specified by
+.IR rqtp
+absolute with respect to the clock value specified by
+.IR which_clock .
+.PP
+If the
+.BR TIMER_ABSTIME
+flag is specified and the time value specified by
+.IR rqtp
+is less than or equal to the current time value of the specified clock (or
+the clock's value is changed to such a time), the function will return
+immediately.  Further, the time slept is affected by any changes to the
+clock after the call to
+.BR clock_nanosleep (3).
+That is, the call will complete when the actual time is equal or greater
+than the requested time no matter how the clock reaches that time, via
+setting or actual passage of time or some combination of these.  The
+only clock that can be set is 
+.BR CLOCK_REALTIME 
+and 
+.BR CLOCK_REALTIME_HR 
+which are, in fact the same clock with differing resolutions.  Thus 
+.BR clock_settime(3) 
+on either of these clocks changes both.  This clock is also set by the
+.BR settimeofday(3) 
+call and by the syncronization code 
+.BR adjtimex(2)
+call. 
+.PP
+If
+.BR TIMER_ABSTIME
+is not specified, the
+.IR timespec
+structure pointed to by
+.IR rmtp
+is updated to contain the amount of time remaining in the interval (i.e., the
+requested time minus the time actually slept).  If
+.IR rmtp
+is NULL, the remaining time is not set.  The
+.IR rmtp
+value is not set in the case of an absolute time value.
+.PP
+The time slept may be longer than requested as the specified time value is
+rounded up to an integer multiple of the clock resolution, or due to scheduling
+and other system activity.  Except for the case of interruption by a signal,
+the suspension time is never less than requested.
+.PP
+The
+.BR CLOCK_PROCESS_CPUTIME_ID
+and
+.BR CLOCK_THREAD_CPUTIME_ID
+clocks are not supported by
+.BR clock_nanosleep (3).
+.PP
+Like
+.BR nanosleep (2),
+but unlike
+.BR sleep (3) ,
+.BR clock_nanosleep (3)
+does not affect signals.
+.PP
+For a listing of valid clocks, see
+.BR clock_gettime (3).
+.SH "RETURN VALUE"
+On success,
+.BR clock_nanosleep
+returns the value 0 after at least the specified time has elapsed.
+.PP
+On failure,
+.BR clock_nanosleep
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR EINTR
+The call was interrupted by a signal.
+.TP
+.BR EINVAL
+The clock specified by
+.IR which_clock
+is invalid, the
+.IR rqtp
+argument specified a nanosecond value less than zero or greater than or equal
+to 1,000 million, or
+.IR TIMER_ABSTIME
+is specified in
+.IR flags
+and the value specified by
+.IR rqtp
+is outside the range of the clock specified by
+.IR which_clock, 
+or the resulting sleep time is too large for the
+system. Values "too large" are those that can not be converted to
+"jiffies" from "now" with a resulting value less than MAX_LONG.
+.TP
+.BR ENOSYS
+The function is not supported on this implementation.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_settime (3),
+.BR nanosleep (2),
+.BR sleep (3),
+.BR usleep (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/clock_settime.3 linux/Documentation/high-res-timers/man/clock_settime.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/clock_settime.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/clock_settime.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,100 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH CLOCK_SETTIME 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+clock_settime \- set a clock's time value
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int clock_settime(clockid_t " which_clock ", const struct timespec *" setting ");"
+.SH DESCRIPTION
+.B clock_settime
+sets the clock specified by
+.IR which_clock
+to the time value specified by
+.IR setting .
+Time values that are not integer multiples of the clock resolution are
+truncated down.
+.PP
+The calling process must possess the appropriate capability (typically
+.BR CAP_SYS_TIME ).
+.PP
+By definition, the
+.BR CLOCK_MONOTONIC
+and
+.BR CLOCK_MONOTONIC_HR
+clocks can not be set.
+.PP
+To retrieve the current time value of a given clock, see
+.BR clock_gettime (3).
+To retrieve the resolution of a given clock, see
+.BR clock_getres (3).
+.PP
+For a listing of valid clocks, see
+.BR clock_gettime (3).
+.SH "RETURN VALUE"
+On success,
+.BR clock_settime
+returns the value 0 and sets the specified clock to the specified time value.
+.PP
+On failure,
+.BR clock_settime
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR EINVAL
+The clock specified by
+.IR which_clock
+is invalid, the time value specified by
+.IR setting
+is outside the range for the given clock, or the nanosecond value specified by
+.IR setting
+is less than zero or greater than or equal to 1000 million.
+.TP
+.BR ENOSYS
+The function is not supported on this implementation.
+.TP
+.BR EPERM
+The requesting process does not have the requisite privilege to set the
+specified clock.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getcpuclockid (3),
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_nanosleep (3),
+.BR pthread_getcpuclockid (3),
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_gettime (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/pthread_getcpuclockid.3 linux/Documentation/high-res-timers/man/pthread_getcpuclockid.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/pthread_getcpuclockid.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/pthread_getcpuclockid.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,74 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH PTHREAD_GETCPUCLOCKID 3  2002-03-14 "Linux Manpage" "Linux Manpage"
+.SH NAME
+pthread_getcpuclockid \- retrieve the current thread's CPU-time clock
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int pthread_getcpuclockid(pthread_t " thread_id ", clockid_t *" clock_id ");"
+.SH DESCRIPTION
+.B pthread_getcpuclockid
+retrieves the clock value of the CPU-time clock of the current thread. The
+clock value is stored in
+.IR clock_id .
+The pthread ID specified by
+.IR pthread_id
+must equal the current thread.
+.SH "RETURN VALUE"
+On success,
+.BR pthread_getcpuclockid
+returns the value 0 and places the retrieved clock value in
+.IR clock_id .
+.PP
+On failure,
+.BR pthread_getcpuclockid
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR ENOSYS
+The function is not supported on this implementation.
+.TP
+.BR EPERM
+The requesting thread is not
+.IR pthread_id .
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getcpuclockid (3),
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_nanosleep (3),
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_gettime (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/timer_create.3 linux/Documentation/high-res-timers/man/timer_create.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/timer_create.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/timer_create.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,173 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH TIMER_CREATE 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+timer_create \- create a POSIX timer
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.br
+.B #include <signal.h>
+.sp
+.BI "int timer_create(clockid_t " which_clock ", struct sigevent *" timer_event_spec ", timer_t *" created_timer_id ");"
+.SH DESCRIPTION
+.B timer_create
+creates an interval timer based on the POSIX 1003.1b standard using the clock
+type specified by
+.IR which_clock .
+The timer ID is stored in the
+.IR timer_t
+value pointed to by
+.IR created_timer_id .
+The timer is started by
+.BR timer_settime (3).
+.PP
+If
+.IR timer_event_spec
+is non-NULL, it specifies the behavior on timer expiration.  If the
+.IR sigev_notify
+member of
+.IR timer_event_spec
+is 
+.BR SIGEV_SIGNAL
+then the signal specified by
+.IR sigev_signo
+is sent to the process on expiration.
+.PP
+If the value is
+.BR SIGEV_THREAD_ID
+then the
+.BR sigev_notify_thread_id
+member of
+.BR timer_event_spec
+should contain the
+.IR pthread_t
+id of the thread that is to receive the signal.
+.PP
+If the value is
+.BR SIGEV_THREAD
+then the specified
+.IR sigev_notify_function
+is created in a new thread with
+.IR sigev_value
+as the argument.
+.PP
+If the value is
+.BR SIGEV_NONE
+then no signal is sent.
+.PP
+.BR SIGEV_THREAD_ID
+and
+.BR SIGEV_SIGNAL
+are compatible and may be ORed together.
+.PP
+If
+.IR timer_event_spec
+is
+.BR NULL ,
+.BR SIGALRM
+is sent to the process upon timer expiration with the value of the timer ID,
+.IR timer_id .
+.PP
+The maximum number of timers is a system-wide value, set at kernel configure
+time, which is generally quite high.
+.PP
+Each timer is owned by a specific thread.  The owning thread is either the
+calling thread or the thread specified by
+.BR SIGEV_THREAD_ID .
+The owning thread receives the signal on timer expiration.  If the owning
+thread exits all of its timers are disabled and deleted.  Any thread in a
+process, however, may make calls on the timer.  Timers are not inherited by
+a child process across a
+.BR fork (2)
+and are disabled and deleted by a call to one of the
+.BR exec
+functions.
+.PP
+For a listing of valid clocks, see
+.BR clock_gettime (3).
+Note 
+.BR CLOCK_PROCESS_CPUTIME_ID
+and
+.BR CLOCK_THREAD_CPUTIME_ID
+are not supported by
+.BR timer_create (3).
+.PP
+.SS Thread support
+Note
+.BR SIGEV_THREAD_ID
+support requires thread groups.  Currently the linuxthreads package does
+not use thread groups.  NG-threads, based on GNU-pth, does use thread
+groups and is compatible.
+.SH "RETURN VALUE"
+On success,
+.BR timer_create
+returns a value of 0 and the timer ID of the new timer is placed in
+.IR created_timer_id .
+.PP
+On failure,
+.BR timer_create
+returns a value of -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EAGAIN
+The system is incapable of allocating a new timer or signal.  Possible
+reasons include the number of timers exceeding the system wide maximum
+timers set at system configure time or insufficient resources.
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR EINVAL
+The specified clock ID,
+.BR sigev_signo ,
+.BR sigev_notify ,
+or
+.BR SIGEV_THREAD_ID
+value is invalid.
+.TP
+.BR ENOSYS
+The
+.BR timer_create (3)
+function is not supported by the system.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.PP
+The
+.BR SIGEV_THREAD_ID
+value is an extension to this standard intended to overcome the lack of process
+signals in Linux.
+.SH "SEE ALSO"
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_settime (3),
+.BR clock_nanosleep (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_gettime (3),
+.BR timer_getoverrun (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/timer_delete.3 linux/Documentation/high-res-timers/man/timer_delete.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/timer_delete.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/timer_delete.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,77 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH TIMER_DELETE 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+timer_delete \- delete a POSIX timer
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int timer_delete(timer_t " timer_id ");"
+.SH DESCRIPTION
+.B timer_delete
+deletes the POSIX timer specified by
+.IR timer_id .
+If the timer is already started, it will be disabled and no signals or
+actions assigned to
+.IR timer_id
+will be delivered or executed.  A pending signal from an expired timer,
+however, will not be removed by this call.
+.PP
+Use
+.BR timer_create (3)
+to create a timer and
+.BR timer_settime (3)
+to start a timer.
+.SH "RETURN VALUE"
+On success,
+.BR timer_delete
+returns the value 0 and the timer specified by
+.IR timer_id
+is deleted.
+.PP
+On failure,
+.BR timer_delete
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EINVAL
+The timer specified by
+.IR timer_id
+is invalid.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_settime (3),
+.BR clock_nanosleep (3),
+.BR timer_create (3),
+.BR timer_settime (3),
+.BR timer_gettime (3),
+.BR timer_getoverrun (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/timer_getoverrun.3 linux/Documentation/high-res-timers/man/timer_getoverrun.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/timer_getoverrun.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/timer_getoverrun.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,83 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH TIMER_GETOVERRUN 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+timer_getoverrun \- get a POSIX timer's overrun count
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int timer_getoverrun(timer_t " timer_id ");"
+.SH DESCRIPTION
+.B timer_getoverrun
+returns the current overrun count for the timer specified by
+.IR timer_id .
+The overrun count is the number of timer expirations not delivered to the
+process, since the last notification, due to an already pending signal from
+.IR timer_id .
+Overruns may occur because a timer can only post one signal per process at a
+time.
+.PP
+The maximum overrun value is
+.BR INT_MAX .
+.PP
+The Linux timer implementation also allows retrieving the overrun count from
+the
+.IR si_overrun
+member of the
+.IR siginfo
+structure (see
+.BR siginfo.h ).
+This is an extension to the POSIX standard that avoids the system call overhead.
+.SH "RETURN VALUE"
+On success,
+.BR timer_getoverrun
+returns the overrun count for the given
+.IR timer_id .
+If the return value is 0, there were no overruns since the last notification.
+.PP
+On failure,
+.BR timer_getoverrun
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EINVAL
+The timer specified by
+.IR timer_id
+is invalid.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_settime (3),
+.BR clock_nanosleep (3),
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_gettime (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/timer_gettime.3 linux/Documentation/high-res-timers/man/timer_gettime.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/timer_gettime.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/timer_gettime.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,77 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH TIMER_GETTIME 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+timer_gettime \- get the time remaining before a POSIX timer expires
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <timer.h>
+.sp
+.BI "int timer_gettime(timer_t " timer_id ", struct itimerspec *" setting ");"
+.SH DESCRIPTION
+.B timer_gettime
+gets both the time remaining before the timer specified by
+.IR timer_id
+expires and the interval between timer expirations and stores the results in
+.IR setting .
+The
+.IR it_value
+field of 
+.IR setting
+contains the time remaining until expiration and the
+.IR it_interval
+field contains the timer interval.
+.PP
+If
+.IR it_value
+contains zero after a successful return, then the timer is not active.  If
+.IR it_interval
+contains zero after a successful return, then the timer is not periodic.
+.SH "RETURN VALUE"
+On success,
+.BR timer_gettime
+returns the value 0 and
+.IR setting
+contains the retrieved values.
+.PP
+On failure,
+.BR timer_gettime
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+The address specified by
+.IR setting
+is outside the address range of the calling process.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_settime (3),
+.BR timer_getoverrun (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.36-kb/Documentation/high-res-timers/man/timer_settime.3 linux/Documentation/high-res-timers/man/timer_settime.3
--- linux-2.5.36-kb/Documentation/high-res-timers/man/timer_settime.3	Wed Dec 31 16:00:00 1969
+++ linux/Documentation/high-res-timers/man/timer_settime.3	Wed Sep 18 17:39:54 2002
@@ -0,0 +1,128 @@
+.\" Copyright (C) 2002 Robert Love (rml@tech9.net), MontaVista Software
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation, version 2.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111,
+.\" USA.
+.\"
+.TH TIMER_SETTIME 3  2002-03-14 "Linux Manpage" "Linux Programmer's Manual"
+.SH NAME
+timer_settime \- set the expiration time for a POSIX timer
+.SH SYNOPSIS
+.B cc [ flag ... ] file -lrt [ library ... ]
+.sp
+.B #include <time.h>
+.sp
+.BI "int timer_settime(timer_t " timer_id ", int " flags ", const struct itimerspec *" new_setting ", const struct itimerspec *" old_setting ");"
+.SH DESCRIPTION
+.B timer_settime
+sets the expiration time for the timer specified by
+.IR timer_id ,
+thus marking it active.  The
+.IR it_value
+field of
+.IR new_value
+specifies the expiration time in nanoseconds.  If the timer is already set
+then it is reset to the new value specified by
+.IR it_value .
+If
+.IR it_value
+is zero, the timer is disabled.
+.PP
+The default behavior is to interpret the specified expiration time as relative
+to the current time as of the call.  The
+.BR TIMER_ABSTIME
+flag specified in
+.IR flags
+will modify this behavior to make the value specified by
+.IR it_value
+absolute with respect to the clock associated with
+.IR timer_id .
+Thus, the timer will expire when the clock reaches the value specified by
+.IR it_value .
+If
+.BR TIMER_ABSTIME
+specifies a value which has already elapsed, the call will succeed and the
+timer will immediately expire.
+.PP
+The interval at which the timer will subsequently expire is specified by
+.IR it_interval .
+If
+.IR it_interval
+is set to zero, the timer will expire only once, as specified by
+.IR it_value .
+In order to prevent timer intervals from overloading the system, the system
+prevents setting
+.IR it_interval
+below a minimum value.  This minimum value is determined by an overload test,
+the results of which are printed on boot.
+.PP
+If
+.IR old_value
+is non-NULL, the previous time remaining before expiration is stored in the
+.IR itimerspec
+structure pointed to by
+.IR old_value .
+.PP
+Changes to the clock value (e.g. via
+.BR clock_settime (3))
+will not affect any timers.
+.SH "RETURN VALUE"
+On success,
+.BR timer_settime
+returns the value 0 and the timer specified by
+.IR timer_id
+is set as specified by
+.IR new_value .
+If
+.IR old_value
+is non-NULL, it contains the previous time remaining before expiration.
+.PP
+On failure,
+.BR timer_settime
+returns the value -1 and
+.IR errno
+is set appropriately.
+.SH ERRORS
+.TP
+.BR EFAULT
+A specified memory address is outside the address range of the calling process.
+.TP
+.BR EINVAL
+.IR timer_id 
+is not a valid, owned (by the process) timer
+or
+.IR new_value 
+has a negative second or nano second value or the nano
+second value is greater than or equal to 1,000 million or the resulting expire time
+is too large for the
+system. Values "too large" are those that can not be converted to
+"jiffies" from "now" with a resulting value less than MAX_LONG.
+.SH "CONFORMING TO"
+POSIX 1003.1b (formerly POSIX.4) as ammended by POSIX 1003.1j-2000.
+.SH "SEE ALSO"
+.BR clock_getres (3),
+.BR clock_gettime (3),
+.BR clock_settime (3),
+.BR clock_nanosleep (3),
+.BR timer_create (3),
+.BR timer_delete (3),
+.BR timer_gettime (3),
+.BR timer_getoverrun (3)
+.sp
+.I IEEE 1003.1b-1993
+(POSIX.1b standard, formerly POSIX.4), Section 14 (Clocks and Timers).

--------------4B780845C44A4B93B94E427F--

