Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSK1QdL>; Thu, 28 Nov 2002 11:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265656AbSK1QdL>; Thu, 28 Nov 2002 11:33:11 -0500
Received: from pat.uio.no ([129.240.130.16]:14287 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S265649AbSK1QdK>;
	Thu, 28 Nov 2002 11:33:10 -0500
To: KELEMEN Peter <fuji@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS performance ...
References: <200211241521.09981.m.c.p@wolk-project.de>
	<20021128110627.GD26875@chiara.elte.hu>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 28 Nov 2002 17:40:30 +0100
In-Reply-To: <20021128110627.GD26875@chiara.elte.hu>
Message-ID: <shs65uh1wch.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == KELEMEN Peter <fuji@elte.hu> writes:

     > * Marc-Christian Petersen (m.c.p@wolk-project.de) [20021124
     >   15:23]:
     > Marc, Andrea,

    >> I think Andrea and me have something in our kernels that may
    >> cause it. For me I don't know what that can be. I even have no
    >> idea what it can be :(

     > The culprit turned out to be an inherited CONFIG_NFS_DIRECTIO
     > setting.  Having the client kernel (2.4.20rc2aa1) this option
     > turned off, performance is stable 4 MB/sec (server hasn't
     > changed).  This is almost twice as good as with 2.4.19-rmap14b.

Huh? Sounds like something is seriously screwed up in your kernel
build then. CONFIG_NFS_DIRECTIO should should result in 2 things only:

  - direct.c gets compiled.

  - the 'direct_IO' address space operation gets defined, so that the
    VFS knows what to do with files that get opened with the O_DIRECT
    flag.

None of the ordinary NFS read and write code paths should be affected
by the above.

Cheers,
  Trond
