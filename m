Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267840AbUJMJRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267840AbUJMJRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 05:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUJMJRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 05:17:15 -0400
Received: from canuck.infradead.org ([205.233.218.70]:3091 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S267840AbUJMJRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 05:17:07 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@infradead.org>
To: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
Cc: dhowells <dhowells@redhat.com>, rusty@ozlabs.au.ibm.com,
       Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097626296.4013.34.camel@localhost.localdomain>
References: <1096544201.8043.816.camel@localhost.localdomain>
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
	 <1097626296.4013.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 13 Oct 2004 10:16:33 +0100
Message-Id: <1097658993.5178.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 (2.0.1-4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-13 at 10:11 +1000, Rusty Russell (IBM) wrote:
> Here's the level of paranoia required for the simplest case, that of
> signing the entire module.  The last Howells patches I saw didn't even
> do any of *this*, let alone checking the rest of the module:

It's work in progress, and from my limited and third-hand understanding
of what went on before this thread became public, you seemed to be
railing against the _concept_ not against the implementation.

We agree that the checks you cite are required. In fact we should have
been doing a lot of these checks even _before_ we thought about signing
modules.

That said, I think it was perfectly reasonable for David to leave the
implementation of this level of paranoia till last, after working out
the details of how the signatures actually work.

After all, until the precise signature scheme is agreed upon we don't
really know how much of the ELF we should be paranoid about, and how
much we can trust because it's signed.

In David's original scheme, the signature covered only the relevant
parts of the module, so it survives the removal of debug info, and it
survives the further 'strip' it gets on being put into an initrd -- but
the signature _doesn't_ survive anything which would actually change
what happens when the module is loaded.

If your objection to that is purely on the perfectly reasonable grounds
that we're overly trusting of what could be invalid ELF, and could kill
us before we actually get to checking the signature, we can just wait
for him to complete what he's working on at the moment and all will
presumably be well.

I had the impression you were rabidly against any scheme which didn't
sign the _whole_ module, irrelevant parts and all.

-- 
dwmw2

