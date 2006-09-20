Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWITISm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWITISm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 04:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWITISm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 04:18:42 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:44029 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751041AbWITISl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 04:18:41 -0400
In-Reply-To: <20060920010852.GA7469@in.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers
To: prasanna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, Jes Sorensen <jes@sgi.com>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, ltt-dev@shafik.org,
       Martin Bligh <mbligh@google.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Ingo Molnar <mingo@elte.hu>, systemtap@sources.redhat.com,
       systemtap-owner@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
       William Cohen <wcohen@redhat.com>, Tom Zanussi <zanussi@us.ibm.com>
X-Mailer: Lotus Notes Release 7.0.1 July 07, 2006
Message-ID: <OFD1A61531.0E2D11C4-ON802571EF.002D4111-802571EF.002DA3BC@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Wed, 20 Sep 2006 09:18:30 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.5.5HF607 | June 26, 2006) at
 20/09/2006 09:20:48
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



systemtap-owner@sourceware.org wrote on 20/09/2006 02:08:52:

> Hi Alan,
>
> On Wed, Sep 20, 2006 at 01:08:45AM +0100, Alan Cox wrote:
> > Ar Maw, 2006-09-19 am 13:54 -0400, ysgrifennodd Mathieu Desnoyers:
> > > Very good idea.. However, overwriting the second instruction
> with a jump could
> > > be dangerous on preemptible and SMP kernels, because we never
> know if a thread
> > > has an IP in any of its contexts that would return exactly at
> the middle of the
> > > jump.
> >
> > No: on x86 it is the *same* case for all of these even writing an int3.
> > One byte or a megabyte,
> >
> > You MUST ensure that every CPU executes a serializing instruction
before
> > it hits code that was modified by another processor. Otherwise you get
> > CPU errata and the CPU produces results which vendors like to describe
> > as "undefined".
>
> Are you referring to Intel erratum "unsynchronized cross-modifying code"
> - where it refers to the practice of modifying code on one processor
> where another has prefetched the unmodified version of the code.
>
> Thanks
> Prasanna


In the special case of replacing an opcode with int3 that erratum doesn't
apply. I know that's not in the manuals but it has been confirmed by the
Intel microarchitecture group. And it's not reasonable to it to be any
other way.



- -
Richard J Moore
IBM Advanced Linux Response Team - Linux Technology Centre
MOBEX: 264807; Mobile (+44) (0)7739-875237
Office: (+44) (0)1962-817072

