Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267457AbRGMNbA>; Fri, 13 Jul 2001 09:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267475AbRGMNau>; Fri, 13 Jul 2001 09:30:50 -0400
Received: from pat.uio.no ([129.240.130.16]:21978 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267457AbRGMNad>;
	Fri, 13 Jul 2001 09:30:33 -0400
To: Alan Cox <alan@redhat.com>
Cc: neilb@cse.unsw.edu.au (Neil Brown),
        abramo@alsa-project.org (Abramo Bagnara),
        linux-kernel@vger.kernel.org (Linux Kernel),
        nfs-devel@linux.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] Bug in NFS - should umask be allowed to set umask???
In-Reply-To: <200107131212.f6DCC0v16274@devserv.devel.redhat.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 13 Jul 2001 15:30:21 +0200
In-Reply-To: Alan Cox's message of "Fri, 13 Jul 2001 08:12:00 -0400 (EDT)"
Message-ID: <shsu20hvtw2.fsf@charged.uio.no>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@redhat.com> writes:

    >> 1/ Claim that redhat is broken. Leave them to fix SysVinit.  2/
    >> Have nfsd over-write the umask setting that /sbin/init imposed.
    >> This is effectively what your patch does.  3/ Decide that it is
    >> inappropriate for nfsd to share the current->fs fs_struct with
    >> init.  Unfortunately this means changing or replacing
    >> daemonize().

     > #3 seems right. Of course its not clear whose fs struct should
     > #be shared

Well, you can either use the fs_struct from init, or that of the first
process to call nfsd. I'm not sure if there's any real point in having
a chrooted nfsd, but it's easy to implement.

In either case, the principle is the same: use copy_fs_struct() on
whatever you want to clone, then have all the nfsd daemons and the
lockd daemon attach to the new shared fs_struct when they get set up.
No need to replace daemonize...

Cheers,
  Trond
