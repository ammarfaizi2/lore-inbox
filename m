Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261649AbSI0JNR>; Fri, 27 Sep 2002 05:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbSI0JNR>; Fri, 27 Sep 2002 05:13:17 -0400
Received: from mx2.elte.hu ([157.181.151.9]:49126 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S261649AbSI0JNQ>;
	Fri, 27 Sep 2002 05:13:16 -0400
Date: Fri, 27 Sep 2002 11:27:05 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Martin Wirth <Martin.Wirth@dlr.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] 'sticky pages' support in the VM, futex-2.5.38-C5
In-Reply-To: <3D941150.8060409@dlr.de>
Message-ID: <Pine.LNX.4.44.0209271124440.4538-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Sep 2002, Martin Wirth wrote:

> Maybe you can resurrect your approach by using a sticky counter instead
> of a flag. If there are really that many unused fields in struct page
> for the case considered here this should be possible.

well obviously it can be solved by putting more stuff into struct page,
but this whole exercise centers around trying to avoid that.

> But another point: what happens if get_user_pages (and the
> sticky-setting) is called after the fork completed? If there was no
> write access to the page between the fork and the futex call you may get
> the same race.

this is not a problem, the patch solves this, by using the 'writable' flag
to get_user_page(), which un-COWs any potential COW page.

	Ingo

