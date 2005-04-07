Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVDGQxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVDGQxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbVDGQxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:53:37 -0400
Received: from fire.osdl.org ([65.172.181.4]:26569 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262528AbVDGQxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:53:25 -0400
Date: Thu, 7 Apr 2005 09:55:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <425563D6.30108@aknet.ru>
Message-ID: <Pine.LNX.4.58.0504070951570.28951@ppc970.osdl.org>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
 <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru>
 <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru>
 <20050407080004.GA27252@elte.hu> <42555BBF.6090704@aknet.ru>
 <Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org> <425563D6.30108@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Stas Sergeev wrote:
>
> 1. Does the "later sti" fixes the problem
> also in case of an NMI? I mean, why can't
> you just be NMI'ed before you did sti?
> NMI uses the restore_all too IIRC.

The NMI code had better be really careful, and yeah, I suspect it needs 
fixing.

> 2. How can one be sure there are no more
> of the like places where the stack is left
> empty?

That's a good argument, and may be the strongest reason for _not_ doing 
the speculation. However, I don't think it really can happen anywhere 
else. 

If people feel very nervous about the speculation, we can certainly just 
make it do the two branches. It _is_ a hotspot, though, and the 
optimization of the speculatiom may well be worth it.


		Linus
