Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317026AbSFAV4C>; Sat, 1 Jun 2002 17:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317073AbSFAV4B>; Sat, 1 Jun 2002 17:56:01 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:4102 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S317026AbSFAVz7>; Sat, 1 Jun 2002 17:55:59 -0400
Date: Sun, 2 Jun 2002 00:53:03 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: linux-kernel@vger.kernel.org
Subject: ANN: syscalltrack v0.71 "boxing iguana" released
Message-ID: <20020602005303.K18808@alhambra.actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="5cSRzy0VGBWAML+b"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5cSRzy0VGBWAML+b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

syscalltrack-0.71, the 7th _alpha_ release of the linux kernel system
call tracker, is available. syscalltrack supports both version 2.4.x
of the linux kernel. The current release contains some major
enhancements, and various bug fixes and code cleanups. See details
below.

* What is syscalltrack?

syscalltrack is a linux kernel module and supporting user space
environment which allow interception, logging and possibly taking
action upon system calls that match user defined criteria
(syscalltrack can be thought of as a sophisticated, system wide
strace).

* Where can I get it?

Information on syscalltrack is available on the project's homepage:
http://syscalltrack.sourceforge.net, and in the project's file
release.

You can download the source directly from:
http://prdownloads.sourceforge.net/syscalltrack/syscalltrack-0.71.tar.gz

* Call for developers:

The syscalltrack project is looking for developers, both for kernel
space and user space. If you want to join in on the fun, get in touch
with us on the syscalltrack-hackers mailing list
(http://lists.sourceforge.net/lists/listinfo/syscalltrack-hackers).

* License and NO Warrany

syscalltrack is Free Software, licensed under the GNU General Public
License (GPL) version 2. The 'sct_ctrl_lib' library is licensed under
the GNU Lesser General Public License (LGPL).

syscalltrack is in _alpha_ stages and comes with NO warranty.
If it breaks something, you get to keep all of the pieces.
You have been warned (TM).

Happy hacking and tracking!

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Major new features for 0.71 (mostly a bug fix and cleanup release)
------------------------------------------------------------------

* add a 'get rule count' and 'get rules' API to to the
  sct_ctrl_lib. 'get rule count' will return the number of currently
  registered rules, 'get rules' will return to user space from the
  kernel a linked list of the before and after rules for each system
  call. =20

* Support for constants when specifying matching rules, for example,
  O_RDONLY, O_EXCL and friends for open(2).

* Support for octal/hex numbers in filter expressions.=20

* Support for specifying and printing multiplex syscall ids as
  "syscall:func", for example "102:5" for accept(2).=20

* Assorted internal cleanups, code refactoring, bug fixes and memory
  leaks plugged, too many to list here. Documentation and header file
  updates. See the ChangeLog for the gory details.=20

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Major new features for 0.7
--------------------------

* Support for dynamic-cast of 'struct' syscall parameters when filtering
  based on them, and for logging. See the relevant section in
  doc/sct_config_manual.html for how to use this feature. Mostly useful now
  for checking struct parameters in socket calls, so now its possible
  to check if a client prorgam tries to connect to a given port or IP addre=
ss,
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

* Experimental Device-driver control support - the syscalltrack kernel modu=
le
  can now be controlled via a device-file interface - specify "-c device_fi=
le"
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

--=20
Mersday 11 Forelithe 7466

http://vipe.technion.ac.il/~mulix/
http://syscalltrack.sf.net/

--5cSRzy0VGBWAML+b
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8+UI/KRs727/VN8sRAu7UAJ4s4C14zy7pQ4FAfB60s1SSph0kbwCgh+e5
wJfddTiUXqzsVMF49UR9pKQ=
=XTym
-----END PGP SIGNATURE-----

--5cSRzy0VGBWAML+b--
