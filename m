Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287882AbSBMRtX>; Wed, 13 Feb 2002 12:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287855AbSBMRtN>; Wed, 13 Feb 2002 12:49:13 -0500
Received: from [63.231.122.81] ([63.231.122.81]:24162 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S287882AbSBMRs6>;
	Wed, 13 Feb 2002 12:48:58 -0500
Date: Wed, 13 Feb 2002 10:47:55 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jens Axboe <axboe@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] queue barrier support
Message-ID: <20020213104755.H25535@lynx.turbolabs.com>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020213135134.A1907@suse.de> <E16b0l7-0001nn-00@starship.berlin> <20020213161838.P1907@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020213161838.P1907@suse.de>; from axboe@suse.de on Wed, Feb 13, 2002 at 04:18:38PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  16:18 +0100, Jens Axboe wrote:
> On Wed, Feb 13 2002, Daniel Phillips wrote:
> > On February 13, 2002 01:51 pm, Jens Axboe wrote:
> > > Patches attached, comments welcome.
> > 
> > A meta-comment: the BK url's are wonderfully informative and useful, but
> > they are long and _ugly_!  Is there anything that can be done about that?
> 
> Yeah I like them too, maybe if I just figured out how to get BitKeeper
> to dump full changeset info I could just inline them in the mail
> instead. I'll look at up and try that next time.

bk send -wgzip_uu -r<rev> - > foo-<rev>.bk

This will dump a gzipped-uuencoded changset to the file.  The receiver
just do "| bk receive [repository] -avv" to import it on the other end.

My preferred format for sending BK CSETs is below.  The gzip_uu CSET
data only adds maybe 10% for large patches, and about doubles the size
of very small patches.  I also created a bz64 (bzip2 + base64) wrapper
which makes the CSET data smaller, but that is only useful if other BK
developers have this wrapper also.

Cheers, Andreas
=============================== bksend ====================================
#!/bin/sh
# A script to format BK changeset output in a manner that is easy to read.
# Andreas Dilger <adilger@turbolabs.com>  13/02/2002

PROG=bksend

usage() {
	echo "usage: $PROG -r<rev>"
	echo -e "\twhere <rev> is of the form '1.23', '1.23..', '1.23..1.27',"
	echo -e "\tor '+' to indicate the most recent revision"

	exit 1
}

case $1 in
-r) REV=$2; shift ;;
-r*) REV=`echo $1 | sed 's/^-r//'` ;;
*) echo "$PROG: no revision given, you probably don't want that";;
esac

[ -z "$REV" ] && usage

bk changes -r$REV
bk export -tpatch -du -h -r$REV
echo -e "\n================================================================\n\n"
bk send -wgzip_uu -r$REV -
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

