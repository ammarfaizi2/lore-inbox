Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267898AbUHEStH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267898AbUHEStH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267861AbUHESly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:41:54 -0400
Received: from fmr06.intel.com ([134.134.136.7]:52649 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267896AbUHESjr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:39:47 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Date: Thu, 5 Aug 2004 11:39:26 -0700
Message-ID: <F989B1573A3A644BAB3920FBECA4D25A011F93C7@orsmsx407>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Thread-Index: AcR68LEGW4yjhxQmQO6vFOGPJ8pkyQAKYUiA
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Linh Dang" <linhd@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Aug 2004 18:39:27.0248 (UTC) FILETIME=[89627100:01C47B1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Linh Dang
> 
> Ulrich Drepper <drepper@redhat.com> wrote:
> > The fast path for all locking primitives etc in nptl today is
> > entirely at userlevel.  Normally just a single atomic operation with
> > a dozen other instructions.  With the fusyn stuff each and every
> > locking operation needs a system call to register/unregister the
> > thread as it locks/unlocks mutex/rwlocks/etc.  Go figure how well
> > this works.  We are talking about making the fast path of the
> > locking primitives two/three/four orders of magnitude more
> > expensive.  And this for absolutely no benefit for 99.999% of all
> > the code which uses threads.
> >
> 
> Is there an EFFICIENT way to add priority-inheritance to futex? the
> lack of priority-inheritance is biggest headache for RT applications
> running on top of NPTL/kernel-2.6. And there's is a LOT more of us (RT
> users who want to use NPTL/kernel-2.6) than you might think. I guess
> we're just not vocal.

No.

You need the concept of ownership (who do I have to boost?). You need 
spinlocks to be able to traverse the who-is-waiting-for-whom trees
(you might have three guys trying to lock from three different CPUs
plus other guys preempting in the middle and you need to protect those
trees.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
