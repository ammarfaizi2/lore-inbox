Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262024AbSIYQlF>; Wed, 25 Sep 2002 12:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262025AbSIYQlF>; Wed, 25 Sep 2002 12:41:05 -0400
Received: from tantale.fifi.org ([216.27.190.146]:14724 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id <S262024AbSIYQlE>;
	Wed, 25 Sep 2002 12:41:04 -0400
To: James Stevenson <james@stev.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19: oops in ide-scsi
References: <87n0q8tcs8.fsf@ceramic.fifi.org>
	<1032891985.2035.1.camel@god.stev.org>
	<87smzzksri.fsf@ceramic.fifi.org>
	<1032903706.2445.4.camel@god.stev.org>
From: Philippe Troin <phil@fifi.org>
Date: 25 Sep 2002 09:46:13 -0700
In-Reply-To: <1032903706.2445.4.camel@god.stev.org>
Message-ID: <87adm6kofe.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson <james@stev.org> writes:

> On Tue, 2002-09-24 at 22:00, Philippe Troin wrote:
> > James Stevenson <james@stev.org> writes:
> > 
> > > Hi
> > > 
> > > i am glad somebody else sees the same crash as me the
> > > request Q gets set to NULL for some reson then tries to
> > > increment a stats counter in the null pointer.
> > > i know what the bug is i just dont know how to fix it :>
> > 
> > I'm not sure which Q you're talking about.
> > Is that rq (in idescsi_pc_intr())?
> 
> the crash happens on
> 
> if (status & ERR_STAT)
> 	rq->errors++;
> 
> because 
> struct request *rq = pc->rq;
> is NULL

Have you tried changing it to:

        if (status & ERR_STAT && rq)
        	rq->errors++;

The code is going to return anyways, and rq is only used here on this
path.

BTW, can you reproduce the oops at will? I can't :-(

Phil.
