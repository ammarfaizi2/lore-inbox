Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312511AbSDSQIx>; Fri, 19 Apr 2002 12:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312532AbSDSQIw>; Fri, 19 Apr 2002 12:08:52 -0400
Received: from employees.nextframe.net ([212.169.100.200]:65015 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S312511AbSDSQIv>; Fri, 19 Apr 2002 12:08:51 -0400
Date: Fri, 19 Apr 2002 18:08:51 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re:  [patch] ide updates
Message-ID: <20020419180851.C334@sexything>
Reply-To: morten.helgesen@nextframe.net
In-Reply-To: <20020419133446.GA813@suse.de> <20020419141723.GF813@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 19, 2002 at 04:17:23PM +0200, Jens Axboe wrote:
> On Fri, Apr 19 2002, Jens Axboe wrote:
> > # - (tcq) Arm handler before GET_STAT() service check in
> > #   ide_dma_queued_start, WD seemed to trigger interrupt before that.
> > #   Makes WD Expert drives work with tcq.
> 
> BTW, I really wanted to add (but forgot) that this is in large due to
> Morten Helgesen being a very patient and persistent tester, trying small
> tweaks here and there until the problems with the WD drive was clear.
> 
> More users like that, please :-)

Haha. come on, man - you`re the one with the magic wand :)

Just to let you know that both my WDC WD273BA and my WDC AC313600D
(both from the Expert series for those of you not familiar with WD drives)
are still working great with TCQ - now, without any
benchmark numbers to back me up, I actually think this release of the TCQ
implementation seems even smoother than previous releases. Hard
to explain, actually.

One more thing - it would be really great if all you guys out there
with WD drives could test TCQ and give Jens feedback if you stumble
over WD disks which support TCQ! (Western Digital has not been very
helpful in the process of adding support for TCQ on WD disks).
We seem to have figured out that Caviar disks do not support TCQ,
and that the Expert series does, so we`re interested in hearing from
guys with other WD drives, in particular :) You can use the
attached perl script, sent to me by Jens, to check you drives.


> 
> -- 
> Jens Axboe
> 

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net

--f2QGlHpHGjS2mn6Y
Content-Type: application/x-perl
Content-Disposition: attachment; filename="test-tcq.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl=0A=0A# bit 1 (TCQ) and 14 (word is valid) must be set to in=
dicate tcq support=0A$mask =3D (1 << 1) | (1 << 14);=0A=0A# bit 15 must be =
cleared too=0A$bits =3D $mask | (1 << 15);=0A=0A# mail me the results!=0A$a=
ddr =3D "linux-tcq\@kernel.dk";=0A=0Aforeach $i (</proc/ide/ide*>) {=0A    =
    foreach $d (<$i/hd*>) {=0A                @words =3D split(/\s/,`cat $d=
/identify`);=0A                $w83 =3D hex($words[83]);=0A                =
if (!(($w83 & $bits) ^ $mask)) {=0A                        $model =3D `cat =
$d/model`;=0A                        push(@goodies, $model);=0A            =
            chomp($model);=0A                        print "$d ($model) sup=
ports TCQ\n";=0A                }=0A        }=0A}=0A=0Aif ($addr && $#goodi=
es) {=0A        open(M, "| mail -s TCQ-report $addr");=0A        print M @g=
oodies;=0A        close(M);=0A}=0A=0A
--f2QGlHpHGjS2mn6Y--
