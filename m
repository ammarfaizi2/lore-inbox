Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752018AbWCBWAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbWCBWAM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWCBWAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:00:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:51346 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752002AbWCBWAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:00:09 -0500
Date: Thu, 2 Mar 2006 23:00:08 +0100 (MET)
From: "Michael Kerrisk" <mtk-manpages@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: michael.kerrisk@gmx.net
MIME-Version: 1.0
References: <18708.1140632121@www052.gmx.net>
Subject: man-pages-2.25 is released
X-Priority: 3 (Normal)
X-Authenticated: #24879014
Message-ID: <6194.1141336808@www004.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.25, which can be found at the 
location listed in the .sig.

This release includes the following new manual pages:

mq_close.3
mq_getattr.3
mq_notify.3
mq_open.3
mq_receive.3
mq_send.3
mq_unlink.3
    mtk
        New pages describing POSIX message queue API.

mq_overview.7
    mtk
        New page giving overview of the POSIX message queue API.

posix_fallocate.3
    mtk, after a suggestion by James Peach
        New page describing posix_fallocate().
    

There are a number of known places where things need
to be fixed in the manual pages.  I have included a partial
list below.  Any help on these points would be most welcome.

==========
fcntl.2
     FIXME According to SUSv3, O_SYNC should also be modifiable
     via fcntl(2), but currently Linux does not permit this
     See http://bugzilla.kernel.org/show_bug.cgi?id=5994

     FIXME The statement that O_ASYNC can be used in open() does not
     match reality; setting O_ASYNC via open() does not seem to be
     effective.
     See http://bugzilla.kernel.org/show_bug.cgi?id=5993

     FIXME Dec 04: some limited testing on alpha and ia64 seems to
     indicate that ANY negative PGID value will cause F_GETOWN
     to misinterpret the return as an error. Some other architectures
     seem to have the same range check as x86.  Must document
     the reality on other architectures -- MTK

==========
mount.2
     FIXME 2.6.15-rc1 has MS_UNBINDABLE, MS_PRIVATE, MS_SHARED, MS_SLAVE
     These need to be documented on this page.
     See Documentation/sharedsubtree.txt

     FIXME: Say more about MS_MOVE

==========
open.2
     FIXME Check bugzilla report on open(O_ASYNC)
     See http://bugzilla.kernel.org/show_bug.cgi?id=5993

==========
prctl.2
     FIXME: The following (applicable only on IA-64) are not currently
     described: PR_SET_UNALIGN, PR_GET_UNALIGN, PR_SET_FPEMU, PR_GET_FPEMU

==========
ptrace.2
     FIXME The following are not documented:
     	PTRACE_SETOPTIONS (2.4.6)
    		plus associated flags:
    			PTRACE_O_TRACESYSGOOD (2.4.6)
    			PTRACE_O_TRACEFORK (2.5.46)
    			PTRACE_O_TRACEVFORK (2.5.46)
    			PTRACE_O_TRACECLONE (2.5.46)
    			PTRACE_O_TRACEEXEC (2.5.46)
    			PTRACE_O_TRACEVFORKDONE (2.5.60)
    			PTRACE_O_TRACEEXIT (2.5.60)
    	PTRACE_SETSIGINFO (2.3.99-pre6)
    	PTRACE_GETSIGINFO (2.3.99-pre6)
    	PTRACE_GETEVENTMSG (2.5.46)

