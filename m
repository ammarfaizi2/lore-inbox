Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289578AbSAONlJ>; Tue, 15 Jan 2002 08:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289549AbSAONlA>; Tue, 15 Jan 2002 08:41:00 -0500
Received: from pat.uio.no ([129.240.130.16]:50323 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S289578AbSAONkv>;
	Tue, 15 Jan 2002 08:40:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15428.12621.682479.589568@charged.uio.no>
Date: Tue, 15 Jan 2002 14:40:29 +0100
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Neil Brown <neilb@cse.unsw.edu.au>, Hans-Peter Jansen <hpj@urpla.net>,
        linux-kernel@vger.kernel.org,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: [BUG] symlink problem with knfsd and reiserfs 
In-Reply-To: <15428.14268.730698.637522@laputa.namesys.com>
In-Reply-To: <20020115115019.89B55143B@shrek.lisa.de>
	<15428.6953.453942.415989@charged.uio.no>
	<15428.14268.730698.637522@laputa.namesys.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Nikita Danilov <Nikita@Namesys.COM> writes:

     > Yes, inode->i_generation is stored in the file handle:
     > fs/reiserfs/inode.c:reiserfs_dentry_to_fh().

But what is stored in inode->i_generation? AFAICS

     inode->i_generation = le32_to_cpu (INODE_PKEY (inode)->k_dir_id);

which appears not to be a unique generation count. Isn't that instead
the directory's object id?

The point of i_generation is to provide a unique number that changes
every time you reuse the inode number.

Cheers,
  Trond
