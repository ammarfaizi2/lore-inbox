Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291630AbSBHQJy>; Fri, 8 Feb 2002 11:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291628AbSBHQJo>; Fri, 8 Feb 2002 11:09:44 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:10238 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S291625AbSBHQJc>; Fri, 8 Feb 2002 11:09:32 -0500
Date: Fri, 8 Feb 2002 11:09:30 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch] larger kernel stack (8k->16k) per task
Message-ID: <20020208110930.C1429@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.33.0202081559240.1359-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0202081559240.1359-100000@einstein.homenet>; from tigran@veritas.com on Fri, Feb 08, 2002 at 04:06:35PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 04:06:35PM +0000, Tigran Aivazian wrote:
> Hi Arjan,
> 
> > Also it's the wrong approach. The right approach (as done by Manfred and
> > David) is
> > to put "current" no longer on this stack just a pointer to current.
> 

> You are saying that the right approach is to move "current" off the stack.
> The right approach to what? Surely not to saving kernel stack because
> "current" (being merely a struct task_struct) is not a major eater of the
> stack.

1.5Kb... that's quite a lot on 8Kb

> Those functions which declare 5-6k of local variables are (if
> there are still any left).

There are none. And if there are they are very easy to find and fix.


> Speaking of which, I will also answer Rik --
> the offenders (that "VERY VERY sick code" Arjan refers to) we found were
> in LKCD so it's been fixed ages ago.

LKCD is not part of the normal kernel, and in some parts could fall under
"VER VERY sick"; esp if they indeed use 6Kb stack.

> So, moving struct task_struct is irrelevant, really. Unless you meant
> something completely different and if so I look forward to your

Apparently you see stackoverflows with some code. Well, 1.5Kb (approx)
is some win there (although most of that is reserved for stack coloring).

If you need even more in your code (I assume you do otherwise you wouldn't
have done the work) then I really suggest you take a long hard look and fix
the obvious bugs or the design....

Greetings,
   Arjan van de Ven


