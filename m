Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264314AbUDOPZm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 11:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUDOPZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 11:25:42 -0400
Received: from mail.cyclades.com ([64.186.161.6]:3779 "EHLO intra.cyclades.com")
	by vger.kernel.org with ESMTP id S264314AbUDOPZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 11:25:39 -0400
Date: Thu, 15 Apr 2004 11:53:50 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: message queue limits
Message-ID: <20040415145350.GF2085@logos.cnet>
References: <407A2DAC.3080802@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407A2DAC.3080802@redhat.com>
User-Agent: Mutt/1.5.5.1i
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2004 at 10:48:28PM -0700, Ulrich Drepper wrote:
> Something has to change in the way message queues are created.
> Currently it is possible for an unprivileged user to exhaust all mq
> slots so that only root can create a few more.  Any other unprivileged
> user has no change to create anything.
> 
> I think it is necessary to create a per-user limit instead of a
> system-wide limit.

Actually, there is no infrastructure to account for per-UID limits right now AFAICS 
(please someone correct me) at ALL. We need to account and limit for per-user

- pending signals
- message queues

And all other current limits which are per "struct task".

There is CKRM available, but I suppose its not easily mergeable and not
finished yet.

There was an effort to create simple per-user limits infrastructure called
"userbeans" at some point in 2.3.x development. Maybe it needs to be
resurrected?

This is bad.

