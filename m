Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261571AbSJHWZa>; Tue, 8 Oct 2002 18:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbSJHWXx>; Tue, 8 Oct 2002 18:23:53 -0400
Received: from fw.openss7.com ([142.179.197.31]:19471 "EHLO gw.openss7.com")
	by vger.kernel.org with ESMTP id <S261571AbSJHWVz>;
	Tue, 8 Oct 2002 18:21:55 -0400
Date: Tue, 8 Oct 2002 16:27:33 -0600
From: "Brian F. G. Bidulock" <bidulock@openss7.org>
To: linux-kernel@vger.kernel.org
Cc: LiS <linux-streams@gsyc.escet.urjc.es>
Subject: Re: [PATCH] Re: export of sys_call_table
Message-ID: <20021008162733.B11638@openss7.org>
Reply-To: bidulock@openss7.org
Mail-Followup-To: linux-kernel@vger.kernel.org,
	LiS <linux-streams@gsyc.escet.urjc.es>
References: <20021004131547.B2369@openss7.org> <20021004.152116.116611188.davem@redhat.com> <20021004164151.D2962@openss7.org> <20021004.153804.94857396.davem@redhat.com> <20021008162017.A11261@openss7.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008162017.A11261@openss7.org>; from bidulock@openss7.org on Tue, Oct 08, 2002 at 04:20:17PM -0600
Organization: http://www.openss7.org/
Dsn-Notification-To: <bidulock@openss7.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We are looking for volunteers to test the following patch for architectures
other than i386.  If you are running LiS on PPC or IA64 or any of these other
architectures, please test and sumbit the tested patch  for you architecture
back.  Thx.

--brian

Index: arch/alpha/kernel/entry.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/alpha/kernel/entry.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/alpha/kernel/entry.S
*** arch/alpha/kernel/entry.S	9 Nov 2001 21:45:35 -0000	1.1.3.1
--- arch/alpha/kernel/entry.S	4 Oct 2002 17:48:33 -0000
***************
*** 1148,1150 ****
--- 1148,1152 ----
  	.quad sys_gettid
  	.quad sys_readahead
  	.quad sys_ni_syscall			/* 380, sys_security */
+ 	.quad sys_getpmsg
+ 	.quad sys_putpmsg
Index: arch/arm/kernel/calls.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/arm/kernel/calls.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/arm/kernel/calls.S
*** arch/arm/kernel/calls.S	8 Oct 2001 17:39:18 -0000	1.1.3.1
--- arch/arm/kernel/calls.S	4 Oct 2002 18:24:18 -0000
***************
*** 202,209 ****
  /* 185 */	.long	SYMBOL_NAME(sys_capset)
  		.long	SYMBOL_NAME(sys_sigaltstack_wrapper)
  		.long	SYMBOL_NAME(sys_sendfile)
! 		.long	SYMBOL_NAME(sys_ni_syscall)
! 		.long	SYMBOL_NAME(sys_ni_syscall)
  /* 190 */	.long	SYMBOL_NAME(sys_vfork_wrapper)
  		.long	SYMBOL_NAME(sys_getrlimit)
  		.long	SYMBOL_NAME(sys_mmap2)
--- 202,209 ----
  /* 185 */	.long	SYMBOL_NAME(sys_capset)
  		.long	SYMBOL_NAME(sys_sigaltstack_wrapper)
  		.long	SYMBOL_NAME(sys_sendfile)
! 		.long	SYMBOL_NAME(sys_getpmsg)
! 		.long	SYMBOL_NAME(sys_putpmsg)
  /* 190 */	.long	SYMBOL_NAME(sys_vfork_wrapper)
  		.long	SYMBOL_NAME(sys_getrlimit)
  		.long	SYMBOL_NAME(sys_mmap2)
Index: arch/cris/kernel/entry.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/cris/kernel/entry.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/cris/kernel/entry.S
*** arch/cris/kernel/entry.S	25 Feb 2002 19:37:52 -0000	1.1.3.1
--- arch/cris/kernel/entry.S	4 Oct 2002 17:24:40 -0000
***************
*** 975,982 ****
  	.long SYMBOL_NAME(sys_capset)           /* 185 */
  	.long SYMBOL_NAME(sys_sigaltstack)
  	.long SYMBOL_NAME(sys_sendfile)
