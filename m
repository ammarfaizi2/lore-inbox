Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUHETOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUHETOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267889AbUHESbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:31:11 -0400
Received: from fmr06.intel.com ([134.134.136.7]:10910 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267872AbUHESRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:17:43 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Thu, 5 Aug 2004 11:16:58 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F93C3@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR6vIVt8BAFax3dSTi8cjRXW57zeQAWm65w
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Andrew Morton" <akpm@osdl.org>, "Ulrich Drepper" <drepper@redhat.com>
Cc: <linux-kernel@vger.kernel.org>, <robustmutexes@lists.osdl.org>,
       <rusty@rustcorp.com.au>, <mingo@elte.hu>, <jamie@shareable.org>
X-OriginalArrivalTime: 05 Aug 2004 18:16:59.0296 (UTC) FILETIME=[65F14A00:01C47B18]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andrew Morton [mailto:akpm@osdl.org]
> 
> Ulrich Drepper <drepper@redhat.com> wrote:
> >
> > Andrew Morton wrote:
> >
> > > This fixes what appear to be some fairly significant shortcomings.  What do
> > > the futex and NPTL people have to say about the gravity of the problems
> > > which this solves, and the offered implementation?
> >
> > This code will not be suppoerted by the glibc code.  Using these
> > primitives would mean significant slowdown of all operations and this
> > for problems which only a few people have.
> 
> How large is the slowdown, and on what workloads?

10% on volanomark, as well in some other conditional variable stress
tests we have been conducting. For the conditional variable one we have
an initial proof of concept optimization that we'll try in a couple weeks
[I am going on vacation next week].

> >  I asked to get the useful
> > parts of the code to be made available using the current futex interface
> > (robust mutexes are useful)
> 
> Passing the lock to a non-rt task when there's an rt-task waiting for it
> seems pretty poor form, too.

???? That never happens in fusyn [unless there is a bug]. The next guy who 
gets the lock if it is being passed (or is woken up) is always the highest 
priority one.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
