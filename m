Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315988AbSFDCsH>; Mon, 3 Jun 2002 22:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316092AbSFDCsG>; Mon, 3 Jun 2002 22:48:06 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:26057 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315988AbSFDCsF>; Mon, 3 Jun 2002 22:48:05 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 4 Jun 2002 12:46:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15612.10778.673263.187014@notabene.cse.unsw.edu.au>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Pawel Kot <pkot@linuxnews.pl>, lkml <linux-kernel@vger.kernel.org>,
        Andre Hedrick <andre@serialata.org>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Another -pre
In-Reply-To: message from Andreas Dilger on Monday June 3
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 3, adilger@clusterfs.com wrote:
> On Jun 03, 2002  20:27 -0300, Arnaldo Carvalho de Melo wrote:
> > > 1 Weird corruption report with AMD chipset in PIO mode
> > 
> > Oh, I'm not alone ;) Well, up to now it _seems_ that ext3 is saving my day,
> > but it only happened two time after I upgraded to 2.4.19-pre8-ac5, none after
> > I upgraded to 2.4.19-pre9-ac3, but I can't manage to make 'hdparm -X68 /dev/hdd'
> > to work :( I have already sent detailed information to Andre and discussed
> > and tried several things sugested in a irc chat.
> > 
> > Short description: I use ext3 over raid0, using /dev/hda4 and /dev/hdd1,
> > /dev/hdc has a CDRW drive, mostly unused, /dev/hdb has nothing, two times
> > /dev/hda stopped responding, not reproducible AFAIT.
> 
> Well, there was some corruption in ext3 if you used it over MD RAID with
> data=journal mode that was discussed recently on ext3-users.  There was
> a patch posted by Neil Brown which I resend here (full thread archived
> at https://listman.redhat.com/pipermail/ext3-users/).

It turns out that I missed an important bit (literally) in that patch
(and another few files got corrupted....)
Just after (or before)
 +			clear_bit(BH_Freed, &bh->b_state);
We need
 +			clear_bit(BH_JBDDirty, &bh->b_state);

because __journal_unfile_buffer will convert JBDdirty to Dirty just
like __journal_refile_buffer does.

NeilBrown
