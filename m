Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317781AbSGPMcq>; Tue, 16 Jul 2002 08:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317790AbSGPMcp>; Tue, 16 Jul 2002 08:32:45 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:52742 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317786AbSGPMcn>; Tue, 16 Jul 2002 08:32:43 -0400
Date: Tue, 16 Jul 2002 14:35:36 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716123536.GG4576@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu> <s5gsn2kst2j.fsf@egghead.curl.com> <1026767676.4751.499.camel@tiny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026767676.4751.499.camel@tiny>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Chris Mason wrote:

> On Mon, 2002-07-15 at 15:13, Patrick J. LoPresti wrote:
> 
> > > 1) that newly grown file is someone's inbox, and the old contents of the
> > > new block include someone else's private message.
> > >
> > > 2) That newly grown file is a control file for the application, and the
> > > application expects it to contain valid data within (think sendmail).  
> > 
> > In a correctly-written application, neither of these things can
> > happen.  (See my earlier message today on fsync() and MTAs.)  To get a
> > file onto disk reliably, the application must 1) flush the data, and
> > then 2) flush a "validity" indicator.  This could be a sequence like:
> > 
> >   create temp file
> >   flush data to temp file
> >   rename temp file
> >   flush rename operation
> 
> Yes, most mtas do this for queue files, I'm not sure how many do it for
> the actual spool file.  mail server authors are more than welcome to

Less. For one, Postfix' local(8) daemon relies on synchronous directory
update for Maildir spools. For mbox spool, the problem is less
prevalent, because spool files usually exist already and fsync() is
sufficient (and fsync() is done before local(8) reports success to the
queue manager).

-- 
Matthias Andree
