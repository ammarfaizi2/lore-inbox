Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136008AbREHAFv>; Mon, 7 May 2001 20:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136017AbREHAFm>; Mon, 7 May 2001 20:05:42 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:17159 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S136008AbREHAF3>; Mon, 7 May 2001 20:05:29 -0400
Date: Mon, 7 May 2001 19:26:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071645070.7915-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105071920080.7515-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 May 2001, Linus Torvalds wrote:

> 
> On Mon, 7 May 2001, Marcelo Tosatti wrote:
> > 
> > So the "dead_swap_page" logic is _not_ buggy and you are full of shit when
> > telling Alan to revert the change. (sorry, I could not avoid this one)
> 
> Well, the problem is that the patch _is_ buggy. 
> 
> swap_writepage() does it right. And dead_swap_page does it wrong. It
> doesn't look at the swap counts, for one thing.

So lets fix it and make it look for the swap counts. 

> The patch should be reverted. The fact that other parts of the system do
> it _right_ is not an argument for mm/vmscan.c to do it wrong.

My point is that its _ok_ for us to check if the page is a dead swap cache
page _without_ the lock since writepage() will recheck again with the page
_locked_. Quoting you two messages back: 

"But it is important to re-calculate the deadness after getting the lock.
Before, it was just an informed guess. After the lock, it is knowledge."

See ? 





