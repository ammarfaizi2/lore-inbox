Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVDETYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVDETYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVDETVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:21:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:18366 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261898AbVDETSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:18:00 -0400
Date: Tue, 5 Apr 2005 12:19:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <4252E2C9.9040809@aknet.ru>
Message-ID: <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Apr 2005, Stas Sergeev wrote:
> 
> Attached is a quick fix, which I'll be
> testing to death tomorrow at work.

This one can pass through vm86 mode stuff without the high-16-bit fixup, 
as far as I can tell.

Also, I think your optimization to optimistically load SS is valid per se,
but we need to find out how some kernel thread gets zero stack associated
with it. They should all have the full "struct pt_reg" as far as I could
see, which means that we should never be _so_ high up the stack that 
SS/ESP would be on the next page.

So I'd actually prefer to get that mystery explained..

		Linus
