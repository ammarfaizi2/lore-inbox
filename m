Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTAZWxF>; Sun, 26 Jan 2003 17:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbTAZWxF>; Sun, 26 Jan 2003 17:53:05 -0500
Received: from pat.uio.no ([129.240.130.16]:30093 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S267030AbTAZWxE>;
	Sun, 26 Jan 2003 17:53:04 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15924.26856.298449.357899@charged.uio.no>
Date: Mon, 27 Jan 2003 00:02:00 +0100
To: Christian Reis <kiko@async.com.br>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, linux-kernel@vger.kernel.org,
       NFS@lists.sourceforge.net
Subject: Re: [NFS] Re: NFS client locking hangs for period
In-Reply-To: <20030126204711.A25997@blackjesus.async.com.br>
References: <20030124184951.A23608@blackjesus.async.com.br>
	<15922.2657.267195.355147@notabene.cse.unsw.edu.au>
	<20030126140200.A25438@blackjesus.async.com.br>
	<shs8yx7lgyt.fsf@charged.uio.no>
	<20030126204711.A25997@blackjesus.async.com.br>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Christian Reis <kiko@async.com.br> writes:

     > statd(8) does indicate that /var/lib/nfs is private, so I just
     > mount it as tmpfs. Should I make it persistent, or is the fact
     > those files disappear on an unclean reboot a sign of trouble?

If you want locking to work, then /var/lib/nfs *MUST* be
persistent and unique for each client.

If not then the server will fail to be notified that it needs to
release any POSIX locks it might think you were holding if/when your
NFS client fails to shutdown cleanly.
That again will typically cause a deadlock the next time you try to
access your mailspool (if the server thinks it is already holding a
lock on your behalf).

Cheers,
  Trond
