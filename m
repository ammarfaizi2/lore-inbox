Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315190AbSEDTlQ>; Sat, 4 May 2002 15:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSEDTlP>; Sat, 4 May 2002 15:41:15 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:49415 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315190AbSEDTlO>; Sat, 4 May 2002 15:41:14 -0400
Message-Id: <200205041937.g44JbFX12503@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Rob Landley <landley@trommello.org>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Date: Sat, 4 May 2002 22:42:23 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <9595.1020174038@ocs3.intra.ocs.com.au> <200205011416.g41EFnX04718@Port.imtp.ilyichevsk.odessa.ua> <20020503211039.4F680644@merlin.webofficenow.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2002 12:48, Rob Landley wrote:
> > The fact that minix,ext[23],etc has inode #s is an *implementation
> > detail*. Historically entrenched in Unix.
> > Bad:
> > inum_a = inode_num(file1);
> > inum_b = inode_num(file2);
> > if(inum_a == inum_b) { same_file(); }
> > Better:
> > if(is_hardlinked(file1,file2) { same_file(); }
> >
> > Yes, new syscal, blah, blah, blah... Not worth the effort, etc...
> > lets start a flamewar...
>
> If I'm backing up a million files off of a big server, I don't want an
> enormous loop checking each and every one of them against each and every
> other one of them via some system call (potentially through the network) to
> go looking for dupes.  I want some kind of index I can hash against on MY
> side of the wire to go "Have I seen this guy before?".

You can check pairs of files with same size,mode,etc and with hardlink
count>1. That will dramatically reduce number of is_hardlinked() calls
(unless you construct a pathological case of 1000000 hardlinks to
single file).

> That's EXACTLY what an inode is: a unique index for each file that can be
> compared to see if two directory entries refer to the same actual file.
> (Anything ELSE an inode is is an implementation detail, sure.)
>
> These kind of numeric identifiers show up all over the place.  Process ids,
> user ids, filehandles...  It's not an implementation detail, it's a sane
> API.
[snip]

I agree. API is not insane, but I wouldn't call it wonderful too.
--
vda
