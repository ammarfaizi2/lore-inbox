Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318371AbSHEKsF>; Mon, 5 Aug 2002 06:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318373AbSHEKsF>; Mon, 5 Aug 2002 06:48:05 -0400
Received: from axp01.e18.physik.tu-muenchen.de ([129.187.154.129]:53770 "EHLO
	axp01.e18.physik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S318371AbSHEKsD>; Mon, 5 Aug 2002 06:48:03 -0400
Date: Mon, 5 Aug 2002 12:51:35 +0200 (CEST)
From: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
In-Reply-To: <20020805135420.A30430@namesys.com>
Message-ID: <Pine.LNX.4.44.0208051243430.31879-100000@pc40.e18.physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 5 Aug 2002, Oleg Drokin wrote:

> Hello!
> 
> On Mon, Aug 05, 2002 at 11:22:49AM +0200, Roland Kuhn wrote:
> 
> > BTW: was it directly clear for you for what the do_journal_begin_r() was 
> > waiting? I'm not so familiar with fs coding, especially the locking...
> 
> I'd say that it's waiting for journal lock that was captured by kupdated
> (or something like that) doing periodic write_super() calls, when it thinks
> memory is low. Our tests some time ago shown that once memory is lower than
> some value, write_super() "method" is called for every superblock that
> have "dirty" flag set. In reiserfs that flushes the journal, and while journal
> is being flushed, nobody can create new transactions obviously, and since
> ls changes directory's atime in normal case, it want to open new transaction.
> Unfortunatelly dirty flag for reiserfs gets set way to often than necessary,
> we have some patches that should help this (from Chris Mason).
> You can try these for yourself too, for example from here:
> ftp://ftp.suse.com/pub/people/mason/patches/data-logging/02-commit_super-8-relocation.diff.gz 
> 
I will try it immediately. And I will try to find documentation on how 
this all is working, so I can understand the implications. Does the 
"flushing" also happen, when the journal is full? Or is it possible to 
begin a new journal while the old one is written out?

> > than in the 2.4.18-3 case, where it took about 1 minute for ls to come 
> > back. 
> 
> So you might try the patch I mentioned or you can mount with nodiratime mount
> option to prevent updqting of directory atimes, but having atimes still to be
> updated on regular files at the same time.
> 
Interesting mount option, though I think very few application actually use 
atime anyway, isn't it?

Ciao,
					Roland

+---------------------------+-------------------------+
|    TU Muenchen            |                         |
|    Physik-Department E18  |  Raum    3558           |
|    James-Franck-Str.      |  Telefon 089/289-12592  |
|    85747 Garching         |                         |
+---------------------------+-------------------------+

