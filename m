Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUCVU2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbUCVU2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:28:20 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:39091 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262661AbUCVU2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:28:17 -0500
Date: Mon, 22 Mar 2004 21:28:14 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Christoffer Hall-Frederiksen <hall@diku.dk>
Cc: Matthias Andree <matthias.andree@gmx.de>, Jens Axboe <axboe@suse.de>,
       Heikki Tuuri <Heikki.Tuuri@innodb.com>, linux-kernel@vger.kernel.org
Subject: Re: True  fsync() in Linux (on IDE)
Message-ID: <20040322202814.GA14746@merlin.emma.line.org>
Mail-Followup-To: Christoffer Hall-Frederiksen <hall@diku.dk>,
	Jens Axboe <axboe@suse.de>, Heikki Tuuri <Heikki.Tuuri@innodb.com>,
	linux-kernel@vger.kernel.org
References: <023001c4100e$c550cd10$155110ac@hebis> <20040322132307.GP1481@suse.de> <20040322151712.GB32519@merlin.emma.line.org> <405F3A9C.3050307@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405F3A9C.3050307@diku.dk>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Christoffer Hall-Frederiksen wrote:

> >If there is no such atomicity (except maybe in ext3fs data=journal or
> >the upcoming reiserfs4 - isn't there?), then nobody should claim so. If
> >the kernel cannot 100.00000000% guarantee the write is atomic, claiming
> >otherwise is plain fraud and nothing else.
> >
> >Some people bet their whole business/company and hence a fair deal of
> >their belongings on a single data base, and making them believe facts
> >that simply aren't reality is dangerous. These people will have very
> >little understanding for sloppiness here. Linux has no obligation to be
> >fast or reliable, but it MUST PROPERLY AND TRUTHFULLY state what it can
> >guarantee and what it cannot guarantee.
> 
> Some databases (eg. oracle) can write a checksum for each database page 
> to overcome this problem, as this is not just "a linux problem".

I am aware some databases support checksumming (Berkeley DB also does,
since v4.1 (*), and probably a lot more so they know where log recovery
starts) but does that make statements sensible that claim the timing
(some stochastic factor) would usually give "guarantees" about
atomicity of the individual page write when the hardware doesn't
guarantee anything beyond 512 bytes at a time? I think it does not.

I don't mind to beat up anyone, I'd just like to have the guarantees
documented without thin-ice kind of promises "usually you'll get more".

It's good to get more than what was asked for, but the application
designer cannot take that into account because he gets no guarantees. So
why bother wasting space and time for writing and reading such lines? Or
even discussing?

Maybe some interface so an application can query the maximum size of an
atomic write for any given file system (stat[v]fs extension maybe) would
be useful though, so applications can be optimized for data-journaling
file systems should these prove capable to provide "large atomic write"
guarantees.

(*) http://cvs.sourceforge.net/viewcvs.py/bogofilter/bogofilter/src/datastore_db.c?only_with_tag=branch-db-txn#rev1.93.2.5

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
