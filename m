Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267522AbUJOAro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267522AbUJOAro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 20:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267651AbUJOArn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 20:47:43 -0400
Received: from ozlabs.org ([203.10.76.45]:13532 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S267522AbUJOArk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 20:47:40 -0400
Subject: Re: Fw: signed kernel modules?
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16127.1097751772@redhat.com>
References: <1097707986.14303.36.camel@localhost.localdomain>
	 <1097626296.4013.34.camel@localhost.localdomain>
	 <1096544201.8043.816.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <27277.1097702318@redhat.com>   <16127.1097751772@redhat.com>
Content-Type: text/plain
Message-Id: <1097801271.22673.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 15 Oct 2004 10:47:51 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 21:02, David Howells wrote:
> > I'd prefer to see:
> > 	err = module_verify(hdr, len, &gpgsig_ok);
> > 	if (err)
> > 		goto free_hdr;
> 
> I've been moaned at for doing this before. Other people have told me they
> prefer to see the value returned through the return value since there's enough
> scope.

I suppose this is a matter of taste.  I find it much clearer this way,
to overloading 0 vs 1 returns.

> > And then have module_verify for the !CONFIG_MODULE_SIG case (in
> > module-verify.h) simply be:
> 
> I think it should still check the ELF, even if we're not going to check a
> signature. This permits us to drop a few checks later in the module loading
> process.

Not really: I've never had a single bug report, and I've had a fair
number of bug reports.  Without signed modules, it's really 300 lines of
code for no actual gain.  OTOH, it's going to be in the tree anyway. 
Unless we want to "sign" modules with a straight checksum when
!CONFIG_MODULE_SIG?  I'm not really convinced it's worth it.  Thoughts
welcome.

> > Multiplicative overflow.
> 
> Not so in this ELF incarnation.

Sorry, my bad.

Now we have the code in front of us, I'll ask you to answer honestly. 
Do *you* think that the extra ~600 lines of code is a worthwhile
tradeoff so we can simply strip modules without resigning?  You know my
opinion, but you've done the code, and if you're really convinced of
that, I'll ack it.

(I'm not sure that having a whole GPG format parser in the kernel
matches our minimalistic ideals either, but I can see a much stronger
incentive there: less risk of weakening the signatures, convenience, and
the signing infrastructure can be used for other things).

Cheers,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

