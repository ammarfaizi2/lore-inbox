Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbUFCG6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUFCG6I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261396AbUFCG6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:58:08 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:46799 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S261389AbUFCG4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:56:06 -0400
Date: Thu, 3 Jun 2004 08:55:21 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Pavel Machek <pavel@suse.cz>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>,
       Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] explicitly mark recursion count
Message-ID: <20040603065521.GA20977@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0406011255070.14095@ppc970.osdl.org> <20040602131623.GA23017@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406020712180.3403@ppc970.osdl.org> <Pine.LNX.4.58.0406020724040.22204@bigblue.dev.mdolabs.com> <20040602182019.GC30427@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0406021124310.22742@bigblue.dev.mdolabs.com> <20040602185832.GA2874@wohnheim.fh-wedel.de> <20040602193720.GQ12308@parcelfarce.linux.theplanet.co.uk> <20040602194515.GA4477@wohnheim.fh-wedel.de> <20040602195944.GR12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040602195944.GR12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 June 2004 20:59:44 +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > 
> > Ok.  Would it be ok to use the following then?
> > 
> > b1. Function pointer are passed as arguments to functions and
> > b2. those pointer are called directly from the function, they are
> >     passed to.
> 
> Again not guaranteed to be true - they can be (and often are) passed further.

Hmm.  If that happens, I'm out of ideas for now.  Cannot do more than
give a warning.

> Moreover, they are also stored untyped in structures.  Common pattern
> is
> 	foo.callback = f;
> 	foo.argument = p;
> 	iterate_over_blah(blah, &foo);
> 
> Note that here f is the only thing that will see the value of p _and_ the
> only thing that cares about type of p.  iterator itself doesn't care and
> can be used for different types.

Those cases I should already catch.  If foo is of type "struct bar",
"bar.callback" will be the function name for a pseudo-function.  That
function is called by iterate_over_blah and calls f.  Unnamed struct
get a name made up from the components of the struct, like
____FAKE.Name.Chip.stat.Regi.LILP.Opti.high.lowe->ProcessIMQEntry.
Doesn't look pretty, but works.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
