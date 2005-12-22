Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbVLVSez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbVLVSez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 13:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbVLVSey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 13:34:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46389 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1030257AbVLVSer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 13:34:47 -0500
Date: Thu, 22 Dec 2005 13:34:46 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 00/10] mutex subsystem, -V5
In-reply-to: <Pine.LNX.4.62.0512221003540.7992@schroedinger.engr.sgi.com>
X-X-Sender: nico@localhost.localdomain
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Message-id: <Pine.LNX.4.64.0512221328040.26663@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20051222153717.GA6090@elte.hu>
 <Pine.LNX.4.64.0512221134150.26663@localhost.localdomain>
 <Pine.LNX.4.64.0512220941320.4827@g5.osdl.org>
 <Pine.LNX.4.62.0512221003540.7992@schroedinger.engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Dec 2005, Christoph Lameter wrote:

> I would like some more flexible way of dealing with locks in general. The
> code for the MUTEXes seems to lock us into a specific way of realizing 
> locks again.

Yes, and that's what I'm attempting to prevent.

The low-level locking mechanism for mutexes needs to have the weakest 
(and simplest) semantics possible without compromising the generic code 
from doing its job.  Setting on a strict pure atomic decrement (the 
strictest semantic) or an atomic swap (better but still a tiny bit 
stricter than necessary) is not required for proper mutex support with 
the current core code.


Nicolas
