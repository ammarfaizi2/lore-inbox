Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422805AbWGJUWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422805AbWGJUWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422804AbWGJUWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:22:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12744 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422710AbWGJUWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:22:42 -0400
Date: Mon, 10 Jul 2006 13:22:28 -0700
From: Jeremy Higdon <jeremy@sgi.com>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, "Luck, Tony" <tony.luck@intel.com>,
       John Daiker <jdaiker@osdl.org>, John Hawkes <hawkes@sgi.com>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>
Subject: Re: [PATCH] ia64: change usermode HZ to 250
Message-ID: <20060710202228.GA732959@sgi.com>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com> <yq04py4i9p7.fsf@jaguar.mkp.net> <1151578928.23785.0.camel@localhost.localdomain> <44A3AFFB.2000203@sgi.com> <1151578513.3122.22.camel@laptopd505.fenrus.org> <20060708001427.GA723842@sgi.com> <1152340963.3120.0.camel@laptopd505.fenrus.org> <ed5aea430607080607u67aeb05di963243c0e653e4f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed5aea430607080607u67aeb05di963243c0e653e4f0@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 07:07:14AM -0600, David Mosberger-Tang wrote:
> Nothing is broken.  Read Alan's statement carefully...
> 
>  --david

His statement can be read a couple of ways.

Let's go over the choices.

First, the background.  Some apps are using the HZ definition in
/usr/include/asm/param.h to get the system's HZ value.  That is a
bug in the app -- everyone agrees.

Currently, on IA64, HZ is defined to be 1024, which is incorrect
for newer kernels.

Options:

1. Change to 250, which will be correct for most distributions as
   well as the default IA64 kernel

2. Leave at 1024, which is wrong for everything

3. Change to sysconf(_SC_CLK_TCK) so that apps get the right thing

4. Change to something that produces a build error to indicate to app
   maintainer that he needs to fix something.

5. Change kernel to make it compatible with old apps that think
   system HZ is 1024.

Currently, the option chosen is (3).  It doesn't seem like the best
option to me -- maybe the worst, actually.  I would like to see at
least one explanation as to why it's been chosen.

jeremy

> On 7/8/06, Arjan van de Ven <arjan@infradead.org> wrote:
> >
> >
> >> So does i386 convert the return value of the times(2) call to user
> >> hertz?  On IA64, it returns the value in internal clock ticks, and
> >> then when a program uses the value in param.h, it gets it wrong now,
> >> because internal HZ is now 250.
> >>
> >> So is times() is broken in IA64, or is this an exception to Alan's
> >> statement?
> >
> >yes it's broken; it needs to convert it to the original HZ (1024) and
> >make the sysconf() function also return 1024
