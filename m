Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbWDXOHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWDXOHh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWDXOHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:07:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21392 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750829AbWDXOHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:07:36 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Olivier Galibert <galibert@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060424135421.GC22703@sergelap.austin.ibm.com>
References: <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424124556.GA92027@dspnet.fr.eu.org>
	 <1145883251.3116.27.camel@laptopd505.fenrus.org>
	 <20060424130949.GE9311@sergelap.austin.ibm.com>
	 <1145884620.3116.33.camel@laptopd505.fenrus.org>
	 <20060424132911.GB22703@sergelap.austin.ibm.com>
	 <1145886047.3116.36.camel@laptopd505.fenrus.org>
	 <20060424135421.GC22703@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 16:07:13 +0200
Message-Id: <1145887633.3116.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 08:54 -0500, Serge E. Hallyn wrote:
> Quoting Arjan van de Ven (arjan@infradead.org):
> > On Mon, 2006-04-24 at 08:29 -0500, Serge E. Hallyn wrote:
> > > Quoting Arjan van de Ven (arjan@infradead.org):
> > > > On Mon, 2006-04-24 at 08:09 -0500, Serge E. Hallyn wrote:
> > > > > Quoting Arjan van de Ven (arjan@infradead.org):
> > > > > > for all such things in the first place. In fact, we already know that to
> > > > > > do auditing, LSM is the wrong thing to do (and that's why audit doesn't
> > > > > > use LSM). It's one of those fundamental linux truths: Trying to be
> > > > > 
> > > > > As I recall it was simply decided that LSM must be "access control
> > > > > only", and that was why it wasn't used for audit.
> > > > 
> > > > no you recall incorrectly.
> > > > Audit needs to audit things that didn't work out, like filenames that
> > > > don't exist. Audit needs to know what is going to happen before the
> > > > entire "is this allowed" chain is going to be followed. SELInux and
> > > > other LSM parts are just one part of that chain, and there's zero
> > > > guarantee that you get to the LSM part in the chain.....  Now of course
> > > 
> > > Ah yes.  It needed to be authoritative.  I did recall incorrectly.
> > > 
> > > I suspect some would argue that you are right that LSM is broken, but
> > > only because it wasn't allowed to be authoritative. 
> > 
> > authoritative isn't enough; think about it. The VFS isn't ever going to
> > ask "can I open this file" if the file doesn't exist in the first place;
> 
> Current audit doesn't do that either, does it?  

As far as I know, it actually does. (assuming you configure it do audit
such events obviously)

> It labels the parent
> inode, so if /var/spool/mail doesn't exist, and you look up
> /var/spool/mail/hallyn, you won't get an audit record. 


>  You'd have to do
> that by auditing all open syscalls at the syscall level.

That's a wrong assumption. There is one level below the syscall level as
well in Linux, and that is where you need to audit for this, and afaik
audit actually does that.



