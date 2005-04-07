Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVDGIAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVDGIAg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262168AbVDGIAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:00:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:42114 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262201AbVDGH7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:59:44 -0400
Date: Thu, 7 Apr 2005 00:58:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: johnpol@2ka.mipt.ru
Cc: guillaume.thouvenin@bull.net, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: Re: connector is missing in 2.6.12-rc2-mm1]
Message-Id: <20050407005852.36a1264b.akpm@osdl.org>
In-Reply-To: <1112860419.28858.76.camel@uganda>
References: <1112859412.18360.31.camel@frecb000711.frec.bull.fr>
	<1112860419.28858.76.camel@uganda>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
>
> > > >  I don't see the connector directory in the 2.6.12-rc2-mm1 tree. So it
> > > > seems that you removed the connector?
> > > 
> > > Greg dropped it for some reason.  I think that's best because it needed a
> > > significant amount of rework.  I'd like to see it resubitted in totality so
> > > we can take another look at it.
> 
> Hmm, what exactly do you think _must_ be changed?

The stuff we discussed.

Plus, I'm still quite unsettled about the whole object lifecycle
management, refcounting and locking in there.  The fact that the code is
littered with peculiar barriers says "something weird is happening here",
and it remains unobvious to me why such a very common kernel pattern was
implemented in such an unusual manner.

So.  I'd like to see the whole thing reexplained and resubmitted so we can
think about it all again.

> Most of your comments are addressed in 4 patches I sent to you and Greg.

Which comments were not addressed?

> Others [mostly atomic allocation] are API extensions and will be added.

I would like to see that code before committing to merging anything.

> There also not included flush on callback removal.
>
> > > It's a new piece of core kernel infrastructure and the barriers for that
> > > are necessarily high.
> > > 
> > > > Will you include it again in futur
> > > > release? At the same time, will you include the fork connector?
> > > 
> > > I could put the fork connector into -mm, but would like to be convinced
> > > that it's acceptable to and useful for all system accounting requirements,
> > > not just the one project.  That means code, please.
> 
> SuperIO and kobject_uevent are also dropped as far as I can see.
> 
> Acrypto is being reviewed but it also depends on it, although 
> it takes to much time, probably will be dropped too.
> 
> Proper w1 notification also requires connector.

Guillaume was referring to "fork connector", not to "connector".
