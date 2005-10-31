Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVJaPAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVJaPAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVJaPAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:00:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:35275 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750836AbVJaPAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:00:35 -0500
Subject: Re: PATCH: EDAC - clean up atomic stuff
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
References: <1129902050.26367.50.camel@localhost.localdomain>
	 <m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Oct 2005 15:30:28 +0000
Message-Id: <1130772628.9145.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-10-28 at 10:33 -0600, Eric W. Biederman wrote:
> A couple of questions
> - Why a u32 for length and not just unsigned?

Because it was loading it into a 32bit counter so the input was 32bit.
Just habit really.

> - Why is the x86_64 version clearing 32bit words and not 64bit words,
>   that should be noticeably faster if we ever need to use that
>   code.

I doubt it makes much difference. I kept it 32bit to keep the split
simple. It can certainly be optimised if someone wants to. I'd hope
however ECC scrub is never a hot path!

> - Is KM_BOUNCE_READ a safe atomic_kmap entry to be using?
>   I'm not certain, but my gut feel is that scrubbing probably
>   wants it's own kmap type. 
>   I remember doing some looking when I first wrote this and thinking
>   that KM_BOUNCE_READ looked safe and was good enough until the code
>   got merged into the kernel.

I was looking at that. I think it is but I'm not 100% sure or an expert
on kmaps.


