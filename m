Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTEVVtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263281AbTEVVtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:49:16 -0400
Received: from ppp-62-245-208-43.mnet-online.de ([62.245.208.43]:385 "EHLO
	frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263279AbTEVVtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:49:14 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69 won't mount root on md device
From: Julien Oster <frodo@dereference.de>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Fri, 23 May 2003 00:02:17 +0200
In-Reply-To: <20030522213013$7e9b@gated-at.bofh.it> (Christoph Hellwig's
 message of "Thu, 22 May 2003 23:30:13 +0200")
Message-ID: <frodoid.frodo.877k8i3aja.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
References: <20030522212009$4564@gated-at.bofh.it>
	<20030522213013$7e9b@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

Hello Christoph,

>> can't mount root filesystem "901" or "/dev/md1"
>> .config included. Any suggestions?

> You are using devfs so you need to tell your kernel the devfs name
> of the root device, /dev/md/1.  Or even better just turn devfs off.

Thanks, that did work out. I was confused, since the kernel also told
me the major and minor device number and so I thought it already
knows which device to mount.

But now another problem shows up:

May 22 23:34:01 frodo kernel: ide_dmaq_intr: stat=42, not expected
May 22 23:34:01 frodo kernel: ide_dmaq_intr: stat=40, not expected
May 22 23:34:01 frodo last message repeated 34 times

I get these messages from the kernel *a lot*, as you can see on the
repeat line. It's mostly stat=40, sometimes stat=42.

My two disks are attached to the onboard Promise RAID Controller (I
use it only as an IDE controller, not for RAID - Linux SoftRAID seems
faster).

I included my "lspci -v" output so you can read out the exact
mainboard and IDE/RAID controller chipset.

For my harddrives, here's a snipplet from hdparm -i /dev/hd[ac]:

 Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4CMNT6A
 Model=IC35L080AVVA07-0, FwRev=VA4OA52A, SerialNo=VNC402A4L7D3XA

(Yes, two identical IBM Deskstars with 80GB - those IBM beasts that
tend to complete crash unrecoverably after some months, that's why I
have two of them on a RAID 1)

Regards,
Julien
