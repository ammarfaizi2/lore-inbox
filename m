Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282278AbRKWW7c>; Fri, 23 Nov 2001 17:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282279AbRKWW7W>; Fri, 23 Nov 2001 17:59:22 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:4598 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282278AbRKWW7N>;
	Fri, 23 Nov 2001 17:59:13 -0500
Date: Fri, 23 Nov 2001 15:59:01 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: =?iso-8859-1?Q?David_G=F3mez?= <davidge@jazzfree.com>
Cc: =?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= 
	<dervishd@jazzfree.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011123155901.C1308@lynx.no>
Mail-Followup-To: =?iso-8859-1?Q?David_G=F3mez?= <davidge@jazzfree.com>,
	=?iso-8859-1?Q?Ra=FAlN=FA=F1ez_de_Arenas_Coronado?= <dervishd@jazzfree.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E167Fuw-00001K-00@DervishD> <Pine.LNX.4.33.0111231944430.2891-100000@fargo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0111231944430.2891-100000@fargo>; from davidge@jazzfree.com on Fri, Nov 23, 2001 at 08:02:28PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 23, 2001  20:02 -0500, David Gómez wrote:
> AFAIK the .journal it's visible only when you convert an ext2 to an ext3
> filesystem on a mounted partition, it was a problem with 2.4.10 kernel
> version, but i'm not sure if posterior releases also show this behavior.
> Anyway you can solve it recreating a new journal (remount it to ext2
> before doing this):
> 
> 'chattr -i /.journal;rm /.journal;tune2fs -j /dev/whatever'

Don't do that.  That is only good if the filesystem thinks that there
is no journal, or it is using a hidden inode for the journal (i.e. if
you run "tune2fs -l /dev/whatever" and it doesn't have "has_journal"
listed in the filesystem features (this is what happened with 2.4.10).
Otherwise, you will delete your real journal, tune2fs will complain,
and then you will need to run e2fsck to clean up after yourself, before
re-creating your journal again.

If you have a filesystem with a .journal file, and you want to "hide"
it, just run e2fsck 1.25 while the filesystem is unmounted, and it
will do it for you.  If you don't want to have a .journal in the first
place, run tune2fs -j while the filesystem is unmounted.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

