Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVC3XSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVC3XSM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262557AbVC3XSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:18:11 -0500
Received: from pat.uio.no ([129.240.130.16]:52108 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262552AbVC3XRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:17:51 -0500
Subject: Re: [RFC] Add support for semaphore-like structure with support
	for asynchronous I/O
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20050330143409.04f48431.akpm@osdl.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	 <20050330143409.04f48431.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 18:17:43 -0500
Message-Id: <1112224663.18019.39.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.763, required 12,
	autolearn=disabled, AWL 1.24, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 30.03.2005 Klokka 14:34 (-0800) skreiv Andrew Morton:

> > Anyhow, the following is a simple implementation of semaphores designed
> > to satisfy the needs of those I/O subsystems that want to support
> > asynchronous behaviour too. Please comment.
> > 
> 
> So I've been staring at this code for a while and I Just Don't Get It.  If
> I want some custom callback function to be called when someone does an
> iosem_unlock(), how do I do it?

I haven't added support for arbitrary callback functions. It is quite
possible to expand the interfaces to do so should someone need that
functionality, however my current needs only dictate that I be able to
grant the iosem token to a workqueue item, then schedule that work for
execution by keventd.

This is required in order to allow threads such as rpciod or keventd
itself (for which sleeping may cause deadlocks) to ask the iosem manager
code to simply queue the work that need to run once the iosem has been
granted. That work function is then, of course, responsible for
releasing the iosem when it is done.

> Or have I misunderstood the intent?  Some /* comments */ would be appropriate..

Will do.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

