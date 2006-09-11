Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWIKC7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWIKC7p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 22:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWIKC7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 22:59:44 -0400
Received: from taganka54-host.corbina.net ([213.234.233.54]:19133 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S932214AbWIKC7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 22:59:44 -0400
Date: Mon, 11 Sep 2006 06:59:40 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux Containers <containers@lists.osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] vt: Rework the console spawning variables.
Message-ID: <20060911025940.GA7216@oleg>
References: <m1mz98fj16.fsf@ebiederm.dsl.xmission.com> <20060910142942.GA7384@oleg> <m18xkreb42.fsf@ebiederm.dsl.xmission.com> <20060910203324.GA121@oleg> <m1slizcouy.fsf@ebiederm.dsl.xmission.com> <20060911010534.GA108@oleg> <m17j0bcehu.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17j0bcehu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > On 09/10, Eric W. Biederman wrote:
> >>
> >> Updating this old code is painful.
> >
> > No, no, we shouldn't change the old code, it is fine.
> >
> So what happens when:
> cpu0:                         cpu1:
> kill_pid(vt_pid,....)         fn_SAK()->vc_reset()->put_pid(xchg(&vt_pid, NULL))
> 
> Can't kill_pid dereference vt_pid after put_pid is called?

Ah, I didn't consider that patch as 'old code', sorry :)

I don't understand drivers/char/vt*, but surely put_pid(xchg()) can't work.
Again, unless we have a lock to serialize access to ->vt_pid, but in that
case we don't need xchg().

Oleg.

