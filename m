Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUBKLyJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 06:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264288AbUBKLyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 06:54:02 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:11786 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S264278AbUBKLxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 06:53:35 -0500
Date: Wed, 11 Feb 2004 10:10:27 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alex Pankratov <ap@swapped.cc>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.6] [1/2] hlist: replace explicit checks of hlist fields w/ func calls
Message-ID: <20040211121027.GG13619@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alex Pankratov <ap@swapped.cc>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <4029CB7B.3090409@swapped.cc> <20040213231407.208204c4.ak@suse.de> <4029D267.40307@swapped.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4029D267.40307@swapped.cc>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 10, 2004 at 10:57:43PM -0800, Alex Pankratov escreveu:
> 
> 
> Andi Kleen wrote:
> 
> >On Tue, 10 Feb 2004 22:28:11 -0800
> >Alex Pankratov <ap@swapped.cc> wrote:
> >
> >
> >>Second patch removes if's from hlist_xxx() functions. The idea
> >>is to terminate the list not with 0, but with a pointer at a
> >>special 'null' item. Luckily a single 'null' can be shared
> >>between all hlists _without_ any synchronization, because its
> >>'next' and 'pprev' fields are never read. In fact, 'next' is
> >>not accessed at all, and 'pprev' is used only for writing.
> >
> >I disagree with this change. The problem is that in a loop
> >you need a register now to store the terminating element
> >and compare to it instead of just testing for zero. This can generate 
> >much worse code  on register starved i386 than having the conditional.
> 
> Ugh, yeah, I thought about this. However my understand was that
> since hlist_null is statically allocated variable, its address
> will be a known constant at a link time (whether it's a static
> link or dynamic/run-time link - btw, excuse my lack of proper
> terminology here). So comparing something to &null would be
> equivalent to comparing to the constant and not require an
> extra register.

That is why I was going to generate the code to see the instructions
used with your patch when I was captured by my lovely wife... 8)

- Arnaldo
