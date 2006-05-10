Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964869AbWEJJFE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964869AbWEJJFE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964870AbWEJJFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:05:04 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:50366 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964869AbWEJJFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:05:03 -0400
Date: Wed, 10 May 2006 05:04:57 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Matheus Izvekov <mizvekov@gmail.com>
cc: Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
In-Reply-To: <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0605100501450.556@gandalf.stny.rr.com>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
 <305c16960605092014t240ece2ob620264501deaa39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 May 2006, Matheus Izvekov wrote:

> On 5/9/06, Daniel Walker <dwalker@mvista.com> wrote:
> > unsigned long may not always be 32 bits, right ? This patch fixes the
> Incorrect, its defined as 32bits for every standard C compiler

Nope, I believe that long is always suppose to be big enough to hold a
pointer.  So if you have 64 bit pointers, long needs to be 64 bits.  That
way it is always safe to do:

void *func(void *p) {
	unsigned long l = (unsigned long)p;

	/* do stuff with l */

	p = (void*)l;
	return p;
}

-- Steve


