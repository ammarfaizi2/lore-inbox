Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311203AbSCVLIf>; Fri, 22 Mar 2002 06:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311211AbSCVLIZ>; Fri, 22 Mar 2002 06:08:25 -0500
Received: from pat.uio.no ([129.240.130.16]:24565 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S311203AbSCVLIP>;
	Fri, 22 Mar 2002 06:08:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15515.4235.679887.998891@charged.uio.no>
Date: Fri, 22 Mar 2002 12:07:55 +0100
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: green@namesys.com, sneakums@zork.net, linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
In-Reply-To: <20020322120010.16a53cc9.skraw@ithnet.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stephan von Krawczynski <skraw@ithnet.com> writes:

     > This is a knfsd setup.

Good...

    >> The client will only return ESTALE if the server has first told
    >> it to do so. For knfsd, this is only supposed to occur if the
    >> file has actually been deleted on the server (knfsd is supposed
    >> to be able to retrieve ReiserFS file that have fallen out of
    >> cache).

     > The files are obviously not deleted from the server. Can you
     > give me a short hint in where to look after this specific case
     > (source location). I will try to do some debugging around the
     > place to see what is going on.

Those decisions are supposed to be made in the fh_to_dentry()
'struct super_operations' method. For ReiserFS, that would be in
fs/reiserfs/inode.c:reiserfs_fh_to_dentry().

It would indeed be a good idea to try sticking some debugging
'printk's in there in order to see what is failing...

Cheers,
  Trond

