Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWDVUxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWDVUxK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 16:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWDVUxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 16:53:09 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:15320 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751186AbWDVUxI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 16:53:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bv+iY3Vf6ZIDQY5s22XgXBa8zcdwsLchWCyfJvoVk9HTEB+EEt2V3f0rcs9nGICnA+2Poe/C1UDZ43+jnEK5VKp+goP3T3W2GnOljbzDD36cVeMaB+V1A6r5yKz1WA9mxWaEKv1SaPUK5aE985q1E1cRJ1T4XTr+1HZWwR37YZU=
Message-ID: <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
Date: Sat, 22 Apr 2006 13:52:57 -0700
From: "Ken Brush" <kbrush@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Cc: "Crispin Cowan" <crispin@novell.com>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Greg KH" <greg@kroah.com>,
       "James Morris" <jmorris@namei.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Andrew Morton" <akpm@osdl.org>, "Stephen Smalley" <sds@tycho.nsa.gov>,
       "T?r?k Edwin" <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, "Chris Wright" <chrisw@sous-sol.org>,
       "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200604021240.21290.edwin@gurde.com>
	 <20060417195146.GA8875@kroah.com>
	 <1145309184.14497.1.camel@localhost.localdomain>
	 <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
	 <4445484F.1050006@novell.com>
	 <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
	 <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Fri, 21 Apr 2006 08:23:51 PDT, Ken Brush said:
> > On 4/20/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > > On Wed, 19 Apr 2006 17:19:04 PDT, Crispin Cowan said:
> > > > Valdis.Kletnieks@vt.edu wrote:
> > > The threat model is that you can take a buggy application, and constrain its
> > > access to priv A in a way that causes a code failure that allows you to abuse
> > > an unconstrained priv B.
> >
> > So you are talking about a 2 prong attack. One in where you somehow
> > trick program A to do something that it's allowed to. That then would
> > cause an error in program B ? Or cause program B to do something
> > wonky.
>
> No, it's a two prong attack against *one* program.  For instance, the Sendmail
> bug - the attack A was to cripple its ability to drop privs, which then exposed
> it to abuse B of running at a higher priv than it should have.
>
> The crucial point here is that the attacker is trying to gain access to
> (for instance) the ability to write to any file, but gets there by crippling
> some *other* priv.
>

It's nearly impossible for an access control mechanism to analyze a
program and figure out what it's trying to do.  The whole program
would be constrained with what it would be allowed to do in it's
entirety.  Systems like postfix can be constrained more effectively,
since each individual program would have a tighter policy on what it
can do.

If you can point me to an access control mechanism that could stop
what you describe, I would be very interested in it.

> Another (totally made up theoretical, hopefully) Sendmail-ish example would be
> to artificially constrain it's ability to open port 25 for listening, and then
> using a symlink attack to redirect its complaint "I can't open 25" to trash
> some file you can't read/write yourself....
>
> The reason that this is such a can-of-worms security wise is that the vast majority
> of programs have *not* had sufficient auditing of their error-handling code.
> As a result, blindly applying a privilege constraint to clip off some priv A
> that the policy writer doesn't think is needed can "load a round in the chamber"
> for a clever attacker to abuse.

This is where you try to cover these mistakes with compiler tools like
Propolice.

> (Note that this concern applies equally to AppArmor and SELinux and almost any
> other constraint-based system.  It's merely more *likely* to bite AppArmor
> based systems, because it's marketing itself as "user/sysadmin friendly" - and
> thus more likely to attract people trying to secure their system without real
> understanding.  You don't get many problems with SELinux down this path,
> because most SELinux people already have a mindset that "Even with proper
> tools, writing a policy is hard and requires some careful thought/analysis"...)

So, because SELinux is harder to configure. When it's exploited no one
is surprised?
Or what is your exact argument?

That sysadmins are not sophisticated enough to properly configure the
MAC systems AppArmor and SELinux effectively? Or that people who use
AppArmor are not likely to put careful thought into the policies that
they use?

-Ken