! 	.long SYMBOL_NAME(sys_ni_syscall)	/* streams1 */
! 	.long SYMBOL_NAME(sys_ni_syscall)	/* streams2 */
  	.long SYMBOL_NAME(sys_vfork)            /* 190 */
  	.long SYMBOL_NAME(sys_getrlimit)
  	.long SYMBOL_NAME(sys_mmap2)
--- 975,982 ----
  	.long SYMBOL_NAME(sys_capset)           /* 185 */
  	.long SYMBOL_NAME(sys_sigaltstack)
  	.long SYMBOL_NAME(sys_sendfile)
! 	.long SYMBOL_NAME(sys_getpmsg)		/* streams1 */
! 	.long SYMBOL_NAME(sys_putpmsg)		/* streams2 */
  	.long SYMBOL_NAME(sys_vfork)            /* 190 */
  	.long SYMBOL_NAME(sys_getrlimit)
  	.long SYMBOL_NAME(sys_mmap2)
Index: arch/i386/kernel/entry.S
Index: arch/ia64/kernel/entry.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/ia64/kernel/entry.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/ia64/kernel/entry.S
*** arch/ia64/kernel/entry.S	9 Nov 2001 22:26:17 -0000	1.1.3.1
--- arch/ia64/kernel/entry.S	4 Oct 2002 17:23:55 -0000
***************
*** 1101,1108 ****
  	data8 sys_capget			// 1185
  	data8 sys_capset
  	data8 sys_sendfile
! 	data8 sys_ni_syscall		// sys_getpmsg (STREAMS)
! 	data8 sys_ni_syscall		// sys_putpmsg (STREAMS)
  	data8 sys_socket			// 1190
  	data8 sys_bind
  	data8 sys_connect
--- 1101,1108 ----
  	data8 sys_capget			// 1185
  	data8 sys_capset
  	data8 sys_sendfile
! 	data8 sys_getpmsg		// sys_getpmsg (STREAMS)
! 	data8 sys_putpmsg		// sys_putpmsg (STREAMS)
  	data8 sys_socket			// 1190
  	data8 sys_bind
  	data8 sys_connect
Index: arch/m68k/kernel/entry.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/m68k/kernel/entry.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/m68k/kernel/entry.S
*** arch/m68k/kernel/entry.S	8 Oct 2001 17:39:18 -0000	1.1.3.1
--- arch/m68k/kernel/entry.S	4 Oct 2002 17:25:17 -0000
***************
*** 613,620 ****
  	.long SYMBOL_NAME(sys_capset)           /* 185 */
  	.long SYMBOL_NAME(sys_sigaltstack)
  	.long SYMBOL_NAME(sys_sendfile)
! 	.long SYMBOL_NAME(sys_ni_syscall)		/* streams1 */
! 	.long SYMBOL_NAME(sys_ni_syscall)		/* streams2 */
  	.long SYMBOL_NAME(sys_vfork)            /* 190 */
  	.long SYMBOL_NAME(sys_getrlimit)
  	.long SYMBOL_NAME(sys_mmap2)
--- 613,620 ----
  	.long SYMBOL_NAME(sys_capset)           /* 185 */
  	.long SYMBOL_NAME(sys_sigaltstack)
  	.long SYMBOL_NAME(sys_sendfile)
! 	.long SYMBOL_NAME(sys_getpmsg)		/* streams1 */
! 	.long SYMBOL_NAME(sys_putpmsg)		/* streams2 */
  	.long SYMBOL_NAME(sys_vfork)            /* 190 */
  	.long SYMBOL_NAME(sys_getrlimit)
  	.long SYMBOL_NAME(sys_mmap2)
Index: arch/mips/kernel/syscalls.h
===================================================================
RCS file: /home/common/cvsroot/linux/arch/mips/kernel/syscalls.h,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/mips/kernel/syscalls.h
*** arch/mips/kernel/syscalls.h	8 Oct 2001 17:39:18 -0000	1.1.3.1
--- arch/mips/kernel/syscalls.h	4 Oct 2002 17:31:26 -0000
***************
*** 222,229 ****
  SYS(sys_capset, 2)				/* 4205 */
  SYS(sys_sigaltstack, 0)
  SYS(sys_sendfile, 3)
