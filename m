Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJCXrn>; Thu, 3 Oct 2002 19:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261508AbSJCXrn>; Thu, 3 Oct 2002 19:47:43 -0400
Received: from pc132.utati.net ([216.143.22.132]:58784 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S261507AbSJCXrm>; Thu, 3 Oct 2002 19:47:42 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Daniel Phillips <phillips@arcor.de>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] In-kernel module loader 1/7
Date: Thu, 3 Oct 2002 14:53:02 -0400
X-Mailer: KMail [version 1.3.1]
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
References: <20020919125906.21DEA2C22A@lists.samba.org> <20020919201140.GB17131@kroah.com> <E17w2XF-0005oW-00@starship>
In-Reply-To: <E17w2XF-0005oW-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021003235152.B41E3397@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 September 2002 11:32 am, Daniel Phillips wrote:

> Not being able to unload LSM would suck enormously.  At last count, we
> knew how to do this:
>
>   1) Unhook the function hooks (using a call table simplifies this)
>   2) Schedule on each CPU to ensure all tasks are out of the module
>   3) A schedule where the module count is incremented doesn't count
>
> and we rely on the rule that and module code that could sleep must be
> bracketed by inc/dec of the module count.
>
> Did somebody come up with a reason why this will not work?

Preemption?

Scheduling doesn't guarantee making any specific amount of progress within 
the kernel with preemption enabled.  I thought the preferred strategy was to 
wait for the time slices to refill and then exhaust (since everybody has to 
exhaust their time slices before anybody gets new ones.  Unless I've missed 
something...?)

Rob
