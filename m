Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266038AbUFDXCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUFDXCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266055AbUFDW65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 18:58:57 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19376 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266041AbUFDWy7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 18:54:59 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: idebus setup problem (2.6.7-rc1)
Date: Sat, 5 Jun 2004 00:58:30 +0200
User-Agent: KMail/1.5.3
Cc: Herbert Poetzl <herbert@13thfloor.at>, "Zhu, Yi" <yi.zhu@intel.com>,
       Auzanneau Gregory <mls@reolight.net>, Jeff Garzik <jgarzik@pobox.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <3ACA40606221794F80A5670F0AF15F8403BD54FE@PDSMSX403.ccr.corp.intel.com> <200406032344.19152.bzolnier@elka.pw.edu.pl> <1086323563.29391.1039.camel@bach>
In-Reply-To: <1086323563.29391.1039.camel@bach>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406050058.30845.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 of June 2004 06:32, Rusty Russell wrote:
> On Fri, 2004-06-04 at 07:44, Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 03 of June 2004 23:31, Herbert Poetzl wrote:
> > > On Thu, Jun 03, 2004 at 10:05:08PM +0800, Zhu, Yi wrote:
> > > > Rusty Russell wrote:
> > > > > Dislike this idea.  If you have hundreds of parameters, maybe it's
> > > > > supposed to be a PITA?
> > > >
> > > > What's your idea to make module_param support alterable param
> > > > names like ide3=xxx ?
> > >
> > > hmm, what about making all those something like:
> > >
> > > 	ide=3:foo,bar;4:wossname
> >
> > We are in stable kernel and in 2.7 'idex=' and 'hdx=' will die.
>
> Yes, and if you want to clean this up for 2.6, I'd recommend simply
> putting twenty module_param_call() lines.

10 for "idex="
20 for "hdx="
 1 for "idebus="
 1 for "ide="

I tried it once and result was uglier than the current behavior
(part of the problem is that MAX_HWIFS is arch/config dependent).

Why can't we apply this minimal fix from Yi for now?

--- linux-2.6.7-rc1-mm1.orig/init/main.c        2004-05-28 12:39:15.549314064 +0800
+++ linux-2.6.7-rc1-mm1/init/main.c     2004-05-28 12:40:29.399087192 +0800
@@ -162,7 +162,7 @@ static int __init obsolete_checksetup(ch
        p = &__setup_start;
        do {
                int n = strlen(p->str);
-               if (len <= n && !strncmp(line, p->str, n)) {
+               if (n == 0 || (len <= n && !strncmp(line, p->str, n))) {
                        /* Already done in parse_early_param? */
                        if (p->early)
                                return 1;

> It's ugly, but that's because it's doing ugly things, IMHO, and I don't
> think Bart would disagree?
>
> Rusty.