==========
quotactl.2
     FIXME There is much that is missing and/or out of date in this page.
     As things stand the page more or less documents Linux 2.2 reality:

     Linux 2.2 has:

    	Q_GETQUOTA
    	Q_GETSTATS
    	Q_QUOTAOFF
    	Q_QUOTAON
    	Q_RSQUASH (not currently documented)
    	Q_SETQLIM
    	Q_SETQUOTA
    	Q_SETUSE
    	Q_SYNC

     Linux 2.4 has:
    	
    	Q_COMP_QUOTAOFF
    	Q_COMP_QUOTAON
    	Q_COMP_SYNC
    	Q_GETFMT
    	Q_GETINFO
    	Q_GETQUOTA
    	Q_QUOTAOFF
    	Q_QUOTAON
    	Q_SETINFO
    	Q_SETQUOTA
    	Q_SYNC
    	Q_V1_GETQUOTA Q_V1_GETSTATS Q_V1_RSQUASH Q_V1_SETQLIM
    	Q_V1_SETQUOTA Q_V1_SETUSE
    	Q_V2_GETINFO Q_V2_GETQUOTA Q_V2_SETFLAGS Q_V2_SETGRACE
    	Q_V2_SETINFO Q_V2_SETQUOTA Q_V2_SETUSE
    	Q_XGETQSTAT Q_XGETQUOTA Q_XQUOTAOFF Q_XQUOTAON Q_XQUOTARM
    	Q_XSETQLIM

     Linux 2.6.16 has:

    	Q_GETFMT
    	Q_GETINFO
    	Q_GETQUOTA
    	Q_QUOTAOFF
    	Q_QUOTAON
    	Q_SETINFO
    	Q_SETQUOTA
    	Q_SYNC
    	Q_XGETQSTAT
    	Q_XGETQUOTA
    	Q_XQUOTAOFF
    	Q_XQUOTAON
    	Q_XQUOTARM
    	Q_XQUOTASYNC
    	Q_XSETQLIM

==========
send.2
     FIXME? document MSG_PROXY (which went away in 2.3.15)

==========
shmget.2
     FIXME 2.6.15 adds SHM_NORESERVE; document it.

==========
shmop.2
     FIXME What does "failing attach at brk" mean?  (Is this phrase
     just junk?)

     FIXME A good explanation of the rationale for the existence
     of SHMLBA would be useful here

     FIXME That last sentence isn't true for all Linux
     architectures (i.e., SHMLBA != PAGE_SIZE for some architectures)
     -- MTK, Nov 04

==========
acct.5
     FIXME this page needs to say a lot more, including mentioning
    	Version 3 format process accounting on Linux.

==========
proc.5
     FIXME 2.6.14 has added /proc/PID/smaps (if CONFIG_MMU
     is enabled) and /proc/PID/numa_maps (if CONFIG_NUMA is
     enabled); they need to be documented.
     Info on smaps can be found in the patch-2.6.14-rc1 Changelog
     and in Documentation/filesystems/proc.txt
     Info on numa_maps can be found in the patch-2.6.14-rc1
     Changelog
     FIXME 2.6.13 seems to have /proc/vmcore implemented
     in the source code, but there is no option available under
     'make xconfig'; eventually this should be fixed, and then info
     from the patch-2.6.13 and change log could be used to write an
     entry in this man page.
     FIXME -- cross check against Documentation/filesystems/proc.txt
     to see what information could be imported from that file
     into this file.

     FIXME Describe /proc/[number]/loginuid
           Added in 2.6.11; updating requires CAP_AUDIT_CONTROL

     FIXME Describe /proc/[number]/oom_adj
           Added in 2.6.11; updating requires CAP_SYS_RESOURCE
           Mention OOM_DISABLE (-17)
     FIXME Describe /proc/[number]/oom_score
           Added in 2.6.11; read-only

     FIXME Describe /proc/[number]/seccomp
           Added in 2.6.12

     FIXME: Actually, the following does not seem to be quite
            right (at least in 2.6.12)

     FIXME 2.6.11 adds a further column "steal" (see
     fs/proc/proc_misc.c); this is not yet described...

     FIXME -- more should be said about /proc/zoneinfo

==========
capabilities.7
     FIXME Capabilities are actually per-thread.

     FIXME: CAP_KILL also an effect for threads + setting child
     termination signal to other than SIGCHLD; but what are
     the details?

     FIXME: CAP_SETUID also an effect in exec(); document this.

     FIXME 2.6.14-rc1: CAP_SYS_ADMIN:
    		/* Allow setting zone reclaim policy */

