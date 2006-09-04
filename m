Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbWIDPXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbWIDPXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWIDPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 11:23:13 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:56500 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751466AbWIDPXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 11:23:12 -0400
Date: Mon, 4 Sep 2006 19:23:07 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andreas Hobein <ah2@delair.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Markus Gutschke <markus@google.com>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
Message-ID: <20060904152307.GA98@oleg>
References: <200608312305.47515.ah2@delair.de> <Pine.LNX.4.64.0609011117440.27779@g5.osdl.org> <20060902170323.GA369@oleg> <200609041416.03945.ah2@delair.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609041416.03945.ah2@delair.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/04, Andreas Hobein wrote:
>
> Thank you all for your kind assistance. It turned out that using vfork() or 
> clone() would make a considerable redesign of my code necessary. While the 
> added overhead from a "real" fork plus communication of the result over pipes 
> is still acceptable, I currently have a lack of time to restructure my 
> application to work with vfork or clone and its intrinsic restrictions. Also 
> some more non-portable code would be added, which discourages me a bit also.

Could you test your application with 2.6.18-rc6 and this change

	-       if (task == current)
	+       if (task->tgid == current->tgid)

reverted? I think any report, positive or negative, would be useful.

It would be nice if your test covers different conditions, such as
'main thread debugs sub-thread' and vice versa. Exec under ptrace is
also interesting.

> Since I'm rather clueless with regard to the kernel internals I'm afraid I 
> can't add more value to this discussion other than to prove there is at least 
> a second application out there being affected by this patch.

It's a pity to disappoint you, but you may be the 3rd :) Found this
unanswered message:

	http://marc.theaimsgroup.com/?l=linux-kernel&m=114073955827139

(the author cc'ed)

Oleg.

