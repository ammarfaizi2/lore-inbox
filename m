Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275234AbTHRWzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275235AbTHRWy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:54:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:10628 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S275234AbTHRWyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:54:51 -0400
Date: Mon, 18 Aug 2003 15:48:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Valdis.Kletnieks@vt.edu
Cc: kernel@theoesters.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] Ratelimit SO_BSDCOMPAT warnings
Message-Id: <20030818154800.21ae818e.davem@redhat.com>
In-Reply-To: <200308182215.h7IMFecc013449@turing-police.cc.vt.edu>
References: <20030818150605.A23957@ns1.theoesters.com>
	<200308182215.h7IMFecc013449@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003 18:15:40 -0400
Valdis.Kletnieks@vt.edu wrote:

> On Mon, 18 Aug 2003 15:06:05 PDT, Phil Oester said:
> >  static void sock_warn_obsolete_bsdism(const char *name)
> >  {
> > -       printk(KERN_WARNING "process `%s' is using obsolete "
> > -              "%s SO_BSDCOMPAT\n", current->comm, name);
> > +       static int warned;
> > +
> > +       if (!warned) {
> > +               warned = 1;
> 
> Umm.. am I dense, or does this only warn once for *the first program*
> to do it after the system boots?  And you don't get another warning about
> any OTHER programs until you reboot in a few weeks (possibly)?

Yes, this patch does suck hard.

I see no reason to apply this, just fix your apps and the
warning will stop.  There's only a handful of programs
that trigger this at all.

