Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSHBRpd>; Fri, 2 Aug 2002 13:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSHBRpd>; Fri, 2 Aug 2002 13:45:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:60936 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316135AbSHBRpb>;
	Fri, 2 Aug 2002 13:45:31 -0400
Message-ID: <3D4AC83A.5A0E37C0@zip.com.au>
Date: Fri, 02 Aug 2002 10:58:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
CC: dalecki@evision-ventures.com, linux-kernel@vger.kernel.org
Subject: Re: IDE hang, partition strangeness
References: <DA7022651A@vcnet.vc.cvut.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:
> 

Hi, Petr.  We're able to reproduce the ntpd thing btw.  It is
caused by cset 1.403.142.43 "avoid allocating pte_chains for unshared
pages" - Rik is looking into it.

> On  1 Aug 02 at 23:56, Andrew Morton wrote:
> > >
> > > Seems that the partitioning code in 2.5.30 is sending illegal LBAs
> > > to the IDE driver, which responds by hanging the box:
> >
> > I misread this backtrace:
> >
> > _this_ is the lba. 160086527.  It is the very last sector on the disk.
> 
> Did not it issued an error on the console before that? Something
> like 'hda: xxxx: status=YY' ?

There are no error messages.

> If it did, just open
> drivers/ide/ide.c in your favorite editor, locate function ata_error,
> in this function locate 'if (rq->errors >= ERROR_MAX)' and replace
> it with 'if (1)'...

Tried that - it made no difference.

It'd be convenient to get my IDE disks back.  I'll try the 2.4
forward-port drivers.
