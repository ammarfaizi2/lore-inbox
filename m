Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265392AbTFZEIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 00:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbTFZEIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 00:08:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16913 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265392AbTFZEIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 00:08:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Crusoe's performance on linux?
Date: 25 Jun 2003 21:22:27 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bddse3$h33$1@cesium.transmeta.com>
References: <3EF1E6CD.4040800@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com> <bddptk$gqc$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bddptk$gqc$1@cesium.transmeta.com>
By author:    "H. Peter Anvin" <hpa@zytor.com>
In newsgroup: linux.dev.kernel
> 
> I have written a script to try to give a consistent compile benchmark;
> however, one still needs to make sure that DMA is turned on (hdparm -d
> /dev/hda); obviously, the compiler etc should not be on NFS.
> 

Leave it to me to actually forget the script...

#!/bin/bash -x

KERNEL=/home/mirror/kernel.org/linux/kernel/v2.4/linux-2.4.21.tar.gz

if [ -d /tmp/build ]; then
  umount /tmp/build > /dev/null 2>&1
  rmdir /tmp/build
fi

mkdir -p /tmp/build
mount -t tmpfs none /tmp/build
cd /tmp/build
tar xfz $KERNEL
cd linux*
cp -f arch/i386/defconfig .config
yes "" | make oldconfig
make dep
start=`date`
time bash -c 'make -j3 bzImage > build.log 2>&1'
end=`date`
echo "Started: $start  Ended: $end"


	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
