Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278243AbRJMCVm>; Fri, 12 Oct 2001 22:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278245AbRJMCVW>; Fri, 12 Oct 2001 22:21:22 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:779 "EHLO
	ani.animx.eu.org") by vger.kernel.org with ESMTP id <S278243AbRJMCVO>;
	Fri, 12 Oct 2001 22:21:14 -0400
Date: Fri, 12 Oct 2001 22:28:38 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Mike Panetta <mpanetta@applianceware.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, andre@linux-ide.org
Subject: Re: IDE Hot-Swap, does it work?, Conspiracy is afoot! (more questions)
Message-ID: <20011012222838.A13338@animx.eu.org>
In-Reply-To: <20011012172955.B12857@animx.eu.org> <Pine.GSO.4.30.0110130008070.18155-100000@balu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=LQksG6bCIzRHxTLp
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.GSO.4.30.0110130008070.18155-100000@balu>; from Pozsar Balazs on Sat, Oct 13, 2001 at 12:14:01AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii

Pozsar Balazs wrote:
> Wakko, could you tell me in detail how to use hdparm -R and -U, because i
> couldn't get it work. Does it (or shoudl it) work for harddisks too?

I'm not sure if it supports hdds or not, As far as I can see, it basically
rescans for the device you're doing.  I attach the contrib script (comes in
hdparm's source tree but not generally included

> What chipset/hardware supports ide-hot-swap, and which of these are
> supported in linux?
> Under The Other Operating System 2000 i have seen this working on a few
> machines for example on an asus cusl2 mobo, so that chipset (i think
> intel 815e) at least can got to do this job.

I think it would work on all ide chipsets, but i'm not sure.  I have hot
plugged IDE into standard systems and hdds not designed for it.  You do run
a risk of hardware damage which I has never happened for me (but could
happen to me next time I try or it could happen to you.  Be warned).  For
this, I've had a system who's / is not an ide disk (I have a machine
mounting / over nfs) and I load/unload ide modules.

I'd like to see support for this similar to /proc/scsi/scsi to rescan

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals

--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=idectl

#!/bin/sh

HDPARM=/sbin/hdparm
MAX_IDE_NR=1

IDE_IO_0=0x1f0
IDE_IO_1=0x170

USE_IDE_DEV_0=/dev/hdc
USE_IDE_DEV_1=/dev/hda

usage () {
	if [ $# -gt 0 ]; then
		echo $* >&2
		echo
	fi

	echo "usage: $0 ide-channel-nr [off|on|rescan]" 2>&1
	exit 1
}

IDE_NR=$1
MODE=$2

do_register=0
do_unregister=0


if [ ! "$IDE_NR" ] || [ $IDE_NR -lt 0 ] || [ $IDE_NR -gt $MAX_IDE_NR ]; then
	usage "Unrecognized IDE-channel number"
fi

case "$MODE" in
on )		do_register=1 ;;
off )		do_unregister=1 ;;
rescan )	do_unregister=1; do_register=1 ;;
* )			usage "Unrecognized command" ;;
esac

eval "IDE_IO=\$IDE_IO_$IDE_NR"
eval "USE_IDE_DEV=\$USE_IDE_DEV_$IDE_NR"

[ $do_unregister -eq 1 ] && eval "$HDPARM -U $IDE_NR $USE_IDE_DEV > /dev/null"
[ $do_register -eq 1 ] && eval "$HDPARM -R $IDE_IO 0 0 $USE_IDE_DEV > /dev/null"


--LQksG6bCIzRHxTLp--
