Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSIBJ6B>; Mon, 2 Sep 2002 05:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318252AbSIBJ6B>; Mon, 2 Sep 2002 05:58:01 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:8461 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S318009AbSIBJ6A>;
	Mon, 2 Sep 2002 05:58:00 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15731.14133.128922.87570@laputa.namesys.com>
Date: Mon, 2 Sep 2002 14:02:29 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: torvalds@transmeta.com (Linus Torvalds)
Cc: Anton Altaparmakov <aia21@cantab.net>,
       David Woodhouse <dwmw2@infradead.org>,
       viro@math.psu.edu (Alexander Viro),
       linux-kernel@vger.kernel.org (Linux Kernel)
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function 
In-Reply-To: <26631.1030893461@redhat.com>
References: <E17lCXU-0002zH-00@storm.christs.cam.ac.uk>
	<26631.1030893461@redhat.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-Drdoom-Fodder: satan CERT crypt crash security
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse writes:
 > 
 > aia21@cantab.net said:
 > > The below ChangeSet against Linus' current BK tree adds a new function
 > > to the VFS, fs/inode.c::ilookup().
 > 
 > > This is needed in NTFS when writing out inode metadata pages via the
 > > VM dirty page code paths as we need to know whether there is an active
 > > inode in icache but we don't want to do an iget() because if the inode
 > > is not active then there is no need to write it... - I can just skip
 > > onto the next one instead... - If there is an active inode then I need
 > > to get the struct inode in order to perform appropriate locking for
 > > the write out to happen. 
 > 
 > Yum. I need similar functionality for JFFS2 garbage collection. When moving
 > a data node, we currently iget() the inode to which it belongs and update
 > its in-core extent lists accordingly. If the inode in question wasn't
 > already present, there's no real need to do that.
 > 

Reiser4 also needs this.

 > --
 > dwmw2
 > 

Nikita.

 > 
