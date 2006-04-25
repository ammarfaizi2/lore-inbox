Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWDZDl4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWDZDl4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 23:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWDZDlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 23:41:36 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21645 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751639AbWDZDlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 23:41:32 -0400
Date: Tue, 25 Apr 2006 14:06:37 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       Olivier Galibert <galibert@pobox.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060425190637.GG5765@sergelap.austin.ibm.com>
References: <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424124556.GA92027@dspnet.fr.eu.org> <1145883251.3116.27.camel@laptopd505.fenrus.org> <20060424130949.GE9311@sergelap.austin.ibm.com> <1145884620.3116.33.camel@laptopd505.fenrus.org> <20060424132911.GB22703@sergelap.austin.ibm.com> <1145886047.3116.36.camel@laptopd505.fenrus.org> <20060424135421.GC22703@sergelap.austin.ibm.com> <1145887633.3116.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145887633.3116.40.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arjan van de Ven (arjan@infradead.org):
> On Mon, 2006-04-24 at 08:54 -0500, Serge E. Hallyn wrote:
> > Quoting Arjan van de Ven (arjan@infradead.org):
> > > On Mon, 2006-04-24 at 08:29 -0500, Serge E. Hallyn wrote:
> > > > Quoting Arjan van de Ven (arjan@infradead.org):
> > > > > On Mon, 2006-04-24 at 08:09 -0500, Serge E. Hallyn wrote:
> > > > > > Quoting Arjan van de Ven (arjan@infradead.org):
> > > > > > > for all such things in the first place. In fact, we already know that to
> > > > > > > do auditing, LSM is the wrong thing to do (and that's why audit doesn't
> > > > > > > use LSM). It's one of those fundamental linux truths: Trying to be
> > > > > > 
> > > > > > As I recall it was simply decided that LSM must be "access control
> > > > > > only", and that was why it wasn't used for audit.
> > > > > 
> > > > > no you recall incorrectly.
> > > > > Audit needs to audit things that didn't work out, like filenames that
> > > > > don't exist. Audit needs to know what is going to happen before the
> > > > > entire "is this allowed" chain is going to be followed. SELInux and
> > > > > other LSM parts are just one part of that chain, and there's zero
> > > > > guarantee that you get to the LSM part in the chain.....  Now of course
> > > > 
> > > > Ah yes.  It needed to be authoritative.  I did recall incorrectly.
> > > > 
> > > > I suspect some would argue that you are right that LSM is broken, but
> > > > only because it wasn't allowed to be authoritative. 
> > > 
> > > authoritative isn't enough; think about it. The VFS isn't ever going to
> > > ask "can I open this file" if the file doesn't exist in the first place;
> > 
> > Current audit doesn't do that either, does it?  
> 
> As far as I know, it actually does. (assuming you configure it do audit
> such events obviously)

If the parent directory exists, yes.  LSM could do that too.  If the
parent directory does not exist, then you cannot create an audit rule.
I.e. if /var/spool/mail does not exist, you cannot watch
/var/spool/mail/hallyn.  If you have an active rule for
/var/spool/mail/hallyn and you rm -rf /var/spool/mail, the audit rule is
implicitly deleted.  If you then recreate /var/spool/mail, and touch
/var/spool/mail/hallyn, you get no audit entries.

> > It labels the parent
> > inode, so if /var/spool/mail doesn't exist, and you look up
> > /var/spool/mail/hallyn, you won't get an audit record. 
> 
> 
> >  You'd have to do
> > that by auditing all open syscalls at the syscall level.
> 
> That's a wrong assumption. There is one level below the syscall level as

What is the wrong assumption?  That it has to be "at the syscall level"?
Ok, it has to be done at syscall entry or exit, if you prefer.  Using
syscall auditing, catching all fs events, and grepping with ausearch.

> well in Linux, and that is where you need to audit for this, and afaik
> audit actually does that.

Nope.

-serge
