Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262838AbVAKTRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262838AbVAKTRc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbVAKTRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:17:32 -0500
Received: from pat.uio.no ([129.240.130.16]:52121 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262838AbVAKTRK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:17:10 -0500
Subject: Re: make flock_lock_file_wait static
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Arjan van de Ven <arjan@infradead.org>
Cc: viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1105432299.3917.11.camel@laptopd505.fenrus.org>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
	 <1105345168.4171.11.camel@laptopd505.fenrus.org>
	 <1105346324.4171.16.camel@laptopd505.fenrus.org>
	 <1105367014.11462.13.camel@lade.trondhjem.org>
	 <1105432299.3917.11.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 11 Jan 2005 14:16:44 -0500
Message-Id: <1105471004.12005.46.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 8BIT
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=0, required 12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 11.01.2005 Klokka 09:31 (+0100) skreiv Arjan van de Ven:
> On Mon, 2005-01-10 at 09:23 -0500, Trond Myklebust wrote:
> > må den 10.01.2005 Klokka 09:38 (+0100) skreiv Arjan van de Ven:
> > >  
> > > > is "sooner or later" and "maybe someone else uses it" worth making
> > > > everyone elses kernel bigger by 500 bytes of code ?
> > > 
> > > eh 60 not 500; sorry need coffee
> > 
> > It's an API that provides *necessary* functionality for those
> > filesystems that wish to override the standard flock(). It was very
> > recently introduced by a third party, so we haven't had time to code up
> > an NFS flock yet.
> 
> where "recently" is last september....
> bloating the kernel unused since then...

Feel free to help out if you think the NFS development effort is
understaffed.

> If it is going to take a LOT longer though I still feel it's wrong to
> bloat *everyones* kernel with this stuff.
> 
> (you may think "it's only 100 bytes", well, there are 700+ other such
> functions, total that makes over at least 70Kb of unswappable, wasted
> memory if not more.)

A list of these 700+ unused exported APIs would be very useful so that
we can deprecate and/or get rid of them.


Concerning this case, though, and to make what I said in the earlier
mails (a lot) more explicit.

If you unexport flock_lock_file_wait(), then you might as well back out
the entire bloody ->flock() changeset instead because keeping the
->flock() VFS override support without the functionality to make
implementation practical (which is what you appear to want to do) is a
waste of more than 70 bytes of memory.

Now please go and figure out what it is you actually want to do here.

Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

