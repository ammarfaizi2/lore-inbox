Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTCTKTw>; Thu, 20 Mar 2003 05:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261366AbTCTKTw>; Thu, 20 Mar 2003 05:19:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:19210 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261364AbTCTKTr>;
	Thu, 20 Mar 2003 05:19:47 -0500
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Announce: ksymoops 2.4.9 is available
Date: Thu, 20 Mar 2003 21:30:34 +1100
Message-ID: <31735.1048156234@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

- - -----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

ftp://ftp.<country>.kernel.org/pub/linux/utils/kernel/ksymoops/v2.4

ksymoops-2.4.9.tar.gz           Source tarball, includes RPM spec file
ksymoops-2.4.9-1.src.rpm        As above, in SRPM format
ksymoops-2.4.9-1.i386.rpm       Compiled with 2.96 20000731, glibc 2.2.5
patch-ksymoops-2.4.9.gz         Patch from ksymoops 2.4.8 to 2.4.9.

Changelog extract

	* For code lines that dump before EIP and have variable length
	  instructions, decode in two chunks with suitable headings.
	* Fix broken mips64 address mapping.  Maciej W. Rozycki.
	* Pass more mips registers.  Maciej W. Rozycki.
	* Add INSTALL note about broken distributions.  Reported by
	  James W. Laferriere.


The change to decode the Code: line in two chunks allows architectures
that have variable length instructions to safely dump the code before
eip.  The code from eip onwards is always reliable, the code before eip
may not be reliable, this is reflected in the headings before each
chunk of decode output.

Updating ksymoops alone has no effect on the decode.  The arch specific
kernel dump routine must :-

(a) Add the string " VLI" to the line containing the eip/psr/pc/ip/psw
    to tell ksymoops that this dump has variable length instructions.
    For example EIP:    0060:[<c014fedf>] VLI    Not tainted

(b) Dump bytes before and after eip, on one code line.  ksymoops
    handles up to 64 bytes of Code: data.

(c) Enclose the eip byte in <> or ().

If you do not want to decode before eip with variable length
instructions, do not change your arch tree.  ksymoops will
continue to decode as before.

Architectures that already dump code before the eip do not need to be
changed.  AFAIK they all have fixed length instructions.


Some people have reported problems building ksymoops, with unresolved
references in libbfd (htab_create, htab_find_slot_with_hash).  Try
http://www.cs.helsinki.fi/linux/linux-kernel/2002-13/0196.html first,
if that does not work, contact the binutils maintainers.  This is not a
ksymoops problem, ksymoops only uses libbfd.  Any unresolved references
from libbfd are a binutils problem.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE+eZgzi4UHNye0ZOoRAri7AJ9wa2SJC00KIDvArLct/6G6vKBT/QCgyP5J
wn37n1RuaZRJbYxlZy/a4HY=
=hOp+
-----END PGP SIGNATURE-----

