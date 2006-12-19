Return-Path: <linux-kernel-owner+w=401wt.eu-S933001AbWLSVSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933001AbWLSVSu (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933000AbWLSVSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:18:49 -0500
Received: from iabervon.org ([66.92.72.58]:3296 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933001AbWLSVSt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:18:49 -0500
Date: Tue, 19 Dec 2006 16:18:47 -0500 (EST)
From: Daniel Barkalow <barkalow@iabervon.org>
To: John M Flinchbaugh <john@hjsoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: forcedeth trouble in 2.6.19(.1)
In-Reply-To: <20061219122447.GA23367@hjsoft.com>
Message-ID: <Pine.LNX.4.64.0612191600300.20138@iabervon.org>
References: <20061219122447.GA23367@hjsoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006, John M Flinchbaugh wrote:

> I saw a mention of interrupt handling for forcedeth cards is the
> 2.6.19.1 changelog, but I still see this error in 2.6.19.1.  It started
> in 2.6.19, and it didn't happen in 2.6.18.1.

Nope; the issue fixed in 2.6.19.1 has always existed (provided you had 
hardware suitable to trigger it). And it was an issue of getting bogus 
legacy interrupts when using MSI, which would lead to some other device on 
the same legacy interrupt getting disabled.

I'd suggest reverting 0a07bc645e818b88559d99f52ad45e35352e8228 (fixes a 
lockdep warning, stuff with interrupts, only build tested) as a first 
guess.

	-Daniel
*This .sig left intentionally blank*
