Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbWB1RUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWB1RUr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWB1RUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:20:47 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:64996 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932256AbWB1RUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:20:46 -0500
Message-ID: <44048660.3010701@sgi.com>
Date: Tue, 28 Feb 2006 18:20:32 +0100
From: Jes Sorensen <jes@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: "Bryan O'Sullivan" <bos@pathscale.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
References: <1140841250.2587.33.camel@localhost.localdomain>	<yq08xrvhkee.fsf@jaguar.mkp.net> <adar75nlcar.fsf@cisco.com>	<44047565.3090202@sgi.com> <adafym3l8lk.fsf@cisco.com>
In-Reply-To: <adafym3l8lk.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>     Jes> Not quite correct as far as I understand it. mmiowb() is
>     Jes> supposed to guarantee that writes to MMIO space have
>     Jes> completed before continuing.  That of course covers the
>     Jes> multi-CPU case, but it should also cover the write-combining
>     Jes> case.
> 
> I don't believe this is correct.  mmiowb() does not guarantee that
> writes have completed -- they may still be pending in a buffer in a
> bridge somewhere.  The _only_ effect of mmiowb() is to make sure that
> writes which have been ordered between CPUs using some other mechanism
> (i.e. a lock) are properly ordered by the rest of the system.  This
> only has an effect systems like very large ia64 systems, where (as I
> understand it), writes can pass each other on the way to the PCI bus.
> In fact, mmiowb() is a NOP on essentially every architecture.

Hmmmm

That could be, seems like Jesse agrees that it could all be in the
pipeline somewhere. Considering Jesse was responsible for mmiowb() I'll
take his word for it ;-)

In any case, I'd strongly recommend that any new barrier version is
clearly documented. The jungle is very dense already ;(

Cheers,
Jes