! SYS(sys_ni_syscall, 0)
! SYS(sys_ni_syscall, 0)
  SYS(sys_mmap2, 6)				/* 4210 */
  SYS(sys_truncate64, 2)
  SYS(sys_ftruncate64, 2)
--- 222,229 ----
  SYS(sys_capset, 2)				/* 4205 */
  SYS(sys_sigaltstack, 0)
  SYS(sys_sendfile, 3)
! SYS(sys_getpmsg, 5)
! SYS(sys_putpmsg, 5)
  SYS(sys_mmap2, 6)				/* 4210 */
  SYS(sys_truncate64, 2)
  SYS(sys_ftruncate64, 2)
Index: arch/mips64/kernel/scall_64.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/mips64/kernel/scall_64.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/mips64/kernel/scall_64.S
*** arch/mips64/kernel/scall_64.S	8 Oct 2001 17:39:18 -0000	1.1.3.1
--- arch/mips64/kernel/scall_64.S	4 Oct 2002 18:26:01 -0000
***************
*** 341,348 ****
  	PTR	sys_capset				/* 5205 */
  	PTR	sys_sigaltstack
  	PTR	sys_sendfile
! 	PTR	sys_ni_syscall
! 	PTR	sys_ni_syscall
  	PTR	sys_pivot_root				/* 5210 */
  	PTR	sys_mincore
  	PTR	sys_madvise
--- 341,348 ----
  	PTR	sys_capset				/* 5205 */
  	PTR	sys_sigaltstack
  	PTR	sys_sendfile
! 	PTR	sys_getpmsg
! 	PTR	sys_putpmsg
  	PTR	sys_pivot_root				/* 5210 */
  	PTR	sys_mincore
  	PTR	sys_madvise
Index: arch/parisc/kernel/syscall.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/parisc/kernel/syscall.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/parisc/kernel/syscall.S
*** arch/parisc/kernel/syscall.S	8 Oct 2001 17:39:18 -0000	1.1.3.1
--- arch/parisc/kernel/syscall.S	4 Oct 2002 17:37:11 -0000
***************
*** 550,557 ****
  	/***************/
  	/* struct shmid_ds contains pointers */
  	ENTRY_UHOH(shmctl)		/* 195 */
! 	ENTRY_SAME(ni_syscall)		/* streams1 */
! 	ENTRY_SAME(ni_syscall)		/* streams2 */
  
  .end
  
--- 550,557 ----
  	/***************/
  	/* struct shmid_ds contains pointers */
  	ENTRY_UHOH(shmctl)		/* 195 */
! 	ENTRY_SAME(getpmsg)		/* streams1 */
! 	ENTRY_SAME(putpmsg)		/* streams2 */
  
  .end
  
Index: arch/ppc/kernel/misc.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/ppc/kernel/misc.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/ppc/kernel/misc.S
*** arch/ppc/kernel/misc.S	25 Feb 2002 19:37:55 -0000	1.1.3.1
--- arch/ppc/kernel/misc.S	4 Oct 2002 17:38:36 -0000
***************
*** 1101,1108 ****
  	.long sys_capset
  	.long sys_sigaltstack	/* 185 */
  	.long sys_sendfile
! 	.long sys_ni_syscall		/* streams1 */
! 	.long sys_ni_syscall		/* streams2 */
  	.long sys_vfork
  	.long sys_getrlimit	/* 190 */
  	.long sys_readahead
--- 1101,1108 ----
  	.long sys_capset
  	.long sys_sigaltstack	/* 185 */
  	.long sys_sendfile
! 	.long sys_getpmsg		/* streams1 */
! 	.long sys_putpmsg		/* streams2 */
  	.long sys_vfork
  	.long sys_getrlimit	/* 190 */
  	.long sys_readahead
Index: arch/s390/kernel/entry.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/s390/kernel/entry.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/s390/kernel/entry.S
*** arch/s390/kernel/entry.S	25 Feb 2002 19:37:56 -0000	1.1.3.1
--- arch/s390/kernel/entry.S	4 Oct 2002 17:39:16 -0000
***************
*** 563,570 ****
          .long  sys_capset                /* 185 */
          .long  sys_sigaltstack_glue
          .long  sys_sendfile
