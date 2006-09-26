Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWIZInP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWIZInP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 04:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWIZInP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 04:43:15 -0400
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:7354 "EHLO
	mtagate4.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1750705AbWIZInN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 04:43:13 -0400
In-Reply-To: <Pine.LNX.4.64.0609231619220.27459@blonde.wat.veritas.com>
Subject: Re: score-boarding [was Re: [PATCH] Linux Kernel Markers]
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 7.0.1 July 03, 2006
Message-ID: <OFD1FB1C34.F6D155B5-ON802571F5.002E016F-802571F5.002FE50E@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 26 Sep 2006 09:43:08 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 26/09/2006 09:45:30
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hugh Dickins <hugh@veritas.com> wrote on 23/09/2006 16:34:33:

> On Thu, 21 Sep 2006, Richard J Moore wrote:
> >
> > It can for another reason - score-boarding: that's where a byte being
> > stored assumes intermediate values due to the bits not being set
> > simultaneously. Generally this doesn't cause a problem because data
across
> > processors is serialised for update by mutexes. However, when applied
to
> > code all sorts of interesting instructions can execute before the bits
> > settle down. I haven't heard of this troubling Intel, but it does occur
on
> > some current architectures.
>
> I'd not heard of this phenomenon, and it worries me.  There are places
> in kernel code where we peek at some volatile variable (perhaps a long)
> without locking, and expect to see it in any one of several well-defined
> states.  Are you saying that there are architectures supported by Linux,
> on which we might see an "impossible" mix of states, due to
score-boarding?
>
> Hugh


These things tend not to be discussed in specific detail in the processor
reference manuals. If there are exposures they are generally covered by
blanket statements about the need to ensure correct serialization between
processors when reading from, and writing to, the same location. As far as
I am aware Linux is protected from such affects because we do use locks, or
serializing instructions, to protect the updating of variables that are
accessed by multiple processors. My guess is that the exposure to
score-boarding, if it exists at all, tends to be limited to concurrent
bitwise operations.

Richard

