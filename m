Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSBUSmG>; Thu, 21 Feb 2002 13:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292708AbSBUSl4>; Thu, 21 Feb 2002 13:41:56 -0500
Received: from h24-67-15-4.cg.shawcable.net ([24.67.15.4]:33783 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S292707AbSBUSln>;
	Thu, 21 Feb 2002 13:41:43 -0500
Date: Thu, 21 Feb 2002 11:40:16 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Stelian Pop <stelian.pop@fr.alcove.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
Message-ID: <20020221114016.G12832@lynx.adilger.int>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3C751CB2.52110E58@mandrakesoft.com> <20020221164031.GG15866@come.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020221164031.GG15866@come.alcove-fr>; from stelian.pop@fr.alcove.com on Thu, Feb 21, 2002 at 05:40:31PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 21, 2002  17:40 +0100, Stelian Pop wrote:
> On Thu, Feb 21, 2002 at 11:13:38AM -0500, Jeff Garzik wrote:
> > Submitting Changes to Linus
> 
> I would really like this section to be splitted in two:
> 
> - one for Linus' lieutenants:
> 	your explanation, with tree to pull from is ok.
> 
> - one for occasionnal contributors:
> 	either plain patch on l-k
> 		or
> 	plain patch + BK changeset on l-k (using the
> 	Andreas Dilger script wrapper maybe, see below)

I agree (not just because Stelian mentioned my script ;-).  To burden
bkbits.net or any other site to keep a BK repository online just to
submit a trivial change from an occasional contributor is too much.

BK can easily handle CSETs sent inline with the mail, and if Linus 
has the original email saying "pull from here" it could just as well
have a small CSET attached at the end.  Proposed wording:

	For occasional contributors who want to use BK, it is possible
	to send a BK changeset directly in the mail.  In order to make
	it easier to view what is in the changeset, you need to include
	a good description of the change (as always) and both a unified
	diff and the changeset.  Since the unified diff is the readable
	part of the message, it makes sense to make the BK changeset part
	as small as possible.  This can be done by using one of the BK
	wrappers when generating the changeset.  For example:


	To: <maintainer>
	Subject: [PATCH] fixes to FAT filesystem detection

	This change fixes the FAT filesystem code so that it does not
	break when we try to mount something that isn't a FAT filesystem.

	You can import this changeset into BK by piping this whole message to
	'bk receive [path to repository]' or apply the patch as usual.
	=================================================================
	<changeset comment: 'bk changes -r<rev>'>
	<patch summary: 'bk export -t patch -du -h -r<rev> | diffstat'>
	<unified diff: 'bk export -t patch -du -h -r<rev>'>
	=================================================================
	<compressed changeset: 'bk send -wgzip_uu -r<rev> -'>


(this may become part of BK itself so at that time we can just say "use
'bk send -linus -r<rev>' to format the output".

New version of script which includes diffstat output below.

Cheers, Andreas
=============================================================================
#!/bin/sh
# A script to format BK changeset output in a manner that is easy to read.
# Andreas Dilger <adilger@turbolabs.com>  13/02/2002
#
# Add diffstat output after Changelog <adilger@turbolabs.com>   21/02/2002

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

echo "You can import this changeset into BK by piping this whole message to"
echo "'| bk receive [path to repository]' or apply the patch as usual."

SEP="\n===================================================================\n\n"
echo -e $SEP
bk changes -r$REV
echo
bk export -tpatch -du -h -r$REV | diffstat
echo; echo
bk export -tpatch -du -h -r$REV
echo -e $SEP
bk send -wgzip_uu -r$REV -
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

