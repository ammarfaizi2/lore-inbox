Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVAYSVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVAYSVc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262048AbVAYSVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:21:32 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:54205 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262047AbVAYSV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:21:27 -0500
Date: Tue, 25 Jan 2005 19:21:10 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050125182110.GA23317@wohnheim.fh-wedel.de>
References: <20050124021516.5d1ee686.akpm@osdl.org> <20050125125323.GA19055@infradead.org> <1106662284.5257.53.camel@uganda> <20050125142356.GA20206@infradead.org> <1106666690.5257.97.camel@uganda> <58cb370e050125073464befe4@mail.gmail.com> <1106669087.5257.100.camel@uganda>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1106669087.5257.100.camel@uganda>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 January 2005 19:04:47 +0300, Evgeniy Polyakov wrote:
> On Tue, 2005-01-25 at 16:34 +0100, Bartlomiej Zolnierkiewicz wrote:
> 
> > Ugh, now think about that:
> > 
> > CPU0     CPU1
> > place1:   place2:
> > lock a      lock b
> > < guess what happens here :-) >
> > lock b      lock a
> > ...             ...
> 
> :) he-he, such place are in add and remove routings, and they can not be
> run simultaneously
> in different CPUs.

Makes my toenails curl.  Something fun I might write someday is a
statical (dead-)lock checker.  The design is very simple:

o Annotate code with the lock that could be taken.
o Whenever getting a lock B, write down something like "A->B" for
  every lock A we already have.
o Create a graph from the locking hierarchy obtained above.
o Look for cycles.

A cycle-free graph means that the code is deadlock-free.  In the
above, the graph surely has cycles.  You could argue that the checker
should be smarter, but then again - why should it?  Is there a
compelling reason why locking schemes as outlined above actually make
the code better?

Jörn

-- 
It does not matter how slowly you go, so long as you do not stop.
-- Confucius