!         .long  sys_ni_syscall            /* streams1 */
!         .long  sys_ni_syscall            /* streams2 */
          .long  sys_vfork_glue            /* 190 */
          .long  sys_getrlimit
  	.long  sys_mmap2
--- 563,570 ----
          .long  sys_capset                /* 185 */
          .long  sys_sigaltstack_glue
          .long  sys_sendfile
!         .long  sys_getpmsg            /* streams1 */
!         .long  sys_putpmsg            /* streams2 */
          .long  sys_vfork_glue            /* 190 */
          .long  sys_getrlimit
  	.long  sys_mmap2
Index: arch/s390x/kernel/entry.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/s390x/kernel/entry.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/s390x/kernel/entry.S
*** arch/s390x/kernel/entry.S	25 Feb 2002 19:37:56 -0000	1.1.3.1
--- arch/s390x/kernel/entry.S	4 Oct 2002 17:44:03 -0000
***************
*** 596,603 ****
          .long  SYSCALL(sys_capset,sys32_capset_wrapper)         /* 185 */
          .long  SYSCALL(sys_sigaltstack_glue,sys32_sigaltstack_glue)
          .long  SYSCALL(sys_sendfile,sys32_sendfile_wrapper)
!         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* streams1 */
!         .long  SYSCALL(sys_ni_syscall,sys_ni_syscall) /* streams2 */
          .long  SYSCALL(sys_vfork_glue,sys_vfork_glue) /* 190 */
          .long  SYSCALL(sys_getrlimit,sys32_old_getrlimit_wrapper)
  	.long  SYSCALL(sys_mmap2,sys32_mmap2_wrapper)
--- 596,603 ----
          .long  SYSCALL(sys_capset,sys32_capset_wrapper)         /* 185 */
          .long  SYSCALL(sys_sigaltstack_glue,sys32_sigaltstack_glue)
          .long  SYSCALL(sys_sendfile,sys32_sendfile_wrapper)
!         .long  SYSCALL(sys_getpmsg,sys_getpmsg) /* streams1 */
!         .long  SYSCALL(sys_putpmsg,sys_putpmsg) /* streams2 */
          .long  SYSCALL(sys_vfork_glue,sys_vfork_glue) /* 190 */
          .long  SYSCALL(sys_getrlimit,sys32_old_getrlimit_wrapper)
  	.long  SYSCALL(sys_mmap2,sys32_mmap2_wrapper)
Index: arch/sh/kernel/entry.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/sh/kernel/entry.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/sh/kernel/entry.S
*** arch/sh/kernel/entry.S	8 Oct 2001 17:39:18 -0000	1.1.3.1
--- arch/sh/kernel/entry.S	4 Oct 2002 18:27:09 -0000
***************
*** 1264,1271 ****
  	.long SYMBOL_NAME(sys_capset)           /* 185 */
  	.long SYMBOL_NAME(sys_sigaltstack)
  	.long SYMBOL_NAME(sys_sendfile)
! 	.long SYMBOL_NAME(sys_ni_syscall)	/* streams1 */
! 	.long SYMBOL_NAME(sys_ni_syscall)	/* streams2 */
  	.long SYMBOL_NAME(sys_vfork)            /* 190 */
  	.long SYMBOL_NAME(sys_getrlimit)
  	.long SYMBOL_NAME(sys_mmap2)
--- 1264,1271 ----
  	.long SYMBOL_NAME(sys_capset)           /* 185 */
  	.long SYMBOL_NAME(sys_sigaltstack)
  	.long SYMBOL_NAME(sys_sendfile)
! 	.long SYMBOL_NAME(sys_getpmsg)		/* streams1 */
! 	.long SYMBOL_NAME(sys_putpmsg)		/* streams2 */
  	.long SYMBOL_NAME(sys_vfork)            /* 190 */
  	.long SYMBOL_NAME(sys_getrlimit)
  	.long SYMBOL_NAME(sys_mmap2)
