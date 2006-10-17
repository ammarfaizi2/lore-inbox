Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWJQVH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWJQVH2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJQVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:07:27 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:21588 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750717AbWJQVH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:07:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:in-reply-to:date:message-id;
        b=ltCAgJpDZgbL919ptggB2xRuG4zWq13BBlkTxo5BOSozrVQx0HiPaESZtB9jPljLjJT+I1OFv1SIagcXXGdDnyuXNoKlSP3HE0vvMKJeC5b4H0io4TSj2GgIxISrq9LnPK6OiSO8Yw6+pUkSFmj5mV700EZu/itckNFpdl+OwR4=
From: James Lamanna <jlamanna@gmail.com>
To: linux-kernel@vger.kernel.org, Joerg.Schilling@fokus.fraunhofer.de,
       ismail@pardus.org.tr
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
In-Reply-To: <453521a4.QReHSjx3qh9sf0jr%Joerg.Schilling@fokus.fraunhofer.de>
Date: Tue, 17 Oct 2006 14:07:24 -0700 (PDT)
Message-ID: <4535460c.5a4933ac.778b.ffffc157@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Joerg Shilling wrote:
> Ismail Donmez <ismail@pardus.org.tr> wrote:
>
> > > Well, this is why I did offer a preliminary version of thelatest mkisofs
> > > sources.....
> >
> > Well a simple mkisofs some_file > test.iso and mounting that on a loop
> > device 
> > worked fine.
> >
> >
> > > But note: your patch does not fix the original implementation bug and it
> > > is
> > > most unlikely that the hack will do the right things in all cases.
> >
> > Well I don't know whats the original implementation bug and rock.c seems to
> > be 
> > pretty much old with no active maintainer.
> 
> Please read again my original mail....
> 1) you need to create images with Rock Ridge
> 
> 2) a correct implementation is prepared to deal with more recent versions 
>     without a need for new changes.
> 
>     So, if the implementation does not deal with the new version _without_ 
>     explicitely knowing about v1.12 it is still broken.

Hi Joerg,

I am unable to duplicate this bug that supposedly exists even on older
kernels.
For instance, on a 2.6.16 kernel I do the following:

$ mkisofs -R -v -o rrtest.iso testiso
mkisofs 2.01.01a18 (i686-pc-linux-gnu)
Scanning testiso
Scanning testiso/d3
Scanning testiso/f2
Writing:   Initial Padblock                        Start Block 0
Done with: Initial Padblock                        Block(s)    16
Writing:   Primary Volume Descriptor               Start Block 16
Done with: Primary Volume Descriptor               Block(s)    1
Writing:   End Volume Descriptor                   Start Block 17
Done with: End Volume Descriptor                   Block(s)    1
Writing:   Version block                           Start Block 18
Done with: Version block                           Block(s)    1
Writing:   Path table                              Start Block 19
Done with: Path table                              Block(s)    4
Writing:   Directory tree                          Start Block 23
Done with: Directory tree                          Block(s)    3
Writing:   Directory tree cleanup                  Start Block 26
Done with: Directory tree cleanup                  Block(s)    0
Writing:   Extension record                        Start Block 26
Done with: Extension record                        Block(s)    1
Writing:   The File(s)                             Start Block 27
Total translation table size: 0
Total rockridge attributes bytes: 1163
Total directory bytes: 4096
Path table size(bytes): 30
Done with: The File(s)                             Block(s)    2752
Writing:   Ending Padblock                         Start Block 2779
Done with: Ending Padblock                         Block(s)    150
Max brk space used 21000
2929 extents written (5 MB)

$ mount rrtest.iso testmount -t iso9660 -o loop=/dev/loop0

Examining testmount/ I find everything there that should be there.
dmesg even reports:
ISO 9660 Extensions: RRIP_1991A

So it is indeed using RockRidge of some sort.
(If there is something I'm doing wrong here, please point it out so I can find
this bug).

I do agree that any implementation should not need to know about the new
version in order to function in 1.10 mode. However, in order to support the
new fields, in this case assigning inode->i_ino from the new PX entry field, it
must know that the record is a v. 1.12 one.

Thanks.

-- James