==========
ddp.7
     FIXME Add a section about multicasting

     FIXME document all errors. We should really fix the kernels to
     give more uniform error returns (ENOMEM vs ENOBUFS, EPERM vs
     EACCES etc.)

==========
icmp.7
     FIXME  better description needed

==========
ip.7
     FIXME As at 2.6.12, 14 Jun 2005, the following are undocumented:
    	ip_queue_maxlen
    	ip_conntrack_max

     FIXME: document ip_autoconfig

     FIXME Document the conf/*/* sysctls
     FIXME Document the route/* sysctls

     FIXME Add a discussion of multicasting

     FIXME document all errors.

==========
ipv6.7
     FIXME IPV6_CHECKSUM is not documented, and probably should be
     FIXME IPV6_JOIN_ANYCAST is not documented, and probably should be
     FIXME IPV6_LEAVE_ANYCAST is not documented, and probably should be
     FIXME IPV6_V6ONLY is not documented, and probably should be
     FIXME IPV6_RECVPKTINFO is not documented, and probably should be
     FIXME IPV6_2292PKTINFO is not documented, and probably should be
     FIXME there are probably many other IPV6_* socket options that
     should be documented

==========
locale.7
     FIXME glibc 2.2.2 added new non-standard locale categories:
     LC_ADDRESS, LC_IDENTIFICATION, LC_MEASUREMENT, LC_NAME,
     LC_PAPER, LC_TELEPHONE.  These need to be documented.

==========
tcp.7
     FIXME: As at 14 Jun 2005, kernel 2.6.12, the following are
    	not yet documented (shown with default values):

         /proc/sys/net/ipv4/tcp_bic_beta
         819
         /proc/sys/net/ipv4/tcp_moderate_rcvbuf
         1
         /proc/sys/net/ipv4/tcp_no_metrics_save
         0
         /proc/sys/net/ipv4/tcp_vegas_alpha
         2
         /proc/sys/net/ipv4/tcp_vegas_beta
         6
         /proc/sys/net/ipv4/tcp_vegas_gamma
         2

     FIXME Document TCP_CONGESTION (new in 2.6.13)

==========
udp.7
     FIXME document UDP_ENCAP (new in kernel 2.5.67)

==========


The man-pages set contains sections 2, 3, 4, 5, and 7 of 
the manual pages.  These sections describe the following:

2: (Linux) system calls
3: (libc) library functions
4: Devices
5: File formats and protocols
7: Overview pages, conventions, etc.

As far as this list is concerned the most relevant parts are: 
all of sections 2 and 4, which describe kernel-userland interfaces; 
in section 5, the proc(5) manual page, which attempts (it's always 
catching up) to be a comprehensive description of /proc; and 
various pages in section 7, some of which are overview pages of 
kernel features (e.g., networking protocols).

This is a request to kernel developers: if you make a change 
to a kernel-userland interface, or observe a discrepancy 
between the manual pages and reality, would you please send 
me (at mtk-manpages@gmx.net ) one of the following 
(in decreasing order of preference):

1. An in-line "diff -u" patch with text changes for the 
   corresponding manual page.  (The most up-to-date version 
   of the manual pages can always be found at
   ftp://ftp.win.tue.nl/pub/linux-local/manpages or
   ftp://ftp.kernel.org/pub/linux/docs/manpages .)

2. An email describing the changes, which I can then 
   integrate into the appropriate manual page.

3. A message alerting me that some part of the manual pages 
   does not correspond to reality.  Eventually, I will try to 
   remedy the situation.

Obviously, as we get further down this list, more of my time 
is required, and things may go slower, especially when the
changes concern some part of the kernel that I am ignorant 
about and I can't find someone to assist.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7 

Want to help with man page maintenance?  
Grab the latest tarball at
ftp://ftp.win.tue.nl/pub/linux-local/manpages/, 
read the HOWTOHELP file and grep the source 
files for 'FIXME'.
