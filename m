Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289370AbSAOMGj>; Tue, 15 Jan 2002 07:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289504AbSAOMG3>; Tue, 15 Jan 2002 07:06:29 -0500
Received: from mons.uio.no ([129.240.130.14]:9928 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S289370AbSAOMGO>;
	Tue, 15 Jan 2002 07:06:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.6953.453942.415989@charged.uio.no>
Date: Tue, 15 Jan 2002 13:06:01 +0100
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Hans-Peter Jansen <hpj@urpla.net>, linux-kernel@vger.kernel.org
Subject: [BUG] symlink problem with knfsd and reiserfs 
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Hans-Peter Jansen <hpj@urpla.net> writes:

     > In syslog, this message appears: Jan 15 00:21:03 elfe kernel:
     > nfs_refresh_inode: inode 50066 mode changed, 0100664 to 0120777

The error is basically telling you that ReiserFS filehandles are being
reused by the server. Doesn't Reiser provide a generation count to
guard against this sort of thing?

My 'fix' just solves the immediate problem of the wrong file mode. It
does not solve the problems of data corruption that can occur when the
client is incapable of distinguishing the 'old' and 'new' files that
share the same filehandle.

Cheers,
  Trond
