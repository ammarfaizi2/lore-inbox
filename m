Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbQKFVW1>; Mon, 6 Nov 2000 16:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130364AbQKFVWU>; Mon, 6 Nov 2000 16:22:20 -0500
Received: from dolly.vellum.cz ([62.80.80.20]:16976 "EHLO dolly.vellum.cz")
	by vger.kernel.org with ESMTP id <S130361AbQKFVWL>;
	Mon, 6 Nov 2000 16:22:11 -0500
Date: Mon, 6 Nov 2000 22:21:44 +0100
From: Karel Zatloukal <kamzik@dolly.vellum.cz>
Message-Id: <200011062121.eA6LLir27520@dolly.vellum.cz>
To: libc-hacker@sourceware.cygnus.com, linux-kernel@vger.kernel.org
Subject: Announce: NFS-client & NIS-client UID/GID remapper
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On the following URL is some patches package to implement UID/GID remapping for
client.  The real original purpose was to use a remapping table of 16-bit
limited Linux to be able to use 32-bit UID/GIDs of Solaris NFS and NIS server:

	http://vellum.cz/~kamzik/idmapper-3.tar.gz

As the 32-bit UID/GID capabilities have been already implemented to Linux, I'm
providing this package only if there would still be some interest in it.  This
package doesn't contain any 16-bit related code, it is fully 32-bit general
remapper (no 16-bit compatibility kludge code) so you can use it for tuning for
your needs of any remote NFS/NIS server maintained by 'foreign' administrator.

As a feature it also supports general regex rewriting rules for NIS client (to
enable adjusts like "/bin/ksh -> /bin/bash" etc.).

This package patches the following software:

glibc-2.1.3
	No pre-glibc-2.2.x patches done, it would be patched only when wanted.
	This patch contains the NIS-client part of the functionality.

linux-2.2.17
&
linux-2.4.0-test10
	This patch contains the NFS-client kernel part of the functionality.

util-linux-2.10f
	This patch contains the NFS-client userland part of the functionality
	by implementing "idmapuid", "idmapgid" and "idmapfile" options for
	mount(8) command.


All the code was only in testing phase and it was (due to organizational
issues) never been used in company-wide environment.  Also beware that the real
testing was done in kernel-2.4.0-test5 time, from such time it was only updated
(almost never needed or a little bit) for kernel changes.  Any bug reports in
the case of any interest would be solved.  Although the patches are found in
RedHat-6.2 subdirectory, you can use it for its original package, of course.

Have these patches a chance to be mainstream integrated (in the case of any
interest by people)?  Documentation excluding some /etc/idmapper.conf notes
below not yet written as I didn't want to do virtually needless work.


						Nice remapping,
							Karel Zatloukal



##############################################################################
#
# Mount options:
# --------------
# idmapuid=[<domainname>/]<client UID>:<server UID>
# idmapgid=[<domainname>/]<client GID>:<server GID>
# idmapfile=<filename>
#
# "/etc/idmapper.conf" is loaded automatically _after_ all the options.
#	- this can be disabled by "idmapfile=-" option
# <domainname> is ypdomainname(1) value by default
#
# /etc/idmapper.conf syntax:
# --------------------------
# uid	<client>	<server>
# gid	<client>	<server>
# domain <full.domain.name:? * permitted, ypdomainname(1) is default>
# map	<nismap:? * permitted>	[key {uid|gid}] [uid <x>] [gid <y>]
# regex	<nismap> {key|value} {from_server|to_client} <left_side:\space or chars> <right_side:\space, \0..\9 or chars>
#                        ... {from_client|to_server} ... # not used much: only yp_update for NIS master update(!)
#
##############################################################################
# Testing only, don't use:
## domain *
## uid	502		101010
## uid	0		231
## gid	100		202020
## domain	domain.somewhere.world
## uid	502		91273
## gid	100		91273
## # Nice name wrapper, only to test regex:
### regex	passwd		value	from_server	^(([^:]*:){4})([^:]*)\ ([^:]*)(:.*)$	\1>>name>>\3<|>\4<<name<<\5
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
