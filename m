Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVCWTAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVCWTAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 14:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVCWTAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 14:00:43 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:56198 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261764AbVCWTAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 14:00:33 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Ram <linuxram@us.ibm.com>
To: johnpol@2ka.mipt.ru
Cc: Jay Lan <jlan@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Erich Focht <efocht@hpce.nec.com>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>
In-Reply-To: <1111557106.23532.65.camel@uganda>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>
	 <1111475252.8465.23.camel@frecb000711.frec.bull.fr>
	 <1111515979.5860.57.camel@localhost>
	 <20050322222201.0fa25d34@zanzibar.2ka.mipt.ru>
	 <4240AF8B.4000102@engr.sgi.com>  <1111554065.23532.61.camel@uganda>
	 <1111557106.23532.65.camel@uganda>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1111604426.7103.157.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Mar 2005 11:00:26 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-22 at 21:51, Evgeniy Polyakov wrote:
> On Wed, 2005-03-23 at 08:01 +0300, Evgeniy Polyakov wrote:
> > On Tue, 2005-03-22 at 15:51 -0800, Jay Lan wrote:
> > 
> 
> > > I see this issue less a case of bad guys vs. good guys. I see it
> > > as various components doing system related work, but there is
> > > no mechanism of knowing who is on who is off by today's patch. A
> > > service listening to the fork connector can request to turn off
> > > cn_fork_enable on exit and inadquately affect other services/daemons
> > > listening to the same connector. It is not acceptable in my opinion.
> > 
> > It is super-user who only is allowed to turn it off and even listen for
> > events,
> > since only super-user is allowed to bind socket to multicast netlink
> > group.
> > Super-user should not be allowed to control it's system?
> 
> BTW, super-user can unload fork connector module, and none listener
> will even know about it, it just stops to receive notification.

I see your point. Since the application has to be super-user to turn it
off, and since super-user applications are trusted not to mis-behave,
the current mechanism is relatively safe. I guess its the amount of
checks you put in place,  to prevent inadvertent shooting-in-the-foot.

There is nothing one can do if the fork_connector module is yanked out.
However there is something one can do, to prevent any arbitrary
application from shutting down the fork-event stream. I think I can live
with the current mechanism, under the assumption that no fork-event
listner has a legitate reason to shut down the fork-event-stream. 

RP



