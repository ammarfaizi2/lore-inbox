Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWGBUmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWGBUmz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 16:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWGBUmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 16:42:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26779 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750728AbWGBUmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 16:42:54 -0400
Date: Sun, 2 Jul 2006 13:42:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Ingo Molnar <mingo@elte.hu>, pageexec <pageexec@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] i386: clean up user_mode() use
In-Reply-To: <200607021612_MC3-1-C3FD-CC89@compuserve.com>
Message-ID: <Pine.LNX.4.64.0607021339340.12404@g5.osdl.org>
References: <200607021612_MC3-1-C3FD-CC89@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Jul 2006, Chuck Ebbert wrote:
> > > 
> > >   user_mode_vm -> user_mode
> > >   user_mode    -> user_mode_novm

No. Horrible.

I'm disgusted that somebody really would even consider something like 
this. It CHANGES SEMANTICS for the same name, which is a maintenance 
nightmare and a security bug. Now some patch assumes the new behaviour, 
gets back-ported, and is subtly broken.

If you want to get rid of the "user_mode()" thing, don't re-use the name 
with somethign that means something else.

Just do

	user_mode() -> user_mode_novm86()

instead, and leave the old macro entirely behind.

		Linus
