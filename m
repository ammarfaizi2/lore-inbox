Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264357AbTKMRDz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 12:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264359AbTKMRDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 12:03:55 -0500
Received: from pat.uio.no ([129.240.130.16]:65185 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264357AbTKMRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 12:03:48 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16307.47469.866755.639462@charged.uio.no>
Date: Thu, 13 Nov 2003 12:03:41 -0500
To: root@chaos.analogic.com
Cc: "martin.knoblauch " <"martin.knoblauch "@mscsoftware.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs_statfs: statfs error = 116
In-Reply-To: <Pine.LNX.4.53.0311131052260.31147@chaos>
References: <3FB391FC.2090406@mscsoftware.com>
	<Pine.LNX.4.53.0311130927280.30784@chaos>
	<shssmks70gc.fsf@charged.uio.no>
	<Pine.LNX.4.53.0311131052260.31147@chaos>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning.
X-UiO-MailScanner: No virus found
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Richard B Johnson <root@chaos.analogic.com> writes:

    >> ERESTARTSYS actually just means that a signal was received
    >> while inside a system call. If this results in a interruption
    >> of that syscall, the kernel is supposed to translate
    >> ERESTARTSYS into the user error EINTR.

     > Hmmm, Maybe I'm getting confused by all the winning-lottery
     > messages, but it's in the syscall specifications for connect()
     > and even
     > fcntl(). http:/www.infran.ru/Techinfo/syscalls/syscalls_43.html

AFAICS that documentation was written in 1994, and refers to Linux
v1.0. We've come a long way since then...

Todays Linux userland is supposed to try to comply with the Single
Unix Specification (see http://www.unix-systems.org/version3/)
whenever possible. ERESTARTSYS is missing altogether from the SUSv3
definitions in <errno.h> (and hence does not appear as a valid return
value for any SUSv3-compliant functions).

Note: the Linux manpages do list ERESTARTSYS as still being returned
by the accept() and syslog() system call. In both those cases,
however, they point out that your libc is supposed to intercept it
before it gets to the user.

     > Also, maybe Linux now claims exclusive ownership and keeps it
     > internal, but some networking software, nfsd and pcnfsd, might
     > not know about that.  I've seen ERESTARTSYS returned from a DOS
     > (actually FAT) file-handle use after a server has crashed and
     > come back on-line.

Linux used to be buggy/non-compliant w.r.t. NFS exporting of FAT
filesystems. I'm not sure if that has been fixed yet.

Cheers,
  Trond
