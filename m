Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWDXMya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWDXMya (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWDXMya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:54:30 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21888 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750743AbWDXMy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:54:29 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: Olivier Galibert <galibert@pobox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060424124556.GA92027@dspnet.fr.eu.org>
References: <4445484F.1050006@novell.com>
	 <200604182301.k3IN1qh6015356@turing-police.cc.vt.edu>
	 <4446D378.8050406@novell.com>
	 <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu>
	 <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com>
	 <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu>
	 <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com>
	 <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu>
	 <20060424082424.GH440@marowsky-bree.de>
	 <1145882551.29648.23.camel@localhost.localdomain>
	 <20060424124556.GA92027@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 14:54:10 +0200
Message-Id: <1145883251.3116.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> While that may be true[1], it gets a little annoying when broken is
> meant to be synonymous to "not the SELinux model".  Especially since
> there are aspects where SELinux' security can be considered broken,
> complexity being one of them, crappy failure modes being another,
> handling of new files a third, handling of namespaces a fourth.

while I agree with the first three arguments, handling of namespaces
isn't  fundamental SELinux weakness.


> Paths vs. inodes is religion, nothing else. 

Actually I think you're wrong on that. Paths are more fragile, even the
AppArmor people will admit that. They just think they can get away with
it by closing a dozen+ ways of cheating with that and by limiting the
scope of the security model. 

Maybe the question "is the fragility worth it" is a religious question,
but the fundamental truth is that an inodes approach is by far more
robust and beyond such "nothing else" statement.

>   LSM was supposed to be inclusive of all
> beliefs, has that changed?

until last week SELinux was the only user of LSM. You can't fault LSM
for not facilitate all the unwritten code that is possible in the world.
And to some degree I would question the feasability of having ONE model
for all such things in the first place. In fact, we already know that to
do auditing, LSM is the wrong thing to do (and that's why audit doesn't
use LSM). It's one of those fundamental linux truths: Trying to be
everything for everyone leads to crappy interfaces.

Now that there's a second proposed user, the real evaluation of the
value of LSM can be made in this regard, and if the consensus is that
it's fixable, the interfaces can be cleaned up to facilitate both
SELinux and AppArmor. But I don't think you can a priori say that LSM is
the right answer, given that AppArmor seems to highly struggle with it,
nor do I think it HAS to be. I rather have separate interfaces for
AppArmor and SELinux than one, bad, joint interface that everyone hates.


