Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318074AbSFTA1b>; Wed, 19 Jun 2002 20:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318075AbSFTA1b>; Wed, 19 Jun 2002 20:27:31 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:24317 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318074AbSFTA13>; Wed, 19 Jun 2002 20:27:29 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Wed, 19 Jun 2002 18:24:20 -0600
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Christopher Li <chrisl@gnuchina.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020620002420.GG22427@clusterfs.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	Christopher Li <chrisl@gnuchina.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Alexander Viro <viro@math.psu.edu>, DervishD <raul@pleyades.net>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <E17KoGz-0000y5-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17KoGz-0000y5-00@starship>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 20, 2002  00:49 +0200, Daniel Phillips wrote:
> My inclination is to copy the last block of the directory into the
> vacated block as opposed to leaving a hole in the file.  The slight
> extra cost doesn't seem to be worth worrying about, and it's guaranteed
> to leave the directory in a compact state when emptied.

This also has the benefit of avoiding huge truncates when we are
deleting lots of files.  At most it will add a single block into
each transaction.

> I think it's best to err on the side of simplicity this time: the
> copy-down-last strategy eliminates the need to search for a free
> block when the directory needs to be expanded again, 

It also keeps compatibility with older code, whereas having holes in
directories can cause problems on older kernels.

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