Index: arch/sparc/kernel/systbls.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/sparc/kernel/systbls.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/sparc/kernel/systbls.S
*** arch/sparc/kernel/systbls.S	21 Oct 2001 17:36:54 -0000	1.1.3.1
--- arch/sparc/kernel/systbls.S	4 Oct 2002 18:37:31 -0000
***************
*** 48,54 ****
  /*135*/	.long sys_nis_syscall, sys_mkdir, sys_rmdir, sys_utimes, sys_stat64
  /*140*/	.long sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_gettid, sys_getrlimit
  /*145*/	.long sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
! /*150*/	.long sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
  /*155*/	.long sys_fcntl64, sys_nis_syscall, sys_statfs, sys_fstatfs, sys_oldumount
  /*160*/	.long sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_nis_syscall
  /*165*/	.long sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_nis_syscall
--- 48,54 ----
  /*135*/	.long sys_nis_syscall, sys_mkdir, sys_rmdir, sys_utimes, sys_stat64
  /*140*/	.long sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_gettid, sys_getrlimit
  /*145*/	.long sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
! /*150*/	.long sys_nis_syscall, sys_getpmsg, sys_putpmsg, sys_poll, sys_getdents64
  /*155*/	.long sys_fcntl64, sys_nis_syscall, sys_statfs, sys_fstatfs, sys_oldumount
  /*160*/	.long sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_nis_syscall
  /*165*/	.long sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_nis_syscall
***************
*** 129,135 ****
  	.long sunos_gethostid, sunos_nosys, sys_getrlimit
  	.long sys_setrlimit, sunos_killpg, sunos_nosys
  	.long sunos_nosys, sunos_nosys
! /*150*/	.long sys_getsockname, sunos_nosys, sunos_nosys
  	.long sys_poll, sunos_nosys, sunos_nosys
  	.long sunos_getdirentries, sys_statfs, sys_fstatfs
  	.long sys_oldumount, sunos_nosys, sunos_nosys
--- 129,135 ----
  	.long sunos_gethostid, sunos_nosys, sys_getrlimit
  	.long sys_setrlimit, sunos_killpg, sunos_nosys
  	.long sunos_nosys, sunos_nosys
! /*150*/	.long sys_getsockname, sys_getpmsg, sys_putpmsg
  	.long sys_poll, sunos_nosys, sunos_nosys
  	.long sunos_getdirentries, sys_statfs, sys_fstatfs
  	.long sys_oldumount, sunos_nosys, sunos_nosys
Index: arch/sparc64/kernel/systbls.S
===================================================================
RCS file: /home/common/cvsroot/linux/arch/sparc64/kernel/systbls.S,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 arch/sparc64/kernel/systbls.S
*** arch/sparc64/kernel/systbls.S	21 Oct 2001 17:36:54 -0000	1.1.3.1
--- arch/sparc64/kernel/systbls.S	4 Oct 2002 18:34:53 -0000
***************
*** 49,55 ****
  	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
  /*140*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_gettid, sys32_getrlimit
  	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
! /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
  	.word sys32_fcntl64, sys_nis_syscall, sys32_statfs, sys32_fstatfs, sys_oldumount
  /*160*/	.word sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_nis_syscall
  	.word sys32_quotactl, sys_nis_syscall, sys32_mount, sys_ustat, sys_nis_syscall
--- 49,55 ----
  	.word sys_nis_syscall, sys_mkdir, sys_rmdir, sys32_utimes, sys_stat64
  /*140*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_gettid, sys32_getrlimit
  	.word sys32_setrlimit, sys_pivot_root, sys32_prctl, sys32_pciconfig_read, sys32_pciconfig_write
! /*150*/	.word sys_nis_syscall, sys_getpmsg, sys_putpmsg, sys_poll, sys_getdents64
  	.word sys32_fcntl64, sys_nis_syscall, sys32_statfs, sys32_fstatfs, sys_oldumount
  /*160*/	.word sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_nis_syscall
  	.word sys32_quotactl, sys_nis_syscall, sys32_mount, sys_ustat, sys_nis_syscall
***************
*** 108,114 ****
  	.word sys_socketpair, sys_mkdir, sys_rmdir, sys_utimes, sys_nis_syscall
  /*140*/	.word sys_nis_syscall, sys_getpeername, sys_nis_syscall, sys_gettid, sys_getrlimit
  	.word sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
