Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRDEBbE>; Wed, 4 Apr 2001 21:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132539AbRDEBay>; Wed, 4 Apr 2001 21:30:54 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:517 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132526AbRDEBai> convert rfc822-to-8bit; Wed, 4 Apr 2001 21:30:38 -0400
Message-ID: <3ACBCA89.EFA3BEEB@baldauf.org>
Date: Thu, 05 Apr 2001 03:29:45 +0200
From: Xuan Baldauf <xuan--lkml@baldauf.org>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: de-DE,en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] smbfs: caching problems
In-Reply-To: <Pine.LNX.4.30.0104050032430.16277-200000@cola.teststation.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Urban Widmark wrote:

> On Sun, 1 Apr 2001, Xuan Baldauf wrote:
>
> > there is something wrong with smbfs caching which makes my
> > applications fail. The behaviour happens with
> > linux-2.4.3-pre4 and linux-2.4.3-final.
> >
> > Consider following shell script: (where /mnt/n is a
> > smbmounted smb share from a Win98SE box)
>
> Try the attached patch, as a workaround.
>

Works for me. :-)

It survived codified test case at the end of this message.

Xuân.


#!/bin/bash
#

if test -z "$1"; then
 LOCAL=0
fi

if test -n "$LOCAL"; then
 umount /mnt/n

 rmmod smbfs

 # mount
 ~/bin/lwc

 cd /mnt/n/temp
fi


rm -f /tmp/test.abc /tmp/test.xyz testfile

I=0
while test $I -lt 127; do
 echo "abc" >>/tmp/test.abc
 I=$((I+1))
done

I=0
while test $I -lt 129; do
 echo "xyz" >>/tmp/test.xyz
 I=$((I+1))
done

I=0

while test $I -lt 8; do
 cp /tmp/test.abc testfile
 tail -1 testfile
 cp /tmp/test.xyz testfile
 tail -1 testfile

 I=$((I+1))
done

rm -f /tmp/test.abc /tmp/test.xyz testfile


if test -n "$LOCAL"; then
 umount /mnt/n
fi


