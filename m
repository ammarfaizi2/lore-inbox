Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVE3SAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVE3SAo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbVE3SAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:00:44 -0400
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:54030 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S261659AbVE3SAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:00:37 -0400
Message-ID: <429B54C4.7080601@cr0.org>
Date: Mon, 30 May 2005 20:00:36 +0200
From: Julien TINNES <julien-lkml@cr0.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Linux-2.4.30-hf3
References: <20050529223739.GA27341@exosec.fr> <20050530050746.GK18600@alpha.home.local> <20050530112449.GA5046@logos.cnet>
In-Reply-To: <20050530112449.GA5046@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2005 18:00:34.0149 (UTC) FILETIME=[79D94950:01C56541]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Huh? I fail to see how that one is exploitable, given that no in-tree callers 
> should pass "tty" as NULL to any of the affected functions (that is impossible, 
> AFAICS).
> 
> No? Julien?

That's correct, this one does'nt seem to be exploitable.

What I said is that the bug "class" (null pointer dereference) must not
be seen as potential oopses and denial or services.
As the first page is mappable, that can allow a user to gain control
over some kernel datas.


> Well, it requires root priveledges:

> +    if (!len) return -EINVAL;> 
>      if ( !suser () ) return -EPERM;   <---------------
> 
> So, its "safe".

Well it's certainly not the worse bug ever, but root should'nt be able
to gain control over the kernel that way.
There are security models where root should'nt have that power: for
example with SELinux, LIDS, RSBAC, GRsecurity you can have such a model
where beeing root is not enough to gain control over the kernel.

Ok, the access control system should maybe prevent most processes to
access mtrrs as well anyway ;)