! /*150*/	.word sys_getsockname, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
  	.word sys_nis_syscall, sys_nis_syscall, sys_statfs, sys_fstatfs, sys_oldumount
  /*160*/	.word sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_utrap_install
  	.word sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_nis_syscall
--- 108,114 ----
  	.word sys_socketpair, sys_mkdir, sys_rmdir, sys_utimes, sys_nis_syscall
  /*140*/	.word sys_nis_syscall, sys_getpeername, sys_nis_syscall, sys_gettid, sys_getrlimit
  	.word sys_setrlimit, sys_pivot_root, sys_prctl, sys_pciconfig_read, sys_pciconfig_write
! /*150*/	.word sys_getsockname, sys_getpmsg, sys_putpmsg, sys_poll, sys_getdents64
  	.word sys_nis_syscall, sys_nis_syscall, sys_statfs, sys_fstatfs, sys_oldumount
  /*160*/	.word sys_nis_syscall, sys_nis_syscall, sys_getdomainname, sys_setdomainname, sys_utrap_install
  	.word sys_quotactl, sys_nis_syscall, sys_mount, sys_ustat, sys_nis_syscall
***************
*** 189,195 ****
  	.word sunos_gethostid, sunos_nosys, sys32_getrlimit
  	.word sys32_setrlimit, sunos_killpg, sunos_nosys
  	.word sunos_nosys, sunos_nosys
! /*150*/	.word sys_getsockname, sunos_nosys, sunos_nosys
  	.word sys_poll, sunos_nosys, sunos_nosys
  	.word sunos_getdirentries, sys32_statfs, sys32_fstatfs
  	.word sys_oldumount, sunos_nosys, sunos_nosys
--- 189,195 ----
  	.word sunos_gethostid, sunos_nosys, sys32_getrlimit
  	.word sys32_setrlimit, sunos_killpg, sunos_nosys
  	.word sunos_nosys, sunos_nosys
! /*150*/	.word sys_getsockname, sys_getpmsg, sys_putpmsg
  	.word sys_poll, sunos_nosys, sunos_nosys
  	.word sunos_getdirentries, sys32_statfs, sys32_fstatfs
  	.word sys_oldumount, sunos_nosys, sunos_nosys
Index: include/asm-alpha/unistd.h
===================================================================
RCS file: /home/common/cvsroot/linux/include/asm-alpha/unistd.h,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 include/asm-alpha/unistd.h
*** include/asm-alpha/unistd.h	9 Nov 2001 21:45:35 -0000	1.1.3.1
--- include/asm-alpha/unistd.h	4 Oct 2002 17:48:03 -0000
***************
*** 318,323 ****
--- 318,325 ----
  #define __NR_gettid			378
  #define __NR_readahead			379
  #define __NR_security			380 /* syscall for security modules */
+ #define __NR_getpmsg			381
+ #define __NR_putpmsg			382
  
  #if defined(__GNUC__)
  
Index: include/asm-arm/unistd.h
===================================================================
RCS file: /home/common/cvsroot/linux/include/asm-arm/unistd.h,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 include/asm-arm/unistd.h
*** include/asm-arm/unistd.h	12 Aug 2001 18:14:00 -0000	1.1.3.1
--- include/asm-arm/unistd.h	4 Oct 2002 18:24:15 -0000
***************
*** 206,213 ****
  #define __NR_capset			(__NR_SYSCALL_BASE+185)
  #define __NR_sigaltstack		(__NR_SYSCALL_BASE+186)
  #define __NR_sendfile			(__NR_SYSCALL_BASE+187)
! 					/* 188 reserved */
! 					/* 189 reserved */
  #define __NR_vfork			(__NR_SYSCALL_BASE+190)
  #define __NR_ugetrlimit			(__NR_SYSCALL_BASE+191)	/* SuS compliant getrlimit */
  #define __NR_mmap2			(__NR_SYSCALL_BASE+192)
--- 206,213 ----
  #define __NR_capset			(__NR_SYSCALL_BASE+185)
  #define __NR_sigaltstack		(__NR_SYSCALL_BASE+186)
  #define __NR_sendfile			(__NR_SYSCALL_BASE+187)
