Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264920AbSL0Ldf>; Fri, 27 Dec 2002 06:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSL0Ldf>; Fri, 27 Dec 2002 06:33:35 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:54235 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264920AbSL0Lde>; Fri, 27 Dec 2002 06:33:34 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15884.15486.466985.981729@laputa.namesys.com>
Date: Fri, 27 Dec 2002 14:41:50 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: missed inode->i_hash cleanup in prune_icache()
In-Reply-To: <3E0C35DF.2801AA43@digeo.com>
References: <15884.10772.44042.51586@laputa.namesys.com>
	<3E0C35DF.2801AA43@digeo.com>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
Microsoft: We've got the solution for the problem we sold you.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
 > Nikita Danilov wrote:
 > > 

[...]

 > >                 struct inode *inode;
 > > 
 > >                 inode = list_entry(head->next, struct inode, i_list);
 > > -               list_del(&inode->i_list);
 > > +               list_del_init(&inode->i_list);
 > > 
 > >                 if (inode->i_data.nrpages)
 > >                         truncate_inode_pages(&inode->i_data, 0);
 > > 
 > 
 > That's i_list, not i_hash.
 > 
 > Yes, it's a bit sloppy to leave the i_list pointers dangling but
 > fs/inode.c:new_inode() will just overwrite i_list and all is well.
 > 
 > Could you please double-check or clarify the need for this change?

You are right, sorry. Probably I stared at these lists for too long or
too short a time. We are seeing garbage on sb->s_io in sync_sb_inodes(),
but probably this is some reiser4 problem after all.

Nikita.
