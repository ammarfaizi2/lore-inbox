Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272219AbTHRSVP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHRSVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:21:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:1472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272219AbTHRSVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:21:14 -0400
Date: Mon, 18 Aug 2003 11:21:07 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix up riscom8 driver to use work queues instead of task queueing.
In-Reply-To: <20030818180941.GJ24693@gtf.org>
Message-ID: <Pine.LNX.4.44.0308181117540.5929-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 18 Aug 2003, Jeff Garzik wrote:
> 
> Should we just make schedule_delayed_work(foo, 1) the default for a 
> schedule_work() call?

Why? There are cases where you may really want to get the work done asap,
so the regular "schedule_work()" is the right thing. While the "delayed"  
thing is for stuff that explicitly doesn't want to happen immediately,
because we expect to aggregate more into it.

Having done a few serial drivers (not because I want to, but because 
nobody else seems to be doing them), I definitely see the need for both. 

For example, the hangup case wants to be done asap, not delayed.

		Linus

