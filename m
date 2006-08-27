Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932255AbWH0Uyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255AbWH0Uyz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 16:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWH0Uyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 16:54:54 -0400
Received: from ns2.suse.de ([195.135.220.15]:20698 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932065AbWH0Uyx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 16:54:53 -0400
From: Andi Kleen <ak@suse.de>
To: "Dong Feng" <middle.fengdong@gmail.com>
Subject: Re: Why Semaphore Hardware-Dependent?
Date: Sun, 27 Aug 2006 22:52:48 +0200
User-Agent: KMail/1.9.3
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Christoph Lameter" <clameter@sgi.com>, linux-kernel@vger.kernel.org
References: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
In-Reply-To: <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608272252.48946.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 August 2006 21:22, Dong Feng wrote:
> Why can't we have a hardware-independent semaphore definition while we
> have already had hardware-dependent spinlock, rwlock, and rcu lock? It

We probably could yes, if up/down were out of lined. The only
reason it is assembly code is that it uses still funky assembly
to get a fast uncontended fast path. Since out of lining
worked for spinlocks it will likely work for semaphores too.

> seems the semaphore definitions classified into two major categories.
> The main deference is whether there is a member variable _sleeper_.
> Does this (optional) member indicate any hardware family gene?

AFAIK the normal semaphores all work basically the same over the
architectures, just the calling conventions are different. If it was
pure out of line C that wouldn't be a problem anymore.

rwsems don't -- there are two flavours: a generic spinlock'ed one and a 
complicated atomic based one that only works on some architectures. 
As far as I know nobody has demonstrated a clear performance increase
from the first so it might be possible to switch all to the generic
implementation.

If you're interested in this you should probably do patches and benchmarks.

-Andi
