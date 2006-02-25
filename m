Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWBYN0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWBYN0a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 08:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbWBYN03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 08:26:29 -0500
Received: from cantor.suse.de ([195.135.220.2]:11414 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030236AbWBYN03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 08:26:29 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Sat, 25 Feb 2006 14:28:01 +0100
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <200602250543.22421.ak@suse.de> <1140852894.2587.43.camel@localhost.localdomain>
In-Reply-To: <1140852894.2587.43.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251428.01767.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 08:34, Bryan O'Sullivan wrote:
> On Sat, 2006-02-25 at 05:43 +0100, Andi Kleen wrote:
> > On Saturday 25 February 2006 05:20, Bryan O'Sullivan wrote:
> > > On some platforms, a regular wmb() is not sufficient to guarantee that
> > > PCI writes have been flushed to the bus if write combining is in
> > > effect.
> >
> > On what platforms?
>
> On x86_64 in particular, if CONFIG_UNORDERED_IO is defined. 

I guess you mean undefined.

> Regular 
> wmb() is implemented as a compiler memory barrier then, which isn't
> sufficient for PCI write combining.

It's still totally unclear how you can write portable write combining code.

I think the basic idea is weird. You're basically writing something
that doesn't follow the normal MMIO rules of Linux drivers and you're 
trying to do this portable, which won't work anyways because 
there is no portable way to do this.

Before we can add such a macro I suspect you would first 
need to provide some spec how that "portable write combining"
is supposed to work and get feedback from the other architectures.

Or keep it in architecture specific code, then the generic macro
isn't needed.

-Andi
