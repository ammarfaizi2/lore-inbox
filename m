Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVDEVD2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVDEVD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 17:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVDEVDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 17:03:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:40684 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262028AbVDEVCR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 17:02:17 -0400
Date: Tue, 5 Apr 2005 14:04:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <20050405204436.GA31523@elte.hu>
Message-ID: <Pine.LNX.4.58.0504051401350.2215@ppc970.osdl.org>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
 <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru>
 <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <20050405204436.GA31523@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Apr 2005, Ingo Molnar wrote:
> 
>  esi: 009b63f9   edi: 00000001   ebp: f543a000   esp: f543bfc8
> 
> i.e. esp & 0xfff was 0xfc8 - while i think it should normally be 0xfc4 
> (page boundary minus size of pt_regs == 0 - 0x3c == 0xfc4). So somewhere 
> we lost 4 bytes of esp? An extra popl, or an addl $4, %esp? But why dont 
> we crash in that case

Normally, esp will be immediately reset by any user-land stuff: we'll 
forget the old kernel stack entirely, and always re-load esp from the esp0 
thing in the TSS.

And as long as we stay in kernel land, we'll obviously never touch the
esp/xss fields of pt_regs (except in this special case of doing the
speculative load of xss), so...

		Linus
