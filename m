Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbVCVSoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbVCVSoY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 13:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVCVSns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 13:43:48 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49051 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261630AbVCVSki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 13:40:38 -0500
Subject: Re: [patch 1/2] fork_connector: add a fork connector
From: Ram <linuxram@us.ibm.com>
To: johnpol@2ka.mipt.ru
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Jay Lan <jlan@engr.sgi.com>,
       Erich Focht <efocht@hpce.nec.com>, Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>
In-Reply-To: <1111466196.23532.17.camel@uganda>
References: <1111050243.306.107.camel@frecb000711.frec.bull.fr>
	 <200503170856.57893.jbarnes@engr.sgi.com>
	 <20050318003857.4600af78@zanzibar.2ka.mipt.ru>
	 <200503171405.55095.jbarnes@engr.sgi.com>
	 <1111409303.8329.16.camel@frecb000711.frec.bull.fr>
	 <1111438349.5860.27.camel@localhost>  <1111466196.23532.17.camel@uganda>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1111516831.5860.65.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 22 Mar 2005 10:40:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 20:36, Evgeniy Polyakov wrote:
> On Mon, 2005-03-21 at 12:52 -0800, Ram wrote:
> > On Mon, 2005-03-21 at 04:48, Guillaume Thouvenin wrote:
> > > ChangeLog:
> > > 
> > >   - Remove the global cn_fork_lock and replace it by a per CPU 
> > >     counter. 
> > >   - The processor ID has been added in the data part of the message.
> > >     Thus datas sent in a message are: "CPU_ID PARENT_PID CHILD_PID"
> > > 
> > >   Those modifications were done to be more scalable because, as
> > > mentioned by Jesse Barnes, the global cn_fork_lock won't work well on a
> > > large CPU system.
> > > 
> > >   This patch applies to 2.6.11-mm4.
> > Guillaume,
> > 
> >      If a bunch of applications are listening for fork events, 
> >      your patch allows any application to turn off the 
> >      fork event notification?  Is this the right behavior?
> > 
> >      Should'nt it turn off the fork-event notification when 
> >      the number of listeners become zero?
> 
> There is no number of listeners - netlink sockets provide multicast
> dataflow.
> [Although one can obtain that number].
> 
> As far as I can see, Guillaume's application is main management utility
> - 

Yes. agreed. But again nothing stops one of the many application
listening on the multicast events from stopping the fork-events.

Even though Guillame's application claims itself the main management
utility, nothing stops another application from assuming the management
role.

I think if the the connector infrastructure provides a administrative
kind of channel, (the one I mentioned in the reply to Guillame) that
should help get better control on the management aspects of the
event stream.

RP
> 
> it can turn on or off some feature, like "ip" can turn on or off
> interfaces 
> without waiting when bounded processes decide to exit.


> > RP

