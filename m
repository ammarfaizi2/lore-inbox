Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269523AbUJLIgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbUJLIgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 04:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269524AbUJLIgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 04:36:50 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:63882 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S269523AbUJLIgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 04:36:47 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@infradead.org>
To: "Rusty Russell (IBM)" <rusty@au1.ibm.com>
Cc: David Howells <dhowells@redhat.com>, rusty@ozlabs.au.ibm.com,
       Greg KH <greg@kroah.com>, Arjan van de Ven <arjanv@redhat.com>,
       Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097534090.16153.7.camel@localhost.localdomain>
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
Content-Type: text/plain
Message-Id: <1097570159.5788.1089.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 12 Oct 2004 09:35:59 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 08:34 +1000, Rusty Russell (IBM) wrote:
> Welcome to the debate David.  I agree that you only need to sign the
> things that the kernel looks at, unfortunately, there's not a nice clear
> line: for example the headers change when you strip the module, and they
> need to be signed.

First you agree that we only need to sign the things the kernel looks
at, but then you seem to be saying we need to sign _all_ of the headers.
That isn't consistent, surely? 

Think of it as canonicalising the module before we sign it.
Conceptually, we strip the module and make a signature on the bits which
are actually _relevant_, not on the fluff. It's just that we want to do
what while being able to leave the debug information and all the
irrelevant symbols etc. in place in the object file.

We know _precisely_ what the kernel looks at -- we wrote its linker. It
really isn't that hard.

> Trying to work around it just gets you into more and more complexity:
> you can't trust the module until you've checked the signature, and when
> you don't trust the module you have to write paranoid code, which is
> very ugly and causes bloat.  David Howells just sidestepped this and
> trusted the module headers, and so I refused his patch.

If there's something specific which he wasn't checking which could
actually make a _real_ difference to the module once it's loaded and
linked, please point it out.

Trusting _just_ the headers doesn't seem to make sense, I agree --
surely you actually want to include the contents of the text and data
sections in your signature? Are you saying David didn't do that? That
would want fixing, obviously. But it doesn't mean that we should be
signing the _whole_ of the object file, irrelevant parts and all.

> Nor do I have to re-iterate the points from the discussion for someone
> who hasn't bothered reading it.  But I did.

Sorry, I didn't think the discussion had been in public. While I'm sure
I _could_ read mail in David's inbox, I feel it would be somewhat
impolite. It's not that I "haven't bothered". :)

-- 
dwmw2


