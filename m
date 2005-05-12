Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVELU4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVELU4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 16:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVELU4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 16:56:40 -0400
Received: from mail.dvmed.net ([216.237.124.58]:35792 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262117AbVELU4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 16:56:34 -0400
Message-ID: <4283C2F8.6020801@pobox.com>
Date: Thu, 12 May 2005 16:56:24 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Experimental git repositories available for SATA
Content-Type: multipart/mixed;
 boundary="------------080603080507080604060206"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080603080507080604060206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


I have finally gotten around to getting 2.6.x libata development moved 
over from BitKeeper to git.


The "for Linus/Andrew" repository is libata-2.6.git, available at
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-2.6.git/

The new libata-dev repository is libata-dev.git, available at
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git/


A word about these repositories.  I don't use any SCM besides git 
itself.  libata-2.6.git appears as you would expect:  .git/HEAD points 
to refs/heads/master, which is the top-of-tree, and contains patches 
destined for upstream ASAP.

libata-dev.git is a bit different, as it contains multiple branches:
> [jgarzik@pretzel libata-dev]$ ls .git/refs/heads/
> adma        atapi-enable        iomap        pdc2027x
> adma-mwi    bridge-detect       iomap-step1  pdc20619
> ahci-atapi  chs-support         master       promise-sata-pata
> ahci-msi    ioctl-get-identity  passthru     sil24

I use the attached 'git-switch-tree' script to update the working 
directory to reflect the desired branch.

As soon as I am comfortable with git merging, I will create an 'ALL' 
branch, which contains all of these trees, merged together properly.

	Jeff




--------------080603080507080604060206
Content-Type: text/plain;
 name="git-switch-tree"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-switch-tree"

#!/bin/sh

if [ "x$1" != "x" ]
then
	if [ ! -f .git/refs/heads/$1 ]
	then
		echo Branch $1 not found.
		exit 1
	fi

	( cd .git && rm -f HEAD && ln -s refs/heads/$1 HEAD )
fi

git-read-tree $(cat .git/HEAD) && git-checkout-cache -q -f -a

--------------080603080507080604060206--
