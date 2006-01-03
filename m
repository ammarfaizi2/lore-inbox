Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWACXNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWACXNe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 18:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964910AbWACXNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 18:13:06 -0500
Received: from mail.suse.de ([195.135.220.2]:36518 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964871AbWACXNA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 18:13:00 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] [RFC] Optimize select/poll by putting small data sets on the stack
Date: Wed, 4 Jan 2006 00:13:44 +0100
User-Agent: KMail/1.8
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200601032158.14057.ak@suse.de> <43BAF72C.2030608@cosmosbay.com> <43BB03A7.3090604@cosmosbay.com>
In-Reply-To: <43BB03A7.3090604@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601040013.44249.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 00:07, Eric Dumazet wrote:
> Eric Dumazet a écrit :
> > Andi Kleen a écrit :
> >> This is a RFC for now. I would be interested in testing
> >> feedback. Patch is for 2.6.15.
> >>
> >> Optimize select and poll by a using stack space for small fd sets
> >>
> >> This brings back an old optimization from Linux 2.0. Using
> >> the stack is faster than kmalloc. On a Intel P4 system
> >> it speeds up a select of a single pty fd by about 13%
> >> (~4000 cycles -> ~3500)
> >
> > Was this result on UP or SMP kernel ? Preempt or not ?
> >
> > I think we might play in do_pollfd() and use fget_light()/fput_light()
> > instead of fget()/fput() that are somewhat expensive because of atomic
> > inc/dec on SMP.
>
> Just for completeness I include this patch against 2.6.15

Looks like a good idea.

-Andi
