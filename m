Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287835AbSANRnM>; Mon, 14 Jan 2002 12:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287838AbSANRnC>; Mon, 14 Jan 2002 12:43:02 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:1020 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S287835AbSANRm7>;
	Mon, 14 Jan 2002 12:42:59 -0500
Date: Mon, 14 Jan 2002 10:42:42 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Oleg Drokin <green@namesys.com>
Cc: Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, ewald.peiszer@gmx.at,
        matthias.andree@stud.uni-dortmund.de
Subject: Re: [reiserfs-list] Boot failure: msdos pushes in front of reiserfs
Message-ID: <20020114104242.M26688@lynx.adilger.int>
Mail-Followup-To: Oleg Drokin <green@namesys.com>,
	Hans Reiser <reiser@namesys.com>, reiserfs-list@namesys.com,
	linux-kernel@vger.kernel.org, ewald.peiszer@gmx.at,
	matthias.andree@stud.uni-dortmund.de
In-Reply-To: <20020113223803.GA28085@emma1.emma.line.org> <20020114095013.A4760@namesys.com> <3C42BE0E.2090902@namesys.com> <20020114143650.D828@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020114143650.D828@namesys.com>; from green@namesys.com on Mon, Jan 14, 2002 at 02:36:50PM +0300
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 14, 2002  14:36 +0300, Oleg Drokin wrote:
> On Mon, Jan 14, 2002 at 02:16:30PM +0300, Hans Reiser wrote:
> > So what solution should we use, zeroing or fixing msdos to not try 
> > something reiserfs can find, or both or what?
> 
> We can use both:
>      destroy MSDOS superblock (if any) at mkreiserfs (or don't touch 1st
>      block of the device if there is no msdos superblock).
>      And link reiserfs code into the kernel earlier than msdos code.

Hmm, I could have sworn I submitted patches already which did both of these
things.  In general, it is perfectly safe to zero the bootsector of a
partition when you mkfs it (mke2fs has been doing this for a long time).
If you mkfs your boot partition (and zap the bootblock) you would have to
run LILO on it anyways after they install a new kernel, because the
location of the kernel would change.

'Re: 2.4.15-pre1: "bogus" message with reiserfs root and other weirdness'
dated Nov 21, 2001 for patch to clean up reiserfs boot messages and order.

'Re: [reiserfs-list] Re: Basic reiserfs question' dated Sep 7, 2001 for
patch which (among other things) zaps non-reiserfs data from the disk
when mkreiserfs is run (also referenced in a subsequent posting
'Re: [reiserfs-list] mkreiserfs /dev/hdb' dated Oct 1, 2001).

There was a patch submitted within the past week to clean up the FAT
messages when "silent" is passed.  In any case, that is mostly irrelevant
if reiserfs is moved up in the probe order.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

