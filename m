Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbSKTG76>; Wed, 20 Nov 2002 01:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbSKTG76>; Wed, 20 Nov 2002 01:59:58 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:25044 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265872AbSKTG75>; Wed, 20 Nov 2002 01:59:57 -0500
Date: Wed, 20 Nov 2002 02:06:59 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200211200706.gAK76xA10624@devserv.devel.redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Separate obj/src dir
In-Reply-To: <mailman.1037774521.18360.linux-kernel2news@redhat.com>
References: <20021119201110.GA11192@mars.ravnborg.org> <20021119205154.9616.qmail@escalade.vistahp.com> <mailman.1037774521.18360.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 19, 2002 at 02:51:54PM -0600, Brian Jackson wrote:
>> Sam Ravnborg writes:=20
>> the build tree, and have the build use the copy in the build tree. Exampl=
> e:=20
>> you want to test a one liner in drivers/scsi/sd.c, you could just copy sd=
> .c=20
>> into the build tree, and make the change and test it out. That could be a=
>=20
>> huge space savings. That would help out those of us that are stuck with=
>=20
>> tiny hard drives in our laptops :)=20
>>=20

> For that you probably want to use the hardlinked trees approach.
> Just do a cp -al linux-2.5 scratch; then change your file and build
> from the copy.
> 
> Simon

One word of caution to vi users: you WILL forget to unlink one day.
So, to protect me from myself, every time I untar a Linus' tree,
I immediately do:
 find linux-2.5.foo -type f | xargs chmod a-w
Then, the attached script reduces the typing. Run "deal dir/file.c"
before editing as if it was "bk edit dir/file.c".
Once you are done I always do:
 diff -urN -X dontdiff linux-2.5.48 linux-2.5.48-sparc > x.diff
This is a blazingly fast with hardlinked tree (cp -al).

-- Pete

#!/bin/sh
# This script dealiases a hardlinked file for editing.

set -e

if [ $# != 1 ]; then
  echo "Usage: deal file" >&2
  exit 1
fi

f=$1

mv $f $f~
cp $f~ $f
chmod u+w $f
