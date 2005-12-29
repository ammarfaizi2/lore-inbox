Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVL2DWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVL2DWN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 22:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964928AbVL2DWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 22:22:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42886 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S964907AbVL2DWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 22:22:12 -0500
Date: Wed, 28 Dec 2005 22:22:09 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 1/3] mutex subsystem: trylock
In-reply-to: <1135685158.2926.22.camel@laptopd505.fenrus.org>
X-X-Sender: nico@localhost.localdomain
To: Arjan van de Ven <arjan@infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-id: <Pine.LNX.4.64.0512282200470.3309@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051223161649.GA26830@elte.hu>
 <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain>
 <1135685158.2926.22.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005, Arjan van de Ven wrote:

> btw I really think that 1) is wrong. trylock should do everything it can
> to get the semaphore short of sleeping. Just because some cacheline got
> written to (which might even be shared!) in the middle of the atomic op
> is not a good enough reason to fail the trylock imho. Going into the
> slowpath.. fine. But here it's a quality of implementation issue; you
> COULD get the semaphore without sleeping (at least probably, you'd have
> to retry to know for sure) but because something wrote to the same
> cacheline as the lock... no. that's just not good enough.. sorry.

Well... actually it is not clear from the documentation how the 
exclusive monitor is tagging accesses (lots of implementation specific 
latitude).  So you are right that it could cause too many false negative 
results.


Nicolas