! #define __NR_getpmsg			(__NR_SYSCALL_BASE+188)
! #define __NR_putpmsg			(__NR_SYSCALL_BASE+189)
  #define __NR_vfork			(__NR_SYSCALL_BASE+190)
  #define __NR_ugetrlimit			(__NR_SYSCALL_BASE+191)	/* SuS compliant getrlimit */
  #define __NR_mmap2			(__NR_SYSCALL_BASE+192)
Index: include/asm-sh/unistd.h
===================================================================
RCS file: /home/common/cvsroot/linux/include/asm-sh/unistd.h,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 include/asm-sh/unistd.h
*** include/asm-sh/unistd.h	2 Oct 2000 18:57:34 -0000	1.1.3.1
--- include/asm-sh/unistd.h	4 Oct 2002 18:27:41 -0000
***************
*** 197,204 ****
  #define __NR_capset		185
  #define __NR_sigaltstack	186
  #define __NR_sendfile		187
! #define __NR_streams1		188	/* some people actually want it */
! #define __NR_streams2		189	/* some people actually want it */
  #define __NR_vfork		190
  #define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
  #define __NR_mmap2		192
--- 197,204 ----
  #define __NR_capset		185
  #define __NR_sigaltstack	186
  #define __NR_sendfile		187
! #define __NR_getpmsg		188	/* some people actually want it */
! #define __NR_putpmsg		189	/* some people actually want it */
  #define __NR_vfork		190
  #define __NR_ugetrlimit		191	/* SuS compliant getrlimit */
  #define __NR_mmap2		192
Index: include/asm-sparc/unistd.h
===================================================================
RCS file: /home/common/cvsroot/linux/include/asm-sparc/unistd.h,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 include/asm-sparc/unistd.h
*** include/asm-sparc/unistd.h	21 Oct 2001 17:36:54 -0000	1.1.3.1
--- include/asm-sparc/unistd.h	4 Oct 2002 18:32:40 -0000
***************
*** 166,173 ****
  #define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
  #define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
  #define __NR_getsockname        150 /* Common                                      */
! /* #define __NR_getmsg          151    SunOS Specific                              */
! /* #define __NR_putmsg          152    SunOS Specific                              */
  #define __NR_poll               153 /* Common                                      */
  #define __NR_getdents64		154 /* Linux specific				   */
  #define __NR_fcntl64		155 /* Linux sparc32 Specific                      */
--- 166,173 ----
  #define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
  #define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
  #define __NR_getsockname        150 /* Common                                      */
! #define __NR_getpmsg		151 /* Common					   */
! #define __NR_putpmsg		152 /* Common					   */
  #define __NR_poll               153 /* Common                                      */
  #define __NR_getdents64		154 /* Linux specific				   */
  #define __NR_fcntl64		155 /* Linux sparc32 Specific                      */
Index: include/asm-sparc64/unistd.h
===================================================================
RCS file: /home/common/cvsroot/linux/include/asm-sparc64/unistd.h,v
retrieving revision 1.1.3.1
diff -c -r1.1.3.1 include/asm-sparc64/unistd.h
*** include/asm-sparc64/unistd.h	21 Oct 2001 17:36:54 -0000	1.1.3.1
--- include/asm-sparc64/unistd.h	4 Oct 2002 18:35:53 -0000
***************
*** 166,173 ****
  #define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
  #define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
  #define __NR_getsockname        150 /* Common                                      */
! /* #define __NR_getmsg          151    SunOS Specific                              */
! /* #define __NR_putmsg          152    SunOS Specific                              */
  #define __NR_poll               153 /* Common                                      */
  #define __NR_getdents64		154 /* Linux specific				   */
  /* #define __NR_fcntl64         155    Linux sparc32 Specific                      */
--- 166,173 ----
  #define __NR_pciconfig_read	148 /* ENOSYS under SunOS                          */
  #define __NR_pciconfig_write	149 /* ENOSYS under SunOS                          */
  #define __NR_getsockname        150 /* Common                                      */
! #define __NR_getpmsg		151 /* Common					   */
! #define __NR_putpmsg		152 /* Common					   */
  #define __NR_poll               153 /* Common                                      */
  #define __NR_getdents64		154 /* Linux specific				   */
  /* #define __NR_fcntl64         155    Linux sparc32 Specific                      */
