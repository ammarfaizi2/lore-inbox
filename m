Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbTFJPuN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263234AbTFJPuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 11:50:13 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:60681 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S263199AbTFJPtd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 11:49:33 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Jeff Garzik <jgarzik@pobox.com>,
       Geller Sandor <wildy@petra.hos.u-szeged.hu>
Subject: Re: [PATCH 2/2] xirc2ps_cs update
Date: Tue, 10 Jun 2003 16:01:02 -0400
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <200306101524.15648.daniel.ritz@gmx.ch> <Pine.LNX.4.44.0306101731200.10841-100000@petra.hos.u-szeged.hu> <20030610154655.GA1959@gtf.org>
In-Reply-To: <20030610154655.GA1959@gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306101601.02879.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 June 2003 11:46, Jeff Garzik wrote:
> On Tue, Jun 10, 2003 at 05:35:18PM +0200, Geller Sandor wrote:
> > On Tue, 10 Jun 2003, Daniel Ritz wrote:
> > > -    busy_loop(HZ/25);		     /* wait 40 msec */
> > > +    Wait(HZ/25);		     /* wait 40 msec */
> >
> > Why not Wait(40); instead Wait(HZ/25) ? Currently HZ is 1000. However,
> > the value can change - as it changed from 100 to 1000.
>
> True enough...  the best solution is to grep the tree for a
> msecs_to_jiffies macro, and use that.  Then it will look like
>

hmm...yes, but the macro is defined in include/net/irda/irda.h
move it to a place where everyone can use it? like time.h or kernel.h?

> 	Wait(msecs_to_jiffies(40))

i would do it in the Wait macro. looks nicer..
and also define the Wait macro (with a better name, suggestions?)
somewhere else, 'cos other drivers use set_current_state(); schedule_timeout()
too..

>
> and the macro does the proper scaling versus constant HZ.
>
> 	Jeff

-daniel

