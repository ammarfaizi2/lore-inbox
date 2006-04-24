Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbWDXOId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWDXOId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:08:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDXOId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:08:33 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:35594 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750836AbWDXOIc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:08:32 -0400
Date: Mon, 24 Apr 2006 16:08:31 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lars Marowsky-Bree <lmb@suse.de>,
       Valdis.Kletnieks@vt.edu, Ken Brush <kbrush@gmail.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks)
Message-ID: <20060424140831.GA94722@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lars Marowsky-Bree <lmb@suse.de>, Valdis.Kletnieks@vt.edu,
	Ken Brush <kbrush@gmail.com>, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <4446D378.8050406@novell.com> <200604201527.k3KFRNUC009815@turing-police.cc.vt.edu> <ef88c0e00604210823j3098b991re152997ef1b92d19@mail.gmail.com> <200604211951.k3LJp3Sn014917@turing-police.cc.vt.edu> <ef88c0e00604221352p3803c4e8xea6074e183afca9b@mail.gmail.com> <200604230945.k3N9jZDW020024@turing-police.cc.vt.edu> <20060424082424.GH440@marowsky-bree.de> <1145882551.29648.23.camel@localhost.localdomain> <20060424124556.GA92027@dspnet.fr.eu.org> <1145883251.3116.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145883251.3116.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:54:10PM +0200, Arjan van de Ven wrote:
> 
> > While that may be true[1], it gets a little annoying when broken is
> > meant to be synonymous to "not the SELinux model".  Especially since
> > there are aspects where SELinux' security can be considered broken,
> > complexity being one of them, crappy failure modes being another,
> > handling of new files a third, handling of namespaces a fourth.
> 
> while I agree with the first three arguments, handling of namespaces
> isn't  fundamental SELinux weakness.

I'm not sure.  It's linked to the "new files" problem.
Object-labelling security (be it inodes, attributes, whatever) are
good to protect specific objects, but it sucks on two points:
- new objects can have an incorrect by-default labels
- applications don't address objects directly, but by one of their
  names, the paths

Path-based security does not protect objects, it protects what you
access through the names, whether there are associated objects or not.
So in practice path security protects the behaviour of applications
against mucking with the filesystem, while object labelling protects
the contents of the files.  They're complementary, they need each
other in practice.


> Maybe the question "is the fragility worth it" is a religious question,
> but the fundamental truth is that an inodes approach is by far more
> robust and beyond such "nothing else" statement.

It's more robust at protecting objects contents, it's less robust at
protecting application behaviour.  A lot like GR and QM, the best
model is somewhere in the middle :-)


> Now that there's a second proposed user, the real evaluation of the
> value of LSM can be made in this regard, and if the consensus is that
> it's fixable, the interfaces can be cleaned up to facilitate both
> SELinux and AppArmor. But I don't think you can a priori say that LSM is
> the right answer, given that AppArmor seems to highly struggle with it,
> nor do I think it HAS to be. I rather have separate interfaces for
> AppArmor and SELinux than one, bad, joint interface that everyone hates.

Heh, now I can agree with that.  I'm a lot more annoyed by the
arguments (not by you in particular) that go more or less:
- LSM should be removed because only SELinux uses it
- Any LSM users that is not SELinux is either broken or should be
  implemented as SELinux policies

For now if I follow correctly the LSM interfaces are decent for
object-based policy implementations, and not decent for path-based
ones.  Maybe the object-based policy hooks should be evolving in the
direction of SELinux' comfort, and additional hooks specifically for
path-based policy added, probably along the lines of what AppArmor
needs.  Then hopefully someday someone will build a security system
that uses the best features from both.  But refusing path-based policy
in the kernel for religious reasons would be annoying.

  OG.

