Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWDXNRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWDXNRU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 09:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750793AbWDXNRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 09:17:20 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29655 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750788AbWDXNRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 09:17:19 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Olivier Galibert <galibert@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
       Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060424130949.GE9311@sergelap.austin.ibm.com>
References: <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424124556.GA92027@dspnet.fr.eu.org>
	 <1145883251.3116.27.camel@laptopd505.fenrus.org>
	 <20060424130949.GE9311@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 15:16:59 +0200
Message-Id: <1145884620.3116.33.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 08:09 -0500, Serge E. Hallyn wrote:
> Quoting Arjan van de Ven (arjan@infradead.org):
> > for all such things in the first place. In fact, we already know that to
> > do auditing, LSM is the wrong thing to do (and that's why audit doesn't
> > use LSM). It's one of those fundamental linux truths: Trying to be
> 
> As I recall it was simply decided that LSM must be "access control
> only", and that was why it wasn't used for audit.

no you recall incorrectly.
Audit needs to audit things that didn't work out, like filenames that
don't exist. Audit needs to know what is going to happen before the
entire "is this allowed" chain is going to be followed. SELInux and
other LSM parts are just one part of that chain, and there's zero
guarantee that you get to the LSM part in the chain.....  Now of course
you could add hooks at places where audit puts them now, and call those
"LSM" but that'd just be artificial, pointless and bad design.


> Didn't Linda Walsh claim a much faster audit implementation using LSM
> than the current lightweight audit framework?

People can claim the world; the problem is that you can't make a tight
audit with LSM because of all the namespace issues (AppArmor can evade
those by locking stuff down, audit obviously cannot). So I highly doubt
the validity of such claim.
Audit also HAS to tie into some other places to avoid having to
double-copy on the userspace filename data, at which point you're not
really using LSM, you're just hijacking some of it's hooks.
[and you have to avoid such double copy for your audit to be reliable
enough to mean something]

