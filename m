Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292643AbSBUQk6>; Thu, 21 Feb 2002 11:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292645AbSBUQkt>; Thu, 21 Feb 2002 11:40:49 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:14344 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S292643AbSBUQko>; Thu, 21 Feb 2002 11:40:44 -0500
Date: Thu, 21 Feb 2002 17:40:31 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: BK Kernel Hacking HOWTO
Message-ID: <20020221164031.GG15866@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <3C751CB2.52110E58@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C751CB2.52110E58@mandrakesoft.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 11:13:38AM -0500, Jeff Garzik wrote:

> Let's start with this progression:
> Each BitKeeper source tree on disk is a repository unto itself.
> Each repository has a parent.

except the official Linus one, http://linux.bkbits.net

> Submitting Changes to Linus

I would really like this section to be splitted in two:

- one for Linus' lieutenants:
	your explanation, with tree to pull from is ok.

- one for occasionnal contributors:
	either plain patch on l-k
		or
	plain patch + BK changeset on l-k (using the
	Andreas Dilger script wrapper maybe, see below)
	

> You can and should use the command "bk comment -C<rev>" to update the
> commit text, and improve it after the fact.

Or use bk revtool in X.

Stelian.

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
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
