Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751034AbWC0XLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWC0XLa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 18:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWC0XLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 18:11:30 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:64702 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751034AbWC0XL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 18:11:29 -0500
Date: Mon, 27 Mar 2006 21:14:30 -0300
From: cascardo@minaslivre.org
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: cascardo@minaslivre.org, "Theodore Ts'o" <tytso@mit.edu>,
       Andreas Dilger <adilger@clusterfs.com>,
       Takashi Sato <sho@bsd.tnes.nec.co.jp>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       Laurent Vivier <Laurent.Vivier@bull.net>, ams@gnu.org
Subject: Re: [Ext2-devel] [PATCH 1/2] ext2/3: Support 2^32-1 blocks(Kernel)
Message-ID: <20060328001430.GD9925@cascardo.localdomain>
References: <20060316212632.GA21004@thunk.org> <20060316225913.GV30801@schatzie.adilger.int> <20060318170729.GI21232@thunk.org> <20060320063633.GC30801@schatzie.adilger.int> <1142894283.21593.59.camel@orbit.scot.redhat.com> <20060320234829.GJ6199@schatzie.adilger.int> <1142960722.3443.24.camel@orbit.scot.redhat.com> <20060321183822.GC11447@thunk.org> <20060325145139.GA5606@cascardo.localdomain> <1143489301.15697.9.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143489301.15697.9.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2006 at 02:55:01PM -0500, Stephen C. Tweedie wrote:
> Hi,
> 
> On Sat, 2006-03-25 at 11:51 -0300, cascardo@minaslivre.org wrote:
> 
> > Regarding compatibility, there are plans to support xattr in Hurd and
> > use them for these fields, translator and author. (I can't recall what
> > i_mode_high is used for.) With respect to that, I'd appreciate if
> > there is a recommendation to every ext2 implementation (not only
> > Linux) that supports xattr, to support gnu.translator and gnu.author
> > (I'll check about the i_mode_high and post about it asap.). 
> 
> What do you mean by "support", exactly?
> 
> There are 3 different bits of xattr design which matter here.  There's
> the namespace exported to users via the *attr syscalls; there's the
> encoding used on disk for those different namespaces; and there's the
> exact semantics surrounding interpretation of the xattr contents.
> 

Listing the attributes of a file should return the "gnu.*"
ones. That's the first meaning of supporting. Storing them on ext2/3
is the second. This one is already implemented for Linux by Roland
McGrath. I don't know, however, it that patch was submitted to the
right people. Is anyone here responsible for that? I can send it to
the list or privately, including the number used to store them. AFAIK,
the Linux code does not blindly lists all the attributes, but only
those "supported", as you pointed below, because they require a
reservation.

> Now, a non-Hurd system is not going to have any use for the gnu.* xattr
> semantics, as translator is a Hurd-specific concept.  The user "gnu.*"
> namespace is easy enough to teach to Linux: to simply reserve that
> namespace, without actually implementing any part of it, I think it be
> sufficient simply to claim the name in include/linux/xattr.h.
> 

The semantics may not be supported, if they have no meaning to the
system. But star or cp should be able to keep those attributes if they
are written to do so. Does anyone know if cp can keep the xattr of a
file? Anyway, a patched cp that would keep the xattrs should keep the
"gnu.*" xattrs, and that's all (if both underlying filesystems support
them, which would be true for two ext2/3 filesystems).

> For ext2/3, though, the key is how to store gnu.* on disk.  Right now
> the different namespaces that ext* stores on disk are enumerated in
> 
> 	fs/ext[23]/xattr.h
> 
> which, for ext2, currently contains:
> 
>         /* Name indexes */
>         /* Name indexes */
>         #define EXT2_XATTR_INDEX_USER			1
>         #define EXT2_XATTR_INDEX_POSIX_ACL_ACCESS	2
>         #define EXT2_XATTR_INDEX_POSIX_ACL_DEFAULT	3
>         #define EXT2_XATTR_INDEX_TRUSTED		4
>         #define	EXT2_XATTR_INDEX_LUSTRE			5
>         #define EXT2_XATTR_INDEX_SECURITY	        6
> 
> If you want to reserve a new semantically-significant portion of the
> namespace for use in the Hurd by gnu.* xattrs, then you'd need to submit
> an authoritative Linux patch to register a new name index on ext2;
> reservation of such an xattr namespace index is in effect an on-disk
> format decision so needs to be agreed between implementations.
> 

That's just what I meant by saying that I'd like them to be supported
by every implementation of ext2/3 xattr. Sorry if that was not
clear. That would be 7, right? That's what Roland uses in his patch.

[...]
> 
> --Stephen
> 
> 

Regards,
Thadeu Cascardo.
--

		
_______________________________________________________ 
Yahoo! Acesso Grátis - Internet rápida e grátis. Instale o discador agora! 
http://br.acesso.yahoo.com
