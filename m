Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753723AbWKIHfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753723AbWKIHfX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 02:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbWKIHfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 02:35:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21387 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753594AbWKIHfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 02:35:21 -0500
Date: Wed, 8 Nov 2006 23:35:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Wendel <jwendel10@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5 breaks klogd 1.4.1
Message-Id: <20061108233517.7cc1db12.akpm@osdl.org>
In-Reply-To: <4552D4B4.5020505@comcast.net>
References: <4552BB55.9090400@comcast.net>
	<20061108224153.4ed2e581.akpm@osdl.org>
	<4552D4B4.5020505@comcast.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You removed the mailing list from cc.  Please don't.

On Wed, 08 Nov 2006 23:11:48 -0800
John Wendel <jwendel10@comcast.net> wrote:

> Andrew Morton wrote:
> > On Wed, 08 Nov 2006 21:23:33 -0800
> > John Wendel <jwendel10@comcast.net> wrote:
> >
> >   
> >> Just installed -rc5, system very slow, noticed klogd in a tight loop 
> >> doing a "read". -rc4 is OK.
> >>
> >> Sorry, I have printk configured off, so I don't have any logs.
> >>
> >>     
> >
> > Please run
> >
> > 	strace -p $(pidof klogd)
> >
> >
> >   
> Strace attached.
> 
>
> execve("/sbin/klogd", ["klogd", "-n"], [/* 27 vars */]) = 0
> uname({sys="Linux", node="Godzilla.localdomain", ...}) = 0
> brk(0)                                  = 0x80007000
> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
> open("/etc/ld.so.cache", O_RDONLY)      = 3
> fstat64(3, {st_mode=S_IFREG|0644, st_size=138777, ...}) = 0
> old_mmap(NULL, 138777, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f9c000
> close(3)                                = 0
> open("/lib/tls/libc.so.6", O_RDONLY)    = 3
> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20O\1\000"..., 512) = 512
> fstat64(3, {st_mode=S_IFREG|0755, st_size=1521816, ...}) = 0
> old_mmap(NULL, 1223868, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xb7e71000
> mprotect(0xb7f95000, 27836, PROT_NONE)  = 0
> old_mmap(0xb7f96000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x124000) = 0xb7f96000
> old_mmap(0xb7f9a000, 7356, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f9a000
> close(3)                                = 0
> old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7e70000
> mprotect(0xb7f96000, 8192, PROT_READ)   = 0
> mprotect(0xb7fd5000, 4096, PROT_READ)   = 0
> set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e70aa0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
> munmap(0xb7f9c000, 138777)              = 0
> chdir("/")                              = 0
> brk(0)                                  = 0x80007000
> brk(0x80028000)                         = 0x80028000
> open("/var/run/klogd.pid", O_RDONLY)    = -1 ENOENT (No such file or directory)
> open("/var/run/klogd.pid", O_RDWR|O_CREAT, 0644) = 3
> fcntl64(3, F_GETFL)                     = 0x2 (flags O_RDWR)
> fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fbd000
> _llseek(3, 0, [0], SEEK_CUR)            = 0
> flock(3, LOCK_EX|LOCK_NB)               = 0
> getpid()                                = 4702
> write(3, "4702\n", 5)                   = 5
> flock(3, LOCK_UN)                       = 0
> close(3)                                = 0
> rt_sigaction(SIGHUP, {SIG_IGN}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGINT, {SIG_IGN}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 8) = 0
> 
> [removed a bunch of these]
> 
> rt_sigaction(SIGRT_29, {SIG_IGN}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGRT_30, {SIG_IGN}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGRT_31, {SIG_IGN}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGRT_32, {SIG_IGN}, {SIG_DFL}, 8) = 0
> rt_sigaction(SIGINT, {0x8000186b, [INT], SA_RESTART}, {SIG_IGN}, 8) = 0
> rt_sigaction(SIGKILL, {0x8000186b, [KILL], SA_RESTART}, {SIG_IGN}, 8) = -1 EINVAL (Invalid argument)
> rt_sigaction(SIGTERM, {0x8000186b, [TERM], SA_RESTART}, {SIG_IGN}, 8) = 0
> rt_sigaction(SIGHUP, {0x8000186b, [HUP], SA_RESTART}, {SIG_IGN}, 8) = 0
> rt_sigaction(SIGTSTP, {0x80001492, [TSTP], SA_RESTART}, {SIG_IGN}, 8) = 0
> rt_sigaction(SIGCONT, {0x80001450, [CONT], SA_RESTART}, {SIG_IGN}, 8) = 0
> rt_sigaction(SIGUSR1, {0x800014d4, [USR1], SA_RESTART}, {SIG_IGN}, 8) = 0
> rt_sigaction(SIGUSR2, {0x800014d4, [USR2], SA_RESTART}, {SIG_IGN}, 8) = 0
> syslog(0x8, 0, 0x6)                     = 0
> stat64("/proc/kmsg", {st_mode=S_IFREG|0400, st_size=0, ...}) = 0
> open("/proc/kmsg", O_RDONLY)            = 3

So /proc/kmsg is fd 3.

> socket(PF_FILE, SOCK_DGRAM, 0)          = 4
> connect(4, {sa_family=AF_FILE, path="/dev/log"}, 10) = 0
> time([1163055813])                      = 1163055813
> open("/etc/localtime", O_RDONLY)        = 5
> fstat64(5, {st_mode=S_IFREG|0644, st_size=1017, ...}) = 0
> fstat64(5, {st_mode=S_IFREG|0644, st_size=1017, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fbc000
> read(5, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\4\0\0\0\4\0"..., 4096) = 1017
> close(5)                                = 0
> munmap(0xb7fbc000, 4096)                = 0
> write(4, "<6>Nov  8 23:03:33 kernel: klogd"..., 73) = 73
> uname({sys="Linux", node="Godzilla.localdomain", ...}) = 0
> open("/boot/System.map-2.6.19-rc5", O_RDONLY) = 5
> open("/boot/System.map-2.6.19-rc5", O_RDONLY) = 6
> time([1163055813])                      = 1163055813
> write(4, "<6>Nov  8 23:03:33 kernel: Inspe"..., 66) = 66
> fstat64(6, {st_mode=S_IFREG|0644, st_size=571337, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fbc000
> read(6, "00000400 A __kernel_vsyscall\n000"..., 4096) = 4096
> read(6, "re\nc0104500 T math_emulate\nc0104"..., 4096) = 4096
> read(6, "c010a980 t generic_set_mtrr\nc010"..., 4096) = 4096
> 
> [removed a bunch of these]
> 
> read(6, "c010f7f0 T account_steal_time\nc0"..., 4096) = 4096
> read(6, "hash_entries\nc02f86f0 T tcp_init"..., 4096) = 4096
> read(6, "cpi_skip_timer_override\nc02fd840"..., 4096) = 4096
> read(6, "tup_parse_reservetop\nc0300b48 t "..., 4096) = 4096
> read(6, "0300f18 t __initcall_pcibios_ass"..., 4096) = 4096
> read(6, "t cubictcp_unregister\nc03034c0 t"..., 4096) = 4096
> uname({sys="Linux", node="Godzilla.localdomain", ...}) = 0
> close(6)                                = 0
> munmap(0xb7fbc000, 4096)                = 0
> close(5)                                = 0
> open("/boot/System.map-2.6.19-rc5", O_RDONLY) = 5
> fstat64(5, {st_mode=S_IFREG|0644, st_size=571337, ...}) = 0
> mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xb7fbc000
> read(5, "00000400 A __kernel_vsyscall\n000"..., 4096) = 4096
> read(5, "re\nc0104500 T math_emulate\nc0104"..., 4096) = 4096
> read(5, "c010a980 t generic_set_mtrr\nc010"..., 4096) = 4096
> read(5, "c010f7f0 T account_steal_time\nc0"..., 4096) = 4096
> read(5, "s_waitpid\nc0115ee0 t itimer_get_"..., 4096) = 4096
> read(5, "ut\nc011b4e0 T sys_gettid\nc011b4f"..., 4096) = 4096
> read(5, "e\nc0120a70 T sys_sethostname\nc01"..., 4096) = 4096
> 
> [removed a bunch of these]
> 
> read(5, "p\nc0124d80 T sys_clock_nanosleep"..., 4096) = 4096
> read(5, "_latency_notifier\nc0128a30 T unr"..., 4096) = 4096
> read(5, "cpi_skip_timer_override\nc02fd840"..., 4096) = 4096
> read(5, "tup_parse_reservetop\nc0300b48 t "..., 4096) = 4096
> read(5, "0300f18 t __initcall_pcibios_ass"..., 4096) = 4096
> read(5, "t cubictcp_unregister\nc03034c0 t"..., 4096) = 4096
> uname({sys="Linux", node="Godzilla.localdomain", ...}) = 0
> read(5, "c030a008 B pmd_cache\nc030a00c B "..., 4096) = 4096
> read(5, "ck\nc030d980 b pkmap_count\nc030e9"..., 4096) = 4096
> read(5, "_workqueue\nc031400c b per_cpu__b"..., 4096) = 4096
> read(5, " acpi_gbl_root_node_struct\nc0314"..., 4096) = 4096
> read(5, "settings\nc0319cdc b cdrom_sysctl"..., 4096) = 4096
> read(5, "family_ht\nc031b620 b rover.1\nc03"..., 4096) = 1993
> read(5, "", 4096)                       = 0
> time([1163055813])                      = 1163055813
> write(4, "<6>Nov  8 23:03:33 kernel: Loade"..., 82) = 82
> time([1163055813])                      = 1163055813
> write(4, "<6>Nov  8 23:03:33 kernel: Symbo"..., 64) = 64
> close(5)                                = 0
> munmap(0xb7fbc000, 4096)                = 0
> get_kernel_syms(0)                      = -1 ENOSYS (Function not implemented)
> time([1163055813])                      = 1163055813
> write(4, "<6>Nov  8 23:03:33 kernel: No mo"..., 83) = 83
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> read(3, "", 4095)                       = 0
> 
> [repeats until I kill it]
> 

And, predictably, reads from /proc/kmsg aren't blocking.

I can't see what might have caused that.  Are you sure that 2.6.19-rc4 was
OK?  And are you sure that nothing else has changed on that system?

