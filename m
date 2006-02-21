Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWBUQh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWBUQh1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 11:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWBUQh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 11:37:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:64217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932315AbWBUQh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 11:37:26 -0500
Date: Tue, 21 Feb 2006 11:37:10 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>, Paul Jackson <pj@sgi.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] lightweight robust futexes: -V4
Message-ID: <20060221163710.GX24295@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060221084631.GA5506@elte.hu> <20060221092338.GV24295@devserv.devel.redhat.com> <a36005b50602210826i567effabsd4b43da9804db86d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50602210826i567effabsd4b43da9804db86d@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 08:26:05AM -0800, Ulrich Drepper wrote:
> > The `len' argument (or really revision of the structure if really needed)
> > can be encoded in the structure, as in:
> > struct robust_list_head {
> >        struct robust_list list;
> >        short robust_list_head_len; /* or robust_list_head_version ? */
> >        short futex_offset;
> >        struct robust_list __user *list_op_pending;
> > };
> > or with long futex_offset, but using say upper 8 bits of the field as
> > version or length.
> 
> I know you want to save SPARC but this kind of overloading I don't
> really like.  If you need special treatment of the futex value make
> this explicit and arch-dependent.

This had nothing to do with SPARC actually, I only wanted to avoid
passing two extra arguments to clone rather than one.  But if you think
CLONE_CHILD_SETROBUST is unnecessary, so be it and the combined
set_tid_robust_address call can have tidptr, robustptr and robustlen
arguments.

	Jakub
