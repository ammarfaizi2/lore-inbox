Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbWBBNPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWBBNPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 08:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWBBNPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 08:15:55 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:29780 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751021AbWBBNPy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 08:15:54 -0500
Date: Thu, 2 Feb 2006 14:18:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, bzolnier@gmail.com, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060202131802.GS4215@suse.de>
References: <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner> <1138642683.7404.31.camel@juerg-pd.bitron.ch> <43DF3C3A.nail2RF112LAB@burner> <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com> <43DF678E.nail3B431CUWJ@burner> <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com> <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr> <43E1D5AD.nail4MI2R8NR2@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E1D5AD.nail4MI2R8NR2@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02 2006, Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> 
> > Which unfortunately leads us back to one of the early questions.
> >
> > If ATAPI is some sort of SCSI [command set] over ATA, and ide-cd can be used
> > without the "Big Bad" SCSI layer (CONFIG_SCSI), don't we have redundant code
> > floating around?
> 
> CONFIG_SCSI???
> 
> Why not using fully dynamical loadable kernel modules as done with
> Solaris since 1992? Since that time nobody cares because what you need
> is auto-loaded on demand and there is absolutely no need for a manual
> configuration.
> 
> BTW: Introducing an orthogonal SCSI based implementation would save a
> lot of code. The model currently used on Linux is duplicating a lot of
> unneeded code in target drivers and the SCSI glue code is only a few
> KB (less than 30k on Solaris). 

I have to comment on that... Your original gripe was the we should not
have so much duplicated code - which of course was shot down, we don't
have much duplicated code, basically a few hundred lines at most. And
that solely remains because /dev/sg* still exists and isn't fully
integrated with bsg (the block layer sg, which is probably misnamed as
it could be used char devices as well).

So this mail from you basically shoots huge holes in your original
gripe. The whole SCSI stack is redundant code in this scheme. A quick
check over my current tree shows over 23 _thousand_ lines of code (SCSI
stack + ide-scsi)! Auto-loading modules has _nothing_ to do with it,
it's still redundant code.

I could go on, but the point should be crystal clear already so I'll
stop. Joerg, unless you have any technical arguments please stop this
thread. And here I do mean ones that are correct. You repeatedly either
ignore mails asking you to backup your claims - or you reply to them
saying "Please stop making false claims!". Honestly, I have no idea why
you are doing that.

-- 
Jens Axboe

