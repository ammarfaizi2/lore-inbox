Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760553AbWLFMT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760553AbWLFMT7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 07:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760551AbWLFMT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 07:19:59 -0500
Received: from amsfep17-int.chello.nl ([62.179.120.12]:31549 "EHLO
	amsfep17-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760566AbWLFMT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 07:19:57 -0500
Subject: Re: 2.6.19-rc5-mm1 progression
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Andrew Morton <akpm@osdl.org>, Benoit Boissinot <bboissin@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <4574E86B.10403@lwfinger.net>
References: <456718F6.8040902@lwfinger.net>
	 <40f323d00611240836q6bcf7374gd47c7a97d1d4f8e3@mail.gmail.com>
	 <20061125112437.3d46eff4.akpm@osdl.org>  <4574E86B.10403@lwfinger.net>
Content-Type: text/plain
Date: Wed, 06 Dec 2006 13:12:50 +0100
Message-Id: <1165407170.12561.12.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 21:32 -0600, Larry Finger wrote:
> Andrew Morton wrote:
> > On Fri, 24 Nov 2006 17:36:27 +0100
> > "Benoit Boissinot" <bboissin@gmail.com> wrote:
> > 
> >> On 11/24/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> >>> Is there the equivalent of 'git bisect' for the -mmX kernels?
> >>>
> >> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> >>
> > 
> > Please take the time to do that.  Yours is an interesting report - I'm not
> > aware of anything in there which was expected to cause a change of this
> > mature.
> > 
> 
> There are at least two patches in 2.6.19-rc5-mm2 that make my system much more responsive for 
> interactive jobs. The one that has the majority of the effect is:
> 
> radix-tree-rcu-lockless-readside.patch
> 
> I have not been able to isolate the second patch, which has the lesser effect. All I can say is that 
> it occurred before the above patch in patches/series. This patch was tested against 2.6.19 and fixed 
> most of the problem on that version.

Curious...

This patch introduces the direct pointer optimisation for single element
radix trees and makes the radix tree safe to read in a lock-less manner
which is not used -yet-. The only difference that that should have is
that the elements are freed using rcu callback instead of directly.

/me puzzled how this has a large effect on interactivity.

Nick?

