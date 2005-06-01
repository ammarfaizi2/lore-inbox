Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFABRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFABRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 21:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFABRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 21:17:08 -0400
Received: from smtpout.mac.com ([17.250.248.70]:51143 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261161AbVFABRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 21:17:01 -0400
In-Reply-To: <Pine.LNX.4.62.0505311350330.7546@hammer.psislidell.com>
References: <Pine.LNX.4.62.0505311042470.7546@hammer.psislidell.com> <200505312040.30812.bernd-schubert@web.de> <Pine.LNX.4.62.0505311350330.7546@hammer.psislidell.com>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <004E9667-F623-4DF7-A7FE-E1EE2B0EF69D@mac.com>
Cc: bernd-schubert@gmx.de, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Problem with 2.6 kernel and lots of I/O
Date: Tue, 31 May 2005 21:16:50 -0400
To: Roy Keene <rkeene@psislidell.com>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2005, at 15:00:46, Roy Keene wrote:
> I had not heard of "DRBD" before now, but it looks interesting.
> I am looking into it further.

For DRBD, I recommend first installing DRBD, then setting up and
installing Heartbeat.  On Debian the process is something like
the following:

# apt-get install kernel-package kernel-source-${VERSION} drbd0.7- 
module-source drbd0.7-utils heartbeat
# cd /usr/src
# tar -xjf kernel-source-${VERSION}.tar.bz2
# cd kernel-source-${VERSION}
# cp /boot/config-${VERSION}-whatever ./.config
# make-kpkg --revision ${REVISION} --append-to-version -$ 
{MOREVERSION} --added-modules drbd --config oldconfig --us --uc  
configure modules_image
# dpkg -i /usr/src/drbd0.7-module-${VERSION}-${MOREVERSION}_$ 
{DRBD_VERSION}+${REVISION}_${ARCH}.deb

Then read the heartbeat docs to make yourself a /etc/ha.d/haresources
file.  Mine looks like this:
   # Address monarch.csl.tjhsst.edu, Kerberos master, LDAP master
   king    IPaddr::198.38.19.1 Kerberos::TJHSST.EDU::CSL.TJHSST.EDU

   # webkdc.tjhsst.edu
   king    IPaddr::198.38.19.2

   # weblogin.tjhsst.edu
   king    IPaddr::198.38.19.3

   # cups.csl.tjhsst.edu
   king    IPaddr::198.38.19.8

   # mirror.tjhsst.edu
   king    IPaddr::198.38.19.9

   # AFS volumes
   king    drbddisk::afs0  AFSMount::/vicepa
   emperor drbddisk::afs1  AFSMount::/vicepb

NOTE: AFSMount is a custom heartbeat script, and I use a slightly
modified drbddisk script as well.


Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



