Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261901AbVBUGxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVBUGxY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 01:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVBUGxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 01:53:24 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:61836 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261901AbVBUGxU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 01:53:20 -0500
Subject: Re: A common layer for Accounting packages
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Jay Lan <jlan@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
In-Reply-To: <20050218171610.757ba9c9.akpm@osdl.org>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org>
Date: Mon, 21 Feb 2005 07:51:21 +0100
Message-Id: <1108968681.8398.44.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 08:00:12,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 21/02/2005 08:02:12,
	Serialize complete at 21/02/2005 08:02:12
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-18 at 17:16 -0800, Andrew Morton wrote:
> Jay Lan <jlan@sgi.com> wrote:
> >
> > Since the need of Linux system accounting has gone beyond what BSD
> > accounting provides, i think it is a good idea to create a thin layer
> > of common code for various accounting packages, such as BSD accounting,
> > CSA, ELSA, etc. The hook to do_exit() at exit.c was changed to invoke
> > a routine in the common code which would then invoke those accounting
> > packages that register to the acct_common to handle do_exit situation.
> 
> This all seems to be heading in the wrong direction.  Do we really want to
> have lots of different system accounting packages all hooking into a
> generic we-cant-decide-what-to-do-so-we-added-some-pointless-overhead
> framework?
> 
> Can't we get _one_ accounting system in there, get it right, avoid the
> framework?

  Is it possible to just merge the BSD accounting and the CSA accounting
by adding in the current BSD per-process accounting structure some
missing fields like the mm integral provided by the CSA patch?

ELSA is just a user of the accounting data. We need a hook in the
do_fork() routine to manage group of processes, not to do accounting. 

Guillaume

