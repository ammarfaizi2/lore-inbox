Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286206AbRL0Df4>; Wed, 26 Dec 2001 22:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286207AbRL0Dfp>; Wed, 26 Dec 2001 22:35:45 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:5126 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286206AbRL0Dff>;
	Wed, 26 Dec 2001 22:35:35 -0500
Date: Thu, 27 Dec 2001 01:35:52 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Legacy Fishtank <garzik@havoc.gtf.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org,
        ext2-devel@lists.sourceforge.net, Alexander Viro <viro@math.psu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] [PATCH] Clean up fs.h union for ext2
Message-ID: <20011227013552.A28388@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Legacy Fishtank <garzik@havoc.gtf.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
	Alexander Viro <viro@math.psu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <E16JR71-0000cU-00@starship.berlin> <20011226222809.A8233@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011226222809.A8233@havoc.gtf.org>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 26, 2001 at 10:28:09PM -0500, Legacy Fishtank escreveu:
> On Thu, Dec 27, 2001 at 04:21:42AM +0100, Daniel Phillips wrote:
> > --- ../2.4.17.clean/include/linux/fs.h	Fri Dec 21 12:42:03 2001
> > +++ ./include/linux/fs.h	Wed Dec 26 23:30:55 2001
> > @@ -478,7 +478,7 @@
> >  	__u32			i_generation;
> >  	union {
> >  		struct minix_inode_info		minix_i;
> > -		struct ext2_inode_info		ext2_i;
> > +		struct ext2_inode_info		ext2_inode_info;
> >  		struct ext3_inode_info		ext3_i;
> >  		struct hpfs_inode_info		hpfs_i;
> >  		struct ntfs_inode_info		ntfs_i;
> 
> Change in principle looks good except IMHO you should go ahead and
> remove the ext2 stuff from the union...  (with the additional changes
> that implies)

Jeff, he's trying to go incremental, the idea is to make the union
something like ->i_fs_private (void pointer) or something like that, or do
like I did for the struct sock case, using a per fs slabcache, to avoid the
extra allocation for the private area, Al thinks that this is not needed,
but Daniel thinks it can be worth it, doing it incrementally we can test
both approaches and avoid getting to big a patch. But yes, the idea is to
kill the union completely and remove all the fs specific includes in fs.h.

After the access to the union is abstracted, we can do the next step, which
is to remove the union, touching then only the function/macro that
abstracts the access to the fs specific data.

So, yes, the ext2 stuff will be removed, as all the other fs specific stuff
8)

- Arnaldo
