Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291900AbSBYAdO>; Sun, 24 Feb 2002 19:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291908AbSBYAdF>; Sun, 24 Feb 2002 19:33:05 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:13509 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S291900AbSBYAcv>; Sun, 24 Feb 2002 19:32:51 -0500
Date: Mon, 25 Feb 2002 02:32:42 +0200 (EET)
From: guy keren <choo@actcom.co.il>
To: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: ANN: syscalltrack v0.7 released
In-Reply-To: <Pine.LNX.4.44.0202250100540.15348-100000@Expansa.sns.it>
Message-ID: <Pine.GSU.4.30_heb2.09.0202250231170.29380-100000@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


syscalltrack-0.7, the 6th _alpha_ release of the linux kernel system call
tracker, is available. syscalltrack supports both versions 2.2.x and 2.4.x
of the linux kernel. The current release contains some major enhancements,
and various bug fixes and code cleanups. See details below.

* What is syscalltrack?

syscalltrack is a linux kernel module and supporting user space
environment which allow interception, logging and possibly taking
action upon system calls that match user defined criteria
(syscalltrack can be thought of as a sophisticated, system wide
strace).

* Where can i get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

You can download the source directly from:
http://prdownloads.sourceforge.net/syscalltrack/syscalltrack-0.70.tar.gz

* Call for developers:

The syscalltrack project is looking for developers, both for kernel
space and user space. If you want to join in on the fun, get in touch
with us on the 'syscalltrack-hackers' mailing list
(http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

* License and NO Warrany

'syscalltrack' is Free Software, licensed under the GNU General Public
License (GPL) version 2. The 'sct_ctrl_lib' library is licensed under
the GNU Lesser General Public License (LGPL).

'syscalltrack' is in _alpha_ stages and comes with NO warranty.
If it breaks something, you get to keep all of the pieces.
You have been warned (TM).

Happy hacking and tracking!

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

=======================================================================

--
guy

"For world domination - press 1,
 or dial 0, and please hold, for the creator." -- nob o. dy

