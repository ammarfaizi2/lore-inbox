Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313428AbSC2Kbo>; Fri, 29 Mar 2002 05:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313429AbSC2Kbe>; Fri, 29 Mar 2002 05:31:34 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:42001 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S313428AbSC2Kb2>;
	Fri, 29 Mar 2002 05:31:28 -0500
Date: Fri, 29 Mar 2002 10:36:07 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Matthew Walburn <matt@math.mit.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: mkinitrd w/ 2.4.18
In-Reply-To: <20020328202555.A2226@math.mit.edu>
Message-ID: <Pine.LNX.4.33.0203291034460.1089-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002, Matthew Walburn wrote:

> hi there,
>
> i'm having problems getting mkinitrd to work with 2.4.18 in a redhat 7.2 system. are there any kernel options that i should be aware of to get this to work properly that i'm somehow missing?
>
> thanks
> -matt

Try this patch:

diff -ur mkinitrd-3.2.6-orig/mkinitrd mkinitrd-3.2.6/mkinitrd
--- mkinitrd-3.2.6-orig/mkinitrd        Wed Sep  5 21:38:18 2001
+++ mkinitrd-3.2.6/mkinitrd     Fri Mar  1 09:34:22 2002
@@ -309,9 +309,9 @@
     echo "Using modules: $MODULES"
 fi

-MNTIMAGE=`mktemp -d /tmp/initrd.XXXXXX`
-IMAGE=`mktemp /tmp/initrd.img.XXXXXX`
-MNTPOINT=`mktemp -d /tmp/initrd.mnt.XXXXXX`
+MNTIMAGE=$(mktemp -d $TMPDIR/initrd.XXXXXX) || exit 1
+IMAGE=$(mktemp $TMPDIR/initrd.img.XXXXXX) || exit 1
+MNTPOINT=$(mktemp -d $TMPDIR/initrd.mnt.XXXXXX) || exit 1
 RCFILE=$MNTIMAGE/linuxrc

 if [ -z "$MNTIMAGE" -o -z "$IMAGE" -o -z "$MNTPOINT" ]; then

As far as I know Red Hat's latest mkinitrd (in rawhide?) has fixed this
problem. Also, don't forget to set TMPDIR to somewhere other than a tmpfs
filesystem. You see, you cannot bind regular files on a tmpfs to loopback
devices.

Regards,
Tigran

