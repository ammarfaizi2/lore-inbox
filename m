Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbTA1MTr>; Tue, 28 Jan 2003 07:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTA1MTr>; Tue, 28 Jan 2003 07:19:47 -0500
Received: from lmail.actcom.co.il ([192.114.47.13]:40158 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S265249AbTA1MTl>; Tue, 28 Jan 2003 07:19:41 -0500
Date: Tue, 28 Jan 2003 14:28:56 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ANN: syscalltrack 0.81 "Cruel Ducky" released
Message-ID: <20030128122856.GM676@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

syscalltrack-0.81, the 13th alpha release of the Linux kernel system 
call tracker, is now available. syscalltrack supports version 2.4.x of
the Linux kernel on the i386 platform. 

This release containes several important bug fixes and new features. 

* What is syscalltrack?

syscalltrack is made of a pair of Linux kernel modules and supporting
user space environment which allow interception, logging and possibly
taking action upon system calls that match user defined
criteria. syscalltrack can operate either in "tweezers mode", where
only very specific operations are tracked, such as "only track and log
attempts to delete /etc/passwd", or in strace(1) compatible mode,
where all of the supported system calls are traced. syscalltrack can
do things that are impossible to do with the ptrace mechanism, because
its core operates in kernel space. 

* Where can I get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

The source for the latest version can be downloaded directly from: 
http://osdn.dl.sourceforge.net/sourceforge/syscalltrack/syscalltrack-0.81.tar.gz
or any of the other sourceforge mirrors. 

* Call for developers:

The syscalltrack project is looking for developers, both for kernel
space and user space. If you want to join in on the fun, get in touch
with us on the syscalltrack-hackers mailing list
(http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

* License and NO Warranty

syscalltrack is Free Software, licensed under the GNU General Public
License (GPL) version 2. The 'sct_ctrl_lib' library is licensed under
the GNU Lesser General Public License (LGPL).

syscalltrack is in _alpha_ stages and comes with NO warranty. We put
it through extensive testing and routinely run it on our systems, but
if it breaks something, you get to keep all of the pieces. 

* PGP Signature 

All syscalltrack releases from now on will be signed. This release is
signed with my pgp public key, which you can get from
http://www.mulix.org/pubkey.asc or via 
'gpg --keyserver wwwkeys.pgp.net --recv-keys 0xBFD537CB'

Happy syscalltracking!

=======================================================================

New in version 0.81, "Cruel Ducky"
-----------------------------------------------------------------------

* This release includes support for matching against void pointers
  (addresses). For example, you can match against msync's first
  parameter, const void* start. 

* This release re-enables support for tracking the shmat and msgrcv
  calls, after fixing a bug in their tracking support. 

* sctrace now supports strace's 'follow forks' mode. 

* Implement tracking for the last two remaining syscalls, sys_vfork
  and sys_bdflush.  

* Make the userspace tools behave sensibly when the kernel modules
  aren't loaded and complain to run, instead of giving obscure errors. 

* Make sct_config complain about AFTER rules with FAIL actions. A FAIL
  action is only valid in BEFORE rules. 

* Add '-h' and '--help' support to sct_logctrl. 

* Assorted other kernel modules bug fixes. 

=======================================================================

New in version 0.80, "Tanned Otter" 
-----------------------------------------------------------------------

* This release contains support for multiple readers of the log
  device. It is now possible to have two (or more) different log
  device readers, e.g. one running in a terminal ('sctlog'), and the
  other being a daemon reading directly from the log device and
  parsing its output to warn about anomalities. Each log device reader
  can set its own log device parameter, such as the log format and the
  log buffer size. See sct_logctrl(1) and sctlog(1) for further
  details.

* Log output now goes to the log device by default, not to syslog. use
  sctlog(1) (or 'cat /dev/sct_log') to see it. 

* The user can now configure the 'max record length' of records
  printed to the log device file. 'max record length' is useful when
  logging the parameters for read() or write(), for example, because
  the 'buffer' parameter could be very large and filled with garbage,
  thus flooding the log device. This patch allows you to set the max 
  record length to something sane, so only the first bytes of the
  buffer are printed, followed by '...'. Setting it to 0 disables it. 

* This release disables support for the 'shmat', 'semctl' and
  'msgrecv' system calls (muxed functions of the sys_ipc system call,
  to be precise). It will be fixed and included in the next release.

* Make rules printed by 'sct_config download' look nicer. 

=======================================================================

New in version 0.75, "Boffing Hyrax" 
-----------------------------------------------------------------------

* This release contains complete autotools support for the entire
  syscalltrack system: kernel modules, libraries and
  applications. Download, run './configure && make && sudo make install'
  and everything should just work [famous last words]. The autotools
  support includes automatic kernel version detection (which can
  be overridden at configure time), correct user space compilation on
  the various linux distributions, correct kernel modules compilation
  (unlike the ad-hoc CFLAGS selection we had until now), support for UML
  and 2.5 kernels, a working install and uninstall target (sct_load,
  sct_config, sctrace, sct_unload are installed) and lots of other good
  stuff. 

* This release also contains support for 'kill process' and 'suspend
  process' actions. Until now, all you could do was log system call
  invocations (that match a certain rule), or return error values from
  them. Now you can set rules to kill any process that matches a rule
  (tries to connect to a certain host, tries to delete a certain file,
  or just does getpid() *muhahaha*), or, if you're feeling kinder and
  gentler, just suspend it until you attach to it with a debugger.

* This release contains a fix a serious SMP race which would cause a
  system call to fail with -ENOSYS in certain cases.

* More system calls supported: shutdown, getsockname, getpeername,
  socketpair, send, sendto, recvfrom, shutdown, setsockopt,
  getsockopt, sendmsg, recvmsg. adjtimex, capset and capget, ptrace,
  stat64, lstat64 and fstat64.

* Fix a bug where bdflush() was incorrectly hijacked, leading to
  the bdflush system call not working correctly. 

=======================================================================

New in version 0.74, "Hyperactive Iguana"
-----------------------------------------------------------------------

* Added a whole lot of new system calls. syscalltrack now supports
  almost all of the system calls available on 2.4.x: 
  vhangup, wait4, swapoff, sysinfo, fsync, readv, writev, fdatasync,
  msync, getpgid, fchdir, personality, bdflush, flock, setdomainname,
  newuname, modify_ldt, mprotect, sigprocmask, create_module,
  init_module, delete_module, get_kernel_syms, setfsuid16, setfsgid16,
  llseek, quotactl, sysfs, getdents, select, sysctl, mlock, mlockall,
  munlockall, munlockall, sched_setparam, sched_getapram,
  sched_setscheduler, sched_getscheduler, sched_yield,
  sched_get_priority_max, sched_get_priority_min,
  sched_rr_get_interval, nanosleep, mremap, setresuid16, getresuid16,
  query_module, poll, nfsservctl, setresgid16, getresgid16, prctl,
  rt_sigpending, rt_sigtimedwait, rt_sigqueueinfo, chown16, getcwd,
  sendfile,getrlimit, mmap2, stat64, lstat64, fstat64, lchown, getuid,
  getgid, geteuid, getegid, setreuid, setregid, getgroups, setgroups,
  fchown, setresuid, getresuid, setresgid, getresgid, chown, setgid,
  setfsuid, setfsgid, pivot_root, mincore, madvise, getdents64, fnctl64,
  gettid, tkill, sched_setaffinity, sched_getaffinity, sys_olduname
  sys_ustat, old_select, getitimer, setitimer, uname. pread, pwrite,
  truncate64, ftruncate64, readahead.

* Fix a bug where we wouldn't correctly print NULL system call
  parameters. Now we print <NULL>. 

* Add support for system calls with loff_t and long long parameters. 

* Fix several bugs in sctrace. 

* Fix several important bugs in the system call data file parser (used
  in sctrace(1) and sct_config(1)) which prevented valid configuration
  files from being accepted. Added much better error reporting. 

* Numerous other bug fixes and internal cleanups. 

=======================================================================

New in version 0.73, "August Penguin" 
-----------------------------------------------------------------------

* Added sctrace, an experimental strace(1) compatible tool based on
  the syscalltrack framework. 'sctrace command' or 'sctrace -p pid'
  will load rules matching the given executable (or pid) for all
  supported system calls and log their invocation to the log file (or
  log device). 

* experimental logging device file, /dev/sct_log, and a utility to
  control its behaviour, sct_logctrl. syscalltrack can now log system
  call invocation either to syslog or directly to a device
  file. Note that the format of information logged to the device file
  will change in future versions (from text based to a binary
  protocol).

* Fixed a bug in the automatic code generated for system call stubs
  for system calls which have a pointer parameter. This bug exists in
  older syscalltrack versions and while it's harmless, users are still
  encouraged to upgrade.

* Fixed a bug in the kernel module reference counting code when
  deleting a single rule. This code path wasn't in use until
  recently. 

* Fix wrong usage of size_t and other portability cleanups. Fix
  strstream/stringstream usage to work with gcc version before 3 and
  after 3.

* Support all of the IPC system calls (contributed by Gilad
  Ben-Yossef). 

* More new syscalls: execve, statfs, fstatfs, newstat, newlstat,
  newfstat, getrusage, getgroups16, old_readdir and old_mmap. 

* a proof-of-concept GUI tool, gtksct(1).

* new man pages, courtesy of Baruch Even for the debian package of
  syscalltrack. 

=======================================================================

Major new features for 0.72 (mostly a bug fix and new syscalls release)
-----------------------------------------------------------------------

* Many new system calls supported, including but not limited to
  exit(1), fork(2), read(3) and write(4). 

* Fixed bug when evaluating a buffer node and a bug with pattern
  matching on a buffer node. 

* Fixed bug when matching for a constant [filter_expression {1}] to
  return true, as it should, instead of false, as it did. 

* Fixed several in-kernel memory leaks and erronous kernel string 
  handling. 

=======================================================================

Major new features for 0.71 (mostly a bug fix and cleanup release)
------------------------------------------------------------------

* add a 'get rule count' and 'get rules' API to to the
  sct_ctrl_lib. 'get rule count' will return the number of currently
  registered rules, 'get rules' will return to user space from the
  kernel a linked list of the before and after rules for each system
  call.  

* Support for constants when specifying matching rules, for example,
  O_RDONLY, O_EXCL and friends for open(2).

* Support for octal/hex numbers in filter expressions. 

* Support for specifying and printing multiplex syscall ids as
  "syscall:func", for example "102:5" for accept(2). 

* Assorted internal cleanups, code refactoring, bug fixes and memory
  leaks plugged, too many to list here. Documentation and header file
  updates. See the ChangeLog for the gory details. 

=======================================================================

Major new features for 0.7
--------------------------

* Support for dynamic-cast of 'struct' syscall parameters when filtering
  based on them, and for logging. See the relevant section in
  doc/sct_config_manual.html for how to use this feature. Mostly useful now
  for checking struct parameters in socket calls, so now its possible
  to check if a client prorgam tries to connect to a given port or IP address,
  etc.

* Support for 'fail syscall' actions - allows you to specify that a matching
  syscall invocation will prematurely return a given error code (or '0')
  before the system call is actually performed. Handle with care, as failing
  the wrong syscall invocations might render your system unuseable. Good
  usage example: TODO

* Support for convenience-macros in rule config files. Currently supported
  macros include:

    - ipaddr("127.0.0.1") -> translates an IP address to an unsigned long
                             in network byte-order.
    - htons(7) -> host to network byte-order for 'short' numbers.
    - usernametoid("root") -> translates user name to UID.
    - groupnametoid("wheel") -> translates group name to GID.

* Experimental Device-driver control support - the syscalltrack kernel module
  can now be controlled via a device-file interface - specify "-c device_file"
  when running 'sct_config' to use it. The interface is currently
  functionaly-equivalent to the existing 'sysctl' interface - but it will be
  enhanced in the future to support logging via a device-file interface,
  getting rule list via the device-file interface, etc.

* Support for 'log_format' definition per rule, to override the global
  'log_format'.

* Initial correctness-testing script added. Currently only runs 2 tests -
  will become more functional on the next release.

* Support for new system calls - waitpid, close and creat.

major bug fixes for version 0.7:

* Fixes for white-space parsing in 'sct_config'.

* Fix small memory leak when deserializing 'log' actions

* Fix bug in the kernel module that would leave dangling function pointers
  in case a user cleared only the 'before' function pointer. This bug
  wasn't triggered, since sct_config always erased _all_ rules, causing this
  code path to remain yet unused.


-- 
Muli Ben-Yehuda
http://www.mulix.org
http://syscalltrack.sf.net

