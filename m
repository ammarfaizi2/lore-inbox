Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVKEJvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVKEJvI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 04:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbVKEJvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 04:51:08 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:24325 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751326AbVKEJvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 04:51:07 -0500
Date: Sat, 5 Nov 2005 17:50:19 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Jeff Moyer <jmoyer@redhat.com>
cc: autofs@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [autofs] Re: autofs4 looks up wrong path element when ghosting
 is enabled
In-Reply-To: <Pine.LNX.4.63.0510312119320.2069@donald.themaw.net>
Message-ID: <Pine.LNX.4.63.0511051737390.29492@donald.themaw.net>
References: <17200.23724.686149.394150@segfault.boston.redhat.com>
 <Pine.LNX.4.58.0509210916040.26144@wombat.indigo.net.au>
 <17203.7543.949262.883138@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509241644420.2069@donald.themaw.net>
 <17205.48192.180623.885538@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0509250918150.2191@donald.themaw.net>
 <17208.24786.729632.221157@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0510152006340.30122@donald.themaw.net>
 <17238.45372.628520.739194@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0510291536320.2949@donald.themaw.net>
 <17254.252.746357.935671@segfault.boston.redhat.com>
 <Pine.LNX.4.63.0510312119320.2069@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Ian Kent wrote:

> On Mon, 31 Oct 2005, Jeff Moyer wrote:
> 
> > ==> Regarding Re: autofs4 looks up wrong path element when ghosting is enabled; Ian Kent <raven@themaw.net> adds:
> > 
> > raven> So to resolve this we need to ignore negative and unhashed dentries
> > raven> when checking if directory dentry is empty.
> > >>
> > raven> Please test this patch and let me know how you go.
> > >> OK, I've finally got 'round to testing your patch.  It does fix the test
> > >> case I was using.  My only concern is the potential for regressions.
> > >> I'll try making sure all of my various maps still work as advertised.
> > 
> > raven> I've spotted a regression with this patch.  It doesn't stop autofs
> > raven> from appearing to function correctly. It causes mount callbacks when
> > raven> they shouldn't made. So it seems that there is a case when an autofs
> > raven> directory is, as yet unhashed, but should be used.
> > 
> > I'm not sure I follow.  What do you mean it doesn't stop autofs from
> > *appearing* to function correctly?  Do you have a reproducer that fails?
> 
> Any pseudo direct map will produce the behaviour.
> 
> It behaves as if the ghost option was not specified even when it has. 
> This is because the altered test for an empty directory is always 
> returning true even though the directory isn't empty.
> 
> I'm still trying to understand why this happens. In theory it's just not 
> the expected behaviour. I must be missing something in the directory 
> creation. I've been here before and looked several times and I just can't 
> see why it happens this way.

I couldn't work out why this patch shouldn't work so I tried to duplicate 
the problem I saw before and I can't.

I've tested the patch against autofs-4.1.3-123 (latest source rpm I could 
find) and autofs-4.1.4-8 with a couple of my patches (only on the 4.1.4 
version) that shouldn't affect it and I can't seem to break it.

I must have got my kernel modules mixed up. It probably means there's some 
backward compatibilty work to be done on the version 5 module.

Anyway, some more testing, as you suggested, would be great.

The only other question is what to do about the cacheing of mount failures 
which has never worked by the look of it. We can remove it or fix it.

Ian



